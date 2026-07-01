# Project name (defaults to current directory name)
PROJECT_NAME = $(notdir $(CURDIR))

# Directories
SRC_DIR = src
BUILD_DIR = build
INCLUDE_DIR = include
LIB_DIR = lib

# Compiler settings
CC = gcc
CFLAGS = -Wall -Wextra -I$(INCLUDE_DIR)

# Linker settings
LDFLAGS = -L$(LIB_DIR)
LDLIBS = ./$(LIB_DIR)/libraylib.a -lm -lpthread -ldl -lrt -lX11

# Source files
SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(SRCS))

# Target executable
TARGET = $(BUILD_DIR)/$(PROJECT_NAME)

# Default target
all: $(BUILD_DIR) $(TARGET)

# Create build directory
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Link object files into executable
$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $@ $(LDFLAGS) $(LDLIBS)

# Compile source files into object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR)

# Run the executable
run: all
	./$(TARGET)

# Rebuild everything
rebuild: clean all

.PHONY: all clean run rebuild
