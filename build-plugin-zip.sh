#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Plugin name (adjust as needed)
PLUGIN_NAME="wc-minimum-maximum-rules"

# Directory paths
PLUGIN_DIR="./$PLUGIN_NAME"
BUILD_DIR="./build"
ZIP_FILE="$PLUGIN_NAME.zip"

# Ensure the plugin directory exists
if [ ! -d "$PLUGIN_DIR" ]; then
    echo "Error: Plugin directory '$PLUGIN_DIR' does not exist."
    exit 1
fi

# Prepare the build directory
echo "Preparing build directory..."
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"
cp -R "$PLUGIN_DIR" "$BUILD_DIR/"

# Navigate to the copied plugin directory
cd "$BUILD_DIR/$PLUGIN_NAME"

# Install PHP dependencies without development files
if [ -f "composer.json" ]; then
    echo "Installing PHP dependencies..."
    composer install --no-dev
fi

# Install npm dependencies for production
if [ -f "package.json" ]; then
    echo "Installing JavaScript dependencies..."
    npm install --production
    npm run build
fi

# Remove unnecessary development files
echo "Removing unnecessary files..."
rm -f composer.json composer.lock
rm -f package.json package-lock.json
rm -f .env .gitignore README.md
rm -rf tests

# Navigate back to the build directory
cd "$BUILD_DIR"

# Create the ZIP file
echo "Creating ZIP file..."
zip -r "../$ZIP_FILE" "$PLUGIN_NAME"

# Cleanup
cd ..
rm -rf "$BUILD_DIR"

# Completion message
echo "ZIP file created: $ZIP_FILE"
