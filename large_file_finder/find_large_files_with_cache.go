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

// Cache to store file information
var fileCache = make(map[string]FileInfo)
var cacheMutex = &sync.Mutex{}

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

func saveToFile(dir, filename string, data map[string]FileInfo, sortByModTime bool) error {
	file, err := os.Create(filepath.Join(dir, filename))
	if err != nil {
		return err
	}
	defer file.Close()

	var keys []string
	for k := range data {
		keys = append(keys, k)
	}

	if sortByModTime {
		sort.Slice(keys, func(i, j int) bool {
			return data[keys[i]].ModTime.After(data[keys[j]].ModTime)
		})
	} else {
		sort.Slice(keys, func(i, j int) bool {
			return data[keys[i]].Size > data[keys[j]].Size
		})
	}

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

	var wg sync.WaitGroup

	// Walk the file tree
	err = filepath.Walk(rootDir, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}

		for _, pattern := range excludePatterns {
			if strings.Contains(path, pattern) {
				return nil
			}
		}

		wg.Add(1)
		go func(path string, info os.FileInfo) {
			defer wg.Done()

			// Skip directories
			if info.IsDir() {
				return
			}

			// Check if the file size is greater than the minimum size
			if info.Size() > minSizeBytes {
				cacheMutex.Lock()
				fileCache[path] = FileInfo{
					Size:    info.Size(),
					ModTime: info.ModTime(),
				}
				cacheMutex.Unlock()
			}
		}(path, info)

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
