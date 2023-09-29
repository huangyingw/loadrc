package main

import (
	"bufio"
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"sort"
	"strconv"
	"strings"
)

var fileSizeCache = make(map[string]int64)

func getFileSize(filePath string, defaultSize int64) int64 {
	if size, exists := fileSizeCache[filePath]; exists {
		return size
	}

	fileInfo, err := os.Stat(filePath)
	if err != nil {
		fileSizeCache[filePath] = defaultSize
		return defaultSize
	}

	size := fileInfo.Size()
	fileSizeCache[filePath] = size
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

	for _, keyword := range keywords {
		keywordFiles := closeFiles[keyword]
		if len(keywordFiles) >= 2 {
			sort.Slice(keywordFiles, func(i, j int) bool {
				return getFileSize(keywordFiles[i], 0) > getFileSize(keywordFiles[j], 0)
			})

			fmt.Println(keyword + ".txt")
			outputFile, err := os.Create(keyword + ".txt")
			if err != nil {
				fmt.Println("Error creating file:", err)
				return
			}
			defer outputFile.Close()

			outputFile.WriteString(keyword + "\n")
			for _, filePath := range keywordFiles {
				fileSize := getFileSize(filePath, 0)
				if fileSize > 0 {
					outputFile.WriteString(fmt.Sprintf("%d,%s\n", fileSize, filePath))
				}
			}
		}
	}
}
