package main

import (
	"bufio"
	"context"
	"fmt"
	"github.com/cespare/xxhash/v2"
	"github.com/go-redis/redis/v8"
	"os"
	"sort"
	"strconv"
	"strings"
	"sync"
	"sync/atomic"
)

const JaccardThreshold = 80

var ctx = context.Background()

// Initialize Redis client
var rdb = redis.NewClient(&redis.Options{
	Addr: "localhost:6380",
})

var totalFiles int
var processedFiles int32 // Atomic variable for processed files

// GenerateCacheKey generates a cache key based on two strings.
func GenerateCacheKey(a, b string) string {
	var concatenated string
	if a < b {
		concatenated = a + "_" + b
	} else {
		concatenated = b + "_" + a
	}
	hashValue := xxhash.Sum64String(concatenated)
	return strconv.FormatUint(hashValue, 10)
}

// JaccardSimilarity calculates the Jaccard similarity between two strings.
func JaccardSimilarity(a, b string) float64 {
	cacheKey := GenerateCacheKey(a, b)
	val, err := rdb.Get(ctx, cacheKey).Float64()

	if err == nil {
		return val
	}

	// Handle Redis error
	if err != nil {
		fmt.Printf("Redis error: %v\n", err)
	}

	setA := make(map[rune]bool)
	setB := make(map[rune]bool)

	for _, c := range a {
		setA[c] = true
	}
	for _, c := range b {
		setB[c] = true
	}

	intersection := 0
	union := 0

	for k := range setA {
		if setB[k] {
			intersection++
		}
		union++
	}

	for k := range setB {
		if !setA[k] {
			union++
		}
	}

	result := float64(intersection) / float64(union) * 100

	rdb.Set(ctx, cacheKey, result, 0)
	return result
}

// UpdateProgress updates and prints the progress.
func UpdateProgress() {
	atomic.AddInt32(&processedFiles, 1) // Atomic operation
	progress := float64(processedFiles) / float64(totalFiles) * 100
	fmt.Printf("Progress: %.2f%%\n", progress)
}

// UpdateGroupInRedis creates or updates a group in Redis.
func UpdateGroupInRedis(groupName, filename string) {
	rdb.SAdd(ctx, groupName, filename)
}

// Group structure for storing and sorting groups.
type Group struct {
	Name    string
	Files   []string
	MaxSize int64 // Field to store the maximum file size within the group
}

// GetAndSortGroups returns a slice of sorted Group structures.
func GetAndSortGroups() []Group {
	groupNames, _ := rdb.Keys(ctx, "*").Result()
	var groups []Group

	for _, groupName := range groupNames {
		files, _ := rdb.SMembers(ctx, groupName).Result()
		maxSize := int64(0) // Initialize maximum file size to 0

		// Calculate the maximum file size within the group
		for _, file := range files {
			size, _ := strconv.ParseInt(strings.Split(file, ",")[0], 10, 64)
			if size > maxSize {
				maxSize = size
			}
		}

		groups = append(groups, Group{Name: groupName, Files: files, MaxSize: maxSize})
	}

	// Sort groups by the maximum file size within each group
	sort.Slice(groups, func(i, j int) bool {
		return groups[i].MaxSize > groups[j].MaxSize
	})

	return groups
}

func main() {
	defer rdb.Close() // Close Redis connection

	// Argument checks
	if len(os.Args) != 3 {
		fmt.Println("Usage: go run main.go <input_filename> <output_filename>")
		return
	}

	inputFilename := os.Args[1]
	outputFilename := os.Args[2]

	// Open the input file
	inputFile, err := os.Open(inputFilename)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Could not read input file: %v\n", err)
		return
	}
	defer inputFile.Close()

	// Initialize scanner
	scanner := bufio.NewScanner(inputFile)

	// Initialize totalFiles
	totalFiles = 0

	// 初始化一个channel用于跟踪进度
	progressChannel := make(chan bool)

	// 创建一个单独的goroutine来跟踪进度
	go func() {
		for {
			<-progressChannel
			UpdateProgress() // 使用 UpdateProgress 函数来更新进度
		}
	}()

	var wg sync.WaitGroup

	for scanner.Scan() {
		line := scanner.Text()
		totalFiles++
		wg.Add(1)

		go func(line string) {
			defer wg.Done()
			parts := strings.Split(line, ",")
			size, _ := strconv.Atoi(parts[0])
			path := parts[1]

			filename := path[strings.LastIndex(path, "/")+1:]
			added := false

			groupNames, _ := rdb.Keys(ctx, "*").Result()
			for _, groupName := range groupNames {
				groupMembers, _ := rdb.SMembers(ctx, groupName).Result()
				for _, member := range groupMembers {
					if JaccardSimilarity(member, filename) > JaccardThreshold {
						UpdateGroupInRedis(groupName, fmt.Sprintf("%d,\"%s\"", size, path))
						added = true
						break
					}
				}
				if added {
					break
				}
			}

			if !added {
				// Create new group logic
				newGroupName := "group_" + filename
				UpdateGroupInRedis(newGroupName, fmt.Sprintf("%d,\"%s\"", size, path))
			}

			// 在这里发送一个信号到 progressChannel
			progressChannel <- true
		}(line)
	}

	wg.Wait() // Wait for all goroutines to finish

	// Get and sort groups
	sortedGroups := GetAndSortGroups()

	// Open the output file
	outputFile, err := os.Create(outputFilename)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Could not write to output file: %v\n", err)
		return
	}
	defer outputFile.Close()

	// Initialize writer
	writer := bufio.NewWriter(outputFile)

	// Write sorted groups to the output file
	for _, group := range sortedGroups {
		// Check if the group is empty before writing
		if len(group.Files) == 0 {
			continue // Skip this iteration
		}

		sort.Slice(group.Files, func(i, j int) bool {
			sizeI, _ := strconv.ParseInt(strings.Split(group.Files[i], ",")[0], 10, 64)
			sizeJ, _ := strconv.ParseInt(strings.Split(group.Files[j], ",")[0], 10, 64)
			return sizeI > sizeJ
		})

		for _, file := range group.Files {
			writer.WriteString(file + "\n")
		}
		writer.WriteString("\n") // Add an empty line between each group
	}

	writer.Flush()
}
