package main

import (
	"bufio"
	"bytes"
	"context"
	"crypto/sha256"
	"encoding/gob"
	"encoding/hex"
	"fmt"
	"github.com/go-redis/redis/v8"
	"github.com/karrick/godirwalk"
	"os"
	"path/filepath"
	"sort"
	"sync"
	"sync/atomic"
	"time"
)

var progressCounter int32 // Progress counter
var rdb *redis.Client     // Redis client
var ctx = context.Background()

// FileInfo holds file information
type FileInfo struct {
	Size    int64
	ModTime time.Time
}

var wg sync.WaitGroup
var workerPool = make(chan struct{}, 20) // Limit concurrency to 20

// Initialize Redis client
func init() {
	rdb = redis.NewClient(&redis.Options{
		Addr: "localhost:6379",
	})
	_, err := rdb.Ping(ctx).Result()
	if err != nil {
		fmt.Println("Error connecting to Redis:", err)
		os.Exit(1)
	}
}

// Generate a SHA-256 hash for the given string
func generateHash(s string) string {
	hasher := sha256.New()
	hasher.Write([]byte(s))
	return hex.EncodeToString(hasher.Sum(nil))
}

func loadExcludePatterns(filename string) ([]string, error) {
	file, err := os.Open(filename)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	var patterns []string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		patterns = append(patterns, scanner.Text())
	}
	return patterns, scanner.Err()
}

func saveToFile(dir, filename string, sortByModTime bool) error {
	file, err := os.Create(filepath.Join(dir, filename))
	if err != nil {
		return err
	}
	defer file.Close()

	iter := rdb.Scan(ctx, 0, "*", 0).Iterator()
	var data = make(map[string]FileInfo)
	for iter.Next(ctx) {
		hashedKey := iter.Val()
		originalPath, err := rdb.Get(ctx, "path:"+hashedKey).Result()
		if err != nil {
			continue
		}
		value, err := rdb.Get(ctx, hashedKey).Bytes()
		if err != nil {
			continue
		}
		var fileInfo FileInfo
		buf := bytes.NewBuffer(value)
		dec := gob.NewDecoder(buf)
		if err := dec.Decode(&fileInfo); err == nil {
			data[originalPath] = fileInfo
		}
	}

	var keys []string
	for k := range data {
		keys = append(keys, k)
	}

	sortKeys(keys, data, sortByModTime)

	for _, k := range keys {
		relativePath, _ := filepath.Rel(dir, k)
		if sortByModTime {
			utcTimestamp := data[k].ModTime.UTC().Unix()
			fmt.Fprintf(file, "%d,\"./%s\"\n", utcTimestamp, relativePath)
		} else {
			fmt.Fprintf(file, "%d,\"./%s\"\n", data[k].Size, relativePath)
		}
	}
	return nil
}

func sortKeys(keys []string, data map[string]FileInfo, sortByModTime bool) {
	if sortByModTime {
		sort.Slice(keys, func(i, j int) bool {
			return data[keys[i]].ModTime.After(data[keys[j]].ModTime)
		})
	} else {
		sort.Slice(keys, func(i, j int) bool {
			return data[keys[i]].Size > data[keys[j]].Size
		})
	}
}

func processFile(path string, typ os.FileMode) {
	defer wg.Done()
	<-workerPool // Get an empty struct from workerPool to limit concurrency

	if typ.IsDir() {
		return
	}

	info, err := os.Stat(path)
	if err != nil {
		fmt.Printf("Error stating file: %s, Error: %s\n", path, err)
		return
	}

	var buf bytes.Buffer
	enc := gob.NewEncoder(&buf)
	if err := enc.Encode(FileInfo{Size: info.Size(), ModTime: info.ModTime()}); err != nil {
		fmt.Printf("Error encoding: %s, File: %s\n", err, path)
		return
	}

	// Generate hash for the file path
	hashedKey := generateHash(path)

	// 使用管道批量处理Redis命令
	pipe := rdb.Pipeline()

	// 这里我们添加命令到管道，但不立即检查错误
	pipe.Set(ctx, hashedKey, buf.Bytes(), 0)
	pipe.Set(ctx, "path:"+hashedKey, path, 0)

	if _, err = pipe.Exec(ctx); err != nil {
		fmt.Printf("Error executing pipeline for file: %s: %s\n", path, err)
		return
	}

	// Update progress counter atomically
	atomic.AddInt32(&progressCounter, 1)

	workerPool <- struct{}{} // Release limit
}

func main() {
	// Initialize workerPool
	for i := 0; i < 20; i++ {
		workerPool <- struct{}{}
	}

	if len(os.Args) < 2 {
		fmt.Println("Usage: ./find_large_files_with_cache <directory>")
		return
	}

	// Root directory to start the search
	rootDir := os.Args[1]
	
	// Minimum file size in bytes
	minSize := 200 // Default size is 200MB
	minSizeBytes := int64(minSize * 1024 * 1024)

	excludePatterns, err := loadExcludePatterns(filepath.Join(rootDir, "exclude_patterns.txt"))
	if err != nil {
		fmt.Println("Warning: Could not read exclude patterns:", err)
	}

	// Start a goroutine to periodically print progress
	go func() {
		for {
			time.Sleep(1 * time.Second)
			fmt.Printf("Progress: %d files processed.\n", atomic.LoadInt32(&progressCounter))
		}
	}()

	// Use godirwalk.Walk instead of fastwalk.Walk or filepath.Walk
	err = godirwalk.Walk(rootDir, &godirwalk.Options{
		Callback: func(osPathname string, de *godirwalk.Dirent) error {
			// Check if the path should be excluded
			for _, pattern := range excludePatterns {
				match, err := filepath.Match(pattern, osPathname)
				if err != nil {
					fmt.Printf("Error matching pattern: %s, Error: %s\n", pattern, err)
					continue
				}
				if match {
					fmt.Printf("Excluding file: %s\n", osPathname) // 打印被排除的文件
					return nil
				}
			}

			fileInfo, err := os.Lstat(osPathname)
			if err != nil {
				fmt.Printf("Error getting file info: %s\n", err)
				return err
			}

			if fileInfo.Size() < minSizeBytes {
				return nil
			}

			if fileInfo.Mode().IsDir() {
				fmt.Printf("Entering directory: %s\n", osPathname)
				// 可以添加目录处理逻辑
			} else if fileInfo.Mode().IsRegular() {
				fmt.Printf("Processing file: %s\n", osPathname)
				wg.Add(1)
				go processFile(osPathname, fileInfo.Mode())
			} else if fileInfo.Mode()&os.ModeSymlink != 0 {
				fmt.Printf("Found symlink: %s\n", osPathname)
				// 可以添加软链接处理逻辑
			} else {
				fmt.Printf("Skipping unknown type: %s\n", osPathname)
				// 对于未知类型，您可以选择跳过或处理
			}
			return nil
		},
		Unsorted: true,
	})

	wg.Wait()
	fmt.Printf("Final progress: %d files processed.\n", atomic.LoadInt32(&progressCounter))

	if err := saveToFile(rootDir, "fav.log", false); err != nil {
		fmt.Printf("Error saving to fav.log: %s\n", err)
	} else {
		fmt.Printf("Saved data to %s\n", filepath.Join(rootDir, "fav.log"))
	}

	if err := saveToFile(rootDir, "fav.log.sort", true); err != nil {
		fmt.Printf("Error saving to fav.log.sort: %s\n", err)
	} else {
		fmt.Printf("Saved sorted data to %s\n", filepath.Join(rootDir, "fav.log.sort"))
	}
}
