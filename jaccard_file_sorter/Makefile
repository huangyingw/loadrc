# Makefile for file_group_sorter_jaccard

# Compiler to use
CXX = g++

# Compiler flags
CXXFLAGS = -Wall -std=c++17

# Target executable name
TARGET = file_group_sorter_jaccard

# Source files
SOURCES = file_group_sorter_jaccard.cpp

# Object files
OBJECTS = $(SOURCES:.cpp=.o)

# Build target executable
$(TARGET): $(OBJECTS)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(OBJECTS)

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
