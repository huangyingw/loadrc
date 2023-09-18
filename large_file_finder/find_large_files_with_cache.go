package main

import (
	"bufio"
	"fmt"
	"os"
	"path/filepath"
	"sort"
	"strings"
	"sync"
	"time"
)

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

	if info.IsDir() {
		return
	}

	if info.Size() > minSizeBytes {
		cacheMutex.Lock()
		fileCache[path] = FileInfo{
			Size:    info.Size(),
			ModTime: info.ModTime(),
		}
		cacheMutex.Unlock()
	}

	workerPool <- struct{}{} // 将空结构体放回workerPool，释放限制
}

func main() {
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

	fileCache := make(FileCache)

	for i := 0; i < cap(workerPool); i++ {
		workerPool <- struct{}{}
	}

	// Walk the file tree
	err = filepath.Walk(rootDir, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			fmt.Println("Error processing file:", err)
			return nil
		}

		for _, pattern := range excludePatterns {
			if strings.Contains(path, pattern) {
				return nil
			}
		}

		wg.Add(1)
		go processFile(path, info, fileCache, minSizeBytes)
		return nil
	})

	if err != nil {
		fmt.Println("Error walking the file tree:", err)
		return
	}

	wg.Wait()

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
