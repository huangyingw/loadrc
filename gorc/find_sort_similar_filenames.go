package main

import (
	"bufio"
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"sort"
	"strings"
	"sync"
)

var fileSizeCache = sync.Map{}

func getFileSize(filePath string, defaultSize int64) int64 {
	// 去掉路径中的引号
	filePath = strings.ReplaceAll(filePath, "\"", "")

	currentDir, _ := os.Getwd()                         // 获取当前工作目录
	absolutePath := filepath.Join(currentDir, filePath) // 拼接绝对路径

	cleanPath := filepath.Clean(absolutePath) // 清理路径

	if size, exists := fileSizeCache.Load(cleanPath); exists {
		return size.(int64)
	}

	fileInfo, err := os.Stat(cleanPath) // 使用清理后的绝对路径
	if err != nil {
		fmt.Printf("Error getting file size for '%s': %v. Current directory: '%s'\n", cleanPath, err, currentDir)
		fileSizeCache.Store(cleanPath, defaultSize)
		return defaultSize
	}

	size := fileInfo.Size()
	fileSizeCache.Store(cleanPath, size)
	return size
}

func extractFileName(filePath string) string {
	return strings.ToLower(filepath.Base(filePath))
}

func extractKeywords(fileNames []string) []string {
	keywords := make(map[string]struct{})
	pattern := regexp.MustCompile(`\b(?:\d{2}\.\d{2}\.\d{2}|(?:\d+|[a-z]+(?:\d+[a-z]*)?))\b`)

	for _, fileName := range fileNames {
		nameWithoutExt := strings.TrimSuffix(fileName, filepath.Ext(fileName))
		matches := pattern.FindAllString(nameWithoutExt, -1)
		for _, match := range matches {
			keywords[match] = struct{}{}
		}
	}

	var keywordList []string
	for keyword := range keywords {
		keywordList = append(keywordList, keyword)
	}

	return keywordList
}

func findCloseFiles(fileNames, filePaths, keywords []string) map[string][]string {
	closeFiles := make(map[string][]string)

	for _, kw := range keywords {
		for i, fileName := range fileNames {
			if strings.Contains(strings.ToLower(fileName), strings.ToLower(kw)) {
				closeFiles[kw] = append(closeFiles[kw], filePaths[i])
			}
		}
	}

	return closeFiles
}

func processKeyword(keyword string, keywordFiles []string) {
	sort.Slice(keywordFiles, func(i, j int) bool {
		return getFileSize(keywordFiles[i], 0) > getFileSize(keywordFiles[j], 0)
	})

	fmt.Println(keyword + ".txt")
	outputFile, err := os.Create(keyword + ".txt")
	if err != nil {
		fmt.Println("Error creating file:", err)
		return
	}
	defer outputFile.Close() // 确保文件会被关闭

	outputFile.WriteString(keyword + "\n")
	for _, filePath := range keywordFiles {
		fileSize := getFileSize(filePath, 0)
		outputFile.WriteString(fmt.Sprintf("%d,%s\n", fileSize, filePath))
	}
}

func main() {
	args := os.Args[1:]
	if len(args) != 1 {
		fmt.Println("Usage: go run main.go --file=<file_path>")
		return
	}

	fileArg := args[0]
	filePath := strings.Split(fileArg, "=")[1]

	file, err := os.Open(filePath)
	if err != nil {
		fmt.Println("Error opening file:", err)
		return
	}
	defer file.Close()

	var fileNames, filePaths []string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		line = regexp.MustCompile(`^\d+,`).ReplaceAllString(line, "")
		filePaths = append(filePaths, line)
		fileNames = append(fileNames, extractFileName(line))
	}

	keywords := extractKeywords(fileNames)
	closeFiles := findCloseFiles(fileNames, filePaths, keywords)

	sort.Slice(keywords, func(i, j int) bool {
		return len(closeFiles[keywords[i]]) > len(closeFiles[keywords[j]])
	})

	totalKeywords := len(keywords)     // 定义 totalKeywords
	for i, keyword := range keywords { // 定义 i
		// 显示进度
		fmt.Printf("Processing keyword %d of %d: %s\n", i+1, totalKeywords, keyword)
		processKeyword(keyword, closeFiles[keyword]) // 调用新的 processKeyword 函数
	}
}
