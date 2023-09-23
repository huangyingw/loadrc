package main

import (
	"bufio"
	"bytes"
	"context"
	"encoding/gob"
	"fmt"
	"github.com/go-redis/redis/v8"
	"os"
	"path/filepath"
	"sort"
	"strings"
	"sync"
	"sync/atomic"
	"time"
)

var progressCounter int32 // 进度计数器，使用 int32 或 int64 类型
var rdb *redis.Client     // 使用Redis作为全局缓存
var ctx = context.Background()

// FileInfo holds the information about a file
type FileInfo struct {
	Size    int64
	ModTime time.Time
}

// FileCache to store file information
type FileCache map[string]FileInfo

var cacheMutex = &sync.Mutex{}
var wg sync.WaitGroup
var workerPool = make(chan struct{}, 20) // 限制并发数量为20

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

func saveToFile(dir, filename string, data FileCache, sortByModTime bool) error {
	file, err := os.Create(filepath.Join(dir, filename))
	if err != nil {
		return err
	}
	defer func() {
		if closeErr := file.Close(); closeErr != nil {
			fmt.Println("Error closing file:", closeErr)
		}
	}()

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

func sortKeys(keys []string, data FileCache, sortByModTime bool) {
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

func processFile(path string, info os.FileInfo, fileCache FileCache, minSizeBytes int64) {
	defer wg.Done()
	<-workerPool // 从workerPool获取一个空结构体，限制并发

	fmt.Printf("Processing file: %s\n", path) // 添加日志

	if info.IsDir() {
		fmt.Printf("Skipping directory: %s\n", path) // 添加日志
		return
	}

	if info.Size() > minSizeBytes {
		var buf bytes.Buffer
		enc := gob.NewEncoder(&buf)
		if err := enc.Encode(FileInfo{Size: info.Size(), ModTime: info.ModTime()}); err != nil {
			fmt.Printf("Error encoding: %s, File: %s\n", err, path) // 添加日志
			return
		}

		err := rdb.Set(ctx, path, buf.Bytes(), 0).Err()
		if err != nil {
			fmt.Printf("Error setting Redis key: %s, File: %s\n", err, path) // 添加日志
			return
		}

		// 使用原子操作更新进度计数器
		atomic.AddInt32(&progressCounter, 1)
		fmt.Printf("File processed: %s\n", path) // 添加日志
	} else {
		fmt.Printf("File size too small, skipping: %s\n", path) // 添加日志
	}

	workerPool <- struct{}{} // 将空结构体放回workerPool，释放限制
}

func main() {
	fileCache := make(FileCache)

	// 初始化workerPool
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
	minSize := 200 // 默认大小为200MB
	minSizeBytes := int64(minSize * 1024 * 1024)

	excludePatterns, err := loadExcludePatterns(filepath.Join(rootDir, "exclude_patterns.txt"))
	if err != nil {
		fmt.Println("Warning: Could not read exclude patterns:", err)
		// You can return here if you want to terminate the program
		// return
	}

	// 启动一个 goroutine 来定期打印进度
	go func() {
		for {
			time.Sleep(1 * time.Second) // 每秒更新一次

			// 使用原子操作读取进度计数器
			currentProgress := atomic.LoadInt32(&progressCounter)
			fmt.Printf("Progress: %d files processed.\n", currentProgress)
		}
	}()

	// Walk the file tree
	err = filepath.Walk(rootDir, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}

		// 检查是否应该排除该路径
		for _, pattern := range excludePatterns {
			if strings.Contains(path, pattern) {
				return nil
			}
		}

		wg.Add(1)
		go processFile(path, info, fileCache, minSizeBytes) // 使用goroutine
		return nil
	})

	if err != nil {
		fmt.Println("Error walking the file tree:", err)
		return
	}

	wg.Wait()

	// 输出最终的计数器值
	finalProgress := atomic.LoadInt32(&progressCounter)
	fmt.Printf("Final progress: %d files processed.\n", finalProgress)

	// 从Redis中读取数据并保存到文件的逻辑应该放在这里
	iter := rdb.Scan(ctx, 0, "*", 0).Iterator()
	for iter.Next(ctx) {
		key := iter.Val()
		data, err := rdb.Get(ctx, key).Bytes()
		if err == nil {
			var fileInfo FileInfo
			buf := bytes.NewBuffer(data)
			dec := gob.NewDecoder(buf)
			if err := dec.Decode(&fileInfo); err == nil {
				fileCache[key] = fileInfo
			}
		}
	}

	// 使用fileCache保存文件
	if err := saveToFile(rootDir, "fav.log", fileCache, false); err != nil {
		fmt.Println("Error saving to fav.log:", err)
	} else {
		fmt.Printf("Saved to %s\n", filepath.Join(rootDir, "fav.log"))
	}

	if err := saveToFile(rootDir, "fav.log.sort", fileCache, true); err != nil {
		fmt.Println("Error saving to fav.log.sort:", err)
	} else {
		fmt.Printf("Saved to %s\n", filepath.Join(rootDir, "fav.log.sort"))
	}
}
