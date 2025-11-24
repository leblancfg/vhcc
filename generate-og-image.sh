#!/bin/bash

# Script pour générer l'image Open Graph
# Nécessite: google-chrome ou chromium

# Dimensions standard Open Graph
WIDTH=1200
HEIGHT=630

# Utilise Chrome/Chromium en headless mode pour screenshot
if command -v google-chrome &> /dev/null; then
    CHROME="google-chrome"
elif command -v chromium &> /dev/null; then
    CHROME="chromium"
elif command -v /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome &> /dev/null; then
    CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
else
    echo "❌ Chrome/Chromium non trouvé. Installation requise."
    echo "   macOS: brew install --cask google-chrome"
    exit 1
fi

echo "🎨 Génération de l'image Open Graph..."

"$CHROME" --headless --disable-gpu \
    --window-size=$WIDTH,$HEIGHT \
    --screenshot=og-image.png \
    --hide-scrollbars \
    og-image.html

if [ -f og-image.png ]; then
    echo "✅ Image générée: og-image.png (${WIDTH}x${HEIGHT})"
    echo "📏 Taille du fichier: $(du -h og-image.png | cut -f1)"
else
    echo "❌ Erreur lors de la génération"
    exit 1
fi
