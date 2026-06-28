#!/bin/bash

set -e

SRC_DIR="src"
BUILD_DIR="build"
BIN_DIR="bin"

DO_CLEAN=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        --clean|-c)
            DO_CLEAN=true
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [options]"
            echo "  --clean     run cmake + make clean before build"
            echo "  --help, -h  show this help"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 [--clean]"
            exit 1
            ;;
    esac
done

# Step 1: Auto-format code
echo "=== Auto-formatting code with clang-format ==="
SOURCES=$(find "$SRC_DIR" -name '*.c' -o -name '*.h' | sort)
if [ -z "$SOURCES" ]; then
    echo "No source files found in $SRC_DIR"
    exit 1
fi

for file in $SOURCES; do
    clang-format -i "$file"
done
echo "Formatting done"

# Step 2: Build
echo ""
echo "=== Build ==="
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

if [ "$DO_CLEAN" = true ]; then
    cmake ..
    make clean
fi

make -j"$(nproc)"
cd ..

# Step 3: Run
echo ""
echo "=== Run ==="
mkdir -p "$BIN_DIR"
cd "$BIN_DIR"
./test
