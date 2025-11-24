#!/bin/bash

# Génère tous les assets à partir de discord-logo.jpg
# Nécessite: imagemagick (brew install imagemagick)

set -e

if ! command -v convert &> /dev/null; then
    echo "❌ ImageMagick requis. Installation:"
    echo "   brew install imagemagick"
    exit 1
fi

echo "🎨 Génération des assets à partir de discord-logo.jpg..."

# Convertir JPG to PNG 512x512 (Discord)
echo "  📱 Discord logo PNG (512x512)..."
convert discord-logo.jpg -resize 512x512 discord-logo.png

# Favicon 192x192 (Android/Chrome)
echo "  🌐 Favicon 192x192..."
convert discord-logo.jpg -resize 192x192 favicon-192x192.png

# Apple Touch Icon 180x180
echo "  🍎 Apple Touch Icon (180x180)..."
convert discord-logo.jpg -resize 180x180 apple-touch-icon.png

# Favicon 32x32
echo "  🔷 Favicon 32x32..."
convert discord-logo.jpg -resize 32x32 favicon-32x32.png

# Favicon 16x16
echo "  🔹 Favicon 16x16..."
convert discord-logo.jpg -resize 16x16 favicon-16x16.png

# Favicon.ico multi-taille
echo "  🎯 Favicon.ico..."
convert discord-logo.jpg -resize 16x16 -resize 32x32 favicon-16.png
convert discord-logo.jpg -resize 32x32 favicon-32.png
convert favicon-16.png favicon-32.png -colors 256 favicon.ico
rm favicon-16.png favicon-32.png

echo ""
echo "✅ Assets générés:"
ls -lh discord-logo.png favicon*.png apple-touch-icon.png favicon.ico 2>/dev/null | awk '{print "   📏", $9, "-", $5}'
