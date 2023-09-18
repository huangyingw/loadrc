package main

import (
    "fmt"
    "io/ioutil"
    "os"
    "path/filepath"
    "sync"
    "time"
)

// FileInfo holds the information about a file
type FileInfo struct {
    Size        int64
    ModTime     time.Time
}

// Cache to store file information
var fileCache = make(map[string]FileInfo)
var cacheMutex = &sync.Mutex{}

func main() {
    // Root directory to start the search
    rootDir := "./" // Replace with the directory you want to search in
    // Minimum file size in bytes
    minSize := int64(200 * 1024 * 1024) // 200 MB

    var wg sync.WaitGroup

    // Walk the file tree
    err := filepath.Walk(rootDir, func(path string, info os.FileInfo, err error) error {
        if err != nil {
            return err
        }

        wg.Add(1)
        go func(path string, info os.FileInfo) {
            defer wg.Done()

            // Skip directories
            if info.IsDir() {
                return
            }

            // Check if the file size is greater than the minimum size
            if info.Size() > minSize {
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

    // Print the cached files
    for path, info := range fileCache {
        fmt.Printf("Path: %s, Size: %d, ModTime: %s\n", path, info.Size, info.ModTime)
    }
}
