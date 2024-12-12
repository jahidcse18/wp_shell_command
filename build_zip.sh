#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Plugin name (adjust as needed)
PLUGIN_NAME="wc-minimum-maximum-rules"
BUILD_DIR="build"
ZIP_FILE="compressed_plugin.zip"

# Output ZIP file name
ZIP_FILE="compressed_plugin.zip"

# Ensure the plugin directory exists
if [ ! -d "$PLUGIN_NAME" ]; then
    echo "Error: Plugin directory '$PLUGIN_NAME' does not exist."
    exit 1
fi
# Navigate to the build directory
cd "$BUILD_DIR"

# Create the ZIP file while excluding specific files and folders
echo "Creating ZIP file..."
zip -r "$ZIP_FILE" "$PLUGIN_NAME/" \
    -x "$PLUGIN_NAME/.husky/*" \
    -x "$PLUGIN_NAME/node_modules/*" \
    -x "$PLUGIN_NAME/src/*" \
    -x "$PLUGIN_NAME/.distignore" \
    -x "$PLUGIN_NAME/.editorconfig" \
    -x "$PLUGIN_NAME/.gitignore" \
    -x "$PLUGIN_NAME/Gruntfile.js" \
    -x "$PLUGIN_NAME/tests/*" \
    -x "$PLUGIN_NAME/.git/*" \
    -x "$PLUGIN_NAME/.env" \
    -x "$PLUGIN_NAME/composer.json" \
    -x "$PLUGIN_NAME/composer.lock" \
    -x "$PLUGIN_NAME/package.json" \
    -x "$PLUGIN_NAME/package-lock.json" \
    -x "$PLUGIN_NAME/phpcs.xml" \
    -x "$PLUGIN_NAME/postcss.config.js" \
    -x "$PLUGIN_NAME/tailwind.config.js" \
    -x "$PLUGIN_NAME/webpack.config.js"
# Navigate back to the original directory
cd ..
# Completion message
echo "ZIP file created: $ZIP_FILE"
