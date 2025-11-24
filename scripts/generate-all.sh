#!/bin/bash

# Script principal pour générer tous les assets du site
# Source: discord-logo.jpg (fourni manuellement)
# Génère: favicons, logo PNG, OG image

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_DIR"

echo "🎨 Génération de tous les assets pour Vieux Hull Cycling Club"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Vérifier que discord-logo.jpg existe
if [ ! -f "discord-logo.jpg" ]; then
    echo "❌ discord-logo.jpg non trouvé!"
    echo "   Place ton logo source dans le dossier racine."
    exit 1
fi

echo "✅ Logo source trouvé: discord-logo.jpg"
echo ""

# 1. Générer les favicons et logo PNG
echo "📦 Étape 1: Génération des favicons et logo PNG"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if command -v magick &> /dev/null; then
    CONVERT="magick"
elif command -v convert &> /dev/null; then
    CONVERT="convert"
else
    echo "❌ ImageMagick requis. Installation:"
    echo "   brew install imagemagick"
    exit 1
fi

echo "  📱 Discord logo PNG (512x512)..."
$CONVERT discord-logo.jpg -resize 512x512 discord-logo.png

echo "  🌐 Favicon 192x192..."
$CONVERT discord-logo.jpg -resize 192x192 favicon-192x192.png

echo "  🍎 Apple Touch Icon (180x180)..."
$CONVERT discord-logo.jpg -resize 180x180 apple-touch-icon.png

echo "  🔷 Favicon 32x32..."
$CONVERT discord-logo.jpg -resize 32x32 favicon-32x32.png

echo "  🔹 Favicon 16x16..."
$CONVERT discord-logo.jpg -resize 16x16 favicon-16x16.png

echo "  🎯 Favicon.ico multi-taille..."
$CONVERT favicon-16x16.png favicon-32x32.png -colors 256 favicon.ico

# Générer logo transparent si nécessaire
if [ ! -f "logo-transparent.png" ]; then
    echo "  🖼️  Logo transparent (copie de discord-logo.png)..."
    cp discord-logo.png logo-transparent.png
fi

echo ""
echo "✅ Favicons générés:"
ls -lh discord-logo.png favicon*.png apple-touch-icon.png favicon.ico 2>/dev/null | awk '{print "   📏", $9, "-", $5}'
echo ""

# 2. Générer l'image Open Graph
echo "📦 Étape 2: Génération de l'image Open Graph"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Trouver Chrome
if command -v /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome &> /dev/null; then
    CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
elif command -v google-chrome &> /dev/null; then
    CHROME="google-chrome"
elif command -v chromium &> /dev/null; then
    CHROME="chromium"
else
    echo "⚠️  Chrome/Chromium non trouvé, skip OG image"
    echo "   Installation: brew install --cask google-chrome"
    CHROME=""
fi

if [ -n "$CHROME" ] && [ -f "og-template.html" ]; then
    echo "  🌐 Génération og-image.png (1200x630)..."
    "$CHROME" --headless --disable-gpu \
        --window-size=1200,630 \
        --screenshot=og-image.png \
        --hide-scrollbars \
        og-template.html 2>/dev/null

    if [ -f og-image.png ]; then
        echo "  ✅ og-image.png générée"
        echo "     📏 Taille: $(du -h og-image.png | cut -f1)"
    fi
else
    echo "  ⚠️  Skipped (Chrome ou og-template.html manquant)"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Tous les assets générés avec succès!"
echo ""
echo "Assets créés:"
echo "  - discord-logo.png (512x512) → Pour Discord"
echo "  - logo-transparent.png → Pour site web"
echo "  - favicon.ico + variants → Pour navigateurs"
echo "  - og-image.png (1200x630) → Pour social sharing"
echo ""
echo "Prochaines étapes:"
echo "  1. Vérifier les images générées"
echo "  2. git add . && git commit -m 'Regenerate assets'"
echo "  3. git push"
