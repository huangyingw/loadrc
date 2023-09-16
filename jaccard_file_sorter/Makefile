# Makefile for file_group_sorter_jaccard

# Compiler to use
CXX = g++

# Compiler flags
CXXFLAGS = -Wall -std=c++17

# Linker flags for spdlog and fmt
LDFLAGS = -lspdlog -lfmt  # 注意这里添加了 -lfmt，并确保它在 -lspdlog 之后

# Target executable name
TARGET = file_group_sorter_jaccard

# Source files
SOURCES = file_group_sorter_jaccard.cpp

# Object files
OBJECTS = $(SOURCES:.cpp=.o)

# Build target executable
$(TARGET): $(OBJECTS)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(OBJECTS) $(LDFLAGS)  # 注意这里 $(LDFLAGS) 放在了 $(OBJECTS) 之后

# Compile source files into object files
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Clean up
clean:
	rm -f $(OBJECTS) $(TARGET)

# Install
install: $(TARGET)
	cp $(TARGET) /usr/local/bin

# Uninstall
uninstall:
	rm -f /usr/local/bin/$(TARGET)
