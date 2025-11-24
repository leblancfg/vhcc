#!/bin/bash

# Génère l'image Open Graph (1200x630)
# Nécessite: Chrome/Chromium

set -e

# Trouver Chrome
if command -v /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome &> /dev/null; then
    CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
elif command -v google-chrome &> /dev/null; then
    CHROME="google-chrome"
elif command -v chromium &> /dev/null; then
    CHROME="chromium"
else
    echo "❌ Chrome/Chromium non trouvé."
    exit 1
fi

echo "🎨 Génération de l'image Open Graph..."

"$CHROME" --headless --disable-gpu \
    --window-size=1200,630 \
    --screenshot=og-image.png \
    --hide-scrollbars \
    og-template.html 2>/dev/null

if [ -f og-image.png ]; then
    echo "✅ Image Open Graph générée: og-image.png (1200x630)"
    echo "📏 Taille: $(du -h og-image.png | cut -f1)"
else
    echo "❌ Erreur lors de la génération"
    exit 1
fi
