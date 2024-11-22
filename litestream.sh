#!/bin/zsh

VERSION="0.3.13"
INSTALL_DIR="/usr/local/bin"

# Determine CPU architecture
if [[ $(uname -m) == "arm64" ]]; then
    ARCH="arm64"
    SHA256="6d1689487432613f5c10aee75ee77c95250dcce4da49695bf0a448c794eb7daa"
elif [[ $(uname -m) == "x86_64" ]]; then
    ARCH="amd64"
    SHA256="6f68536bd24a0b6c4fdefb2f91ba27332e2146fb9f1be7985adfee8cdfce9784"
else
    echo "Unsupported architecture: $(uname -m)"
    exit 1
fi

# Create temporary directory
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Download the appropriate version
FILENAME="litestream-v${VERSION}-darwin-${ARCH}.zip"
URL="https://github.com/benbjohnson/litestream/releases/download/v${VERSION}/${FILENAME}"

echo "Downloading Litestream ${VERSION} for darwin-${ARCH}..."
curl -L -o "$FILENAME" "$URL"

# Verify SHA256
echo "Verifying checksum..."
COMPUTED_SHA256=$(shasum -a 256 "$FILENAME" | cut -d ' ' -f 1)
if [[ "$COMPUTED_SHA256" != "$SHA256" ]]; then
    echo "Checksum verification failed!"
    echo "Expected: $SHA256"
    echo "Got: $COMPUTED_SHA256"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Extract and install
echo "Installing Litestream..."
unzip "$FILENAME"
sudo mv litestream "$INSTALL_DIR/"
sudo chmod +x "$INSTALL_DIR/litestream"

# Clean up
rm -rf "$TEMP_DIR"

# Verify installation
if command -v litestream >/dev/null 2>&1; then
    echo "Litestream installation successful!"
    litestream version
else
    echo "Litestream installation failed!"
    exit 1
fi
