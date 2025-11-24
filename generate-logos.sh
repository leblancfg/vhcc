#!/bin/bash

# Script pour générer tous les logos et favicons
# Nécessite: google-chrome ou chromium, imagemagick (optionnel)

set -e

echo "🎨 Génération des logos et favicons..."

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

# Créer un HTML temporaire pour convertir SVG
cat > logo-temp.html <<'EOF'
<!DOCTYPE html>
<html>
<head>
    <style>
        body { margin: 0; padding: 0; }
        svg { display: block; }
    </style>
</head>
<body>
EOF

cat logo.svg >> logo-temp.html

cat >> logo-temp.html <<'EOF'
</body>
</html>
EOF

# Générer logo Discord (512x512)
echo "  📱 Logo Discord (512x512)..."
"$CHROME" --headless --disable-gpu \
    --window-size=512,512 \
    --screenshot=discord-logo.png \
    --hide-scrollbars \
    logo-temp.html 2>/dev/null

# Générer favicon 192x192 (Android/Chrome)
echo "  🌐 Favicon 192x192..."
"$CHROME" --headless --disable-gpu \
    --window-size=192,192 \
    --screenshot=favicon-192x192.png \
    --hide-scrollbars \
    logo-temp.html 2>/dev/null

# Générer favicon 180x180 (Apple Touch)
echo "  🍎 Apple Touch Icon 180x180..."
"$CHROME" --headless --disable-gpu \
    --window-size=180,180 \
    --screenshot=apple-touch-icon.png \
    --hide-scrollbars \
    logo-temp.html 2>/dev/null

# Générer favicon 32x32 (Standard)
echo "  🔷 Favicon 32x32..."
"$CHROME" --headless --disable-gpu \
    --window-size=32,32 \
    --screenshot=favicon-32x32.png \
    --hide-scrollbars \
    logo-temp.html 2>/dev/null

# Générer favicon 16x16 (Fallback)
echo "  🔹 Favicon 16x16..."
"$CHROME" --headless --disable-gpu \
    --window-size=16,16 \
    --screenshot=favicon-16x16.png \
    --hide-scrollbars \
    logo-temp.html 2>/dev/null

# Créer favicon.ico multi-taille si imagemagick disponible
if command -v convert &> /dev/null; then
    echo "  🎯 Favicon.ico multi-taille..."
    convert favicon-16x16.png favicon-32x32.png -colors 256 favicon.ico 2>/dev/null
else
    echo "  ⚠️  ImageMagick non installé, favicon.ico non créé"
    echo "     Installation: brew install imagemagick"
    # Copier 32x32 comme fallback
    cp favicon-32x32.png favicon.ico
fi

# Nettoyer
rm logo-temp.html

echo ""
echo "✅ Logos générés:"
echo "   - discord-logo.png (512x512) - Pour Discord"
echo "   - favicon-192x192.png - Android/Chrome"
echo "   - apple-touch-icon.png (180x180) - iOS"
echo "   - favicon-32x32.png - Standard"
echo "   - favicon-16x16.png - Fallback"
if command -v convert &> /dev/null; then
    echo "   - favicon.ico - Multi-taille"
fi
echo ""

# Afficher tailles
for file in discord-logo.png favicon*.png apple-touch-icon.png; do
    if [ -f "$file" ]; then
        echo "   📏 $file: $(du -h "$file" | cut -f1)"
    fi
done
