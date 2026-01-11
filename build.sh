#!/bin/bash
set -e

APP_NAME="QuickTray"
BUILD_DIR="build"
APP_BUNDLE="$BUILD_DIR/$APP_NAME.app"
SOURCES="Sources/QuickTrayApp.swift Sources/ClipboardManager.swift Sources/Views/ContentView.swift"

echo "Cleaning..."
rm -rf "$BUILD_DIR"
mkdir -p "$APP_BUNDLE/Contents/MacOS"
mkdir -p "$APP_BUNDLE/Contents/Resources"

echo "Compiling..."
# -target x86_64-apple-macosx13.0 or arm64-apple-macosx13.0 depending on arch, 
# but simply passing -target arm64-apple-macosx13.0 (for M1/M2/M3) or just letting swiftc decide.
# Since I don't know the exact arch, I'll let swiftc default to host arch but specify min OS version.
ARCH=$(uname -m)
echo "Compiling for $ARCH..."
swiftc $SOURCES -o "$APP_BUNDLE/Contents/MacOS/$APP_NAME" -target $ARCH-apple-macosx13.0 -sdk $(xcrun --show-sdk-path)

echo "Copying Resources..."
cp Info.plist "$APP_BUNDLE/Contents/Info.plist"

# Copy Icon
if [ -f "Resources/AppIcon.icns" ]; then
    cp Resources/AppIcon.icns "$APP_BUNDLE/Contents/Resources/"
fi

echo "Done! App is at $APP_BUNDLE"
