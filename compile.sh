#!/bin/bash

# Define the output directory
OUTPUT_DIR="dist"
PACKAGE_NAME="pdftoimg"

export CGO_ENABLED=1

# Define the target platforms (OS ARCH NAME)
TARGETS=(
    "linux amd64 gcc"
    "windows amd64 x86_64-w64-mingw32-gcc"
    #"darwin amd64 myapp"
    #"darwin arm64 myapp"
)

# Function to perform cross-compilation
cross_compile() {
    local GOOS=$1
    local GOARCH=$2
    local CC=$3
    local BUNDLE_NAME="${GOOS}_${GOARCH}"

    if [ $GOOS == "windows" ]; then
        BUNDLE_NAME="${BUNDLE_NAME}.exe"
    fi

    echo "Cross-compiling for $GOOS $GOARCH"
    
    env GOOS=$GOOS CC=$CC GOARCH=$GOARCH go mod tidy
    env GOOS=$GOOS CC=$CC GOARCH=$GOARCH go build -o "$OUTPUT_DIR/$OUTPUT_NAME" -buildvcs=false
    #env GOOS=$GOOS CC=$CC GOARCH=$GOARCH go env

}

# Create the output directory
mkdir -p "$OUTPUT_DIR"

# Loop through the targets array and call cross_compile function
for target in "${TARGETS[@]}"; do
    IFS=' ' read -r -a target_info <<< "$target"

    GOOS="${target_info[0]}"
    GOARCH="${target_info[1]}"
    CC="${target_info[2]}"


    #echo "${target_info[0]}" "${target_info[1]}" "${target_info[2]}_$PACKAGE_NAME"

    bundle_name="${GOOS}_${GOARCH}"
    echo "Compiling for: $bundle_name with $CC"
    cross_compile "${GOOS}" "${GOARCH}" "${CC}"
    echo " ---------- "
done

echo "Cross-compilation complete"
