# Scripts de Génération d'Assets

## Vue d'ensemble

Scripts pour générer tous les assets visuels du site à partir du logo source.

## Prérequis

**ImageMagick** (pour favicons):
```bash
brew install imagemagick
```

**Chrome/Chromium** (pour OG image):
```bash
brew install --cask google-chrome
```

## Usage

### Générer tous les assets

```bash
./scripts/generate-all.sh
```

Ce script génère automatiquement:
- Logo PNG pour Discord (512x512)
- Tous les favicons (16x16, 32x32, 192x192)
- Apple Touch Icon (180x180)
- favicon.ico multi-taille
- Image Open Graph pour social sharing (1200x630)

### Générer seulement les favicons

```bash
./scripts/generate-assets.sh
```

### Générer seulement l'image OG

```bash
./scripts/generate-og.sh
```

## Fichiers source requis

- `discord-logo.jpg` - Logo source (racine du projet)
- `og-template.html` - Template HTML pour OG image (racine du projet)

## Assets générés

| Fichier | Taille | Usage |
|---------|--------|-------|
| `discord-logo.png` | 512x512 | Logo serveur Discord |
| `logo-transparent.png` | 512x512 | Logo sur site web |
| `favicon.ico` | Multi | Favicon navigateurs |
| `favicon-16x16.png` | 16x16 | Favicon petit |
| `favicon-32x32.png` | 32x32 | Favicon standard |
| `favicon-192x192.png` | 192x192 | Android/Chrome |
| `apple-touch-icon.png` | 180x180 | iOS/Safari |
| `og-image.png` | 1200x630 | Social sharing |

## Workflow typique

1. Modifier `discord-logo.jpg` si nécessaire
2. Exécuter `./scripts/generate-all.sh`
3. Vérifier les images générées
4. Commit et push:
   ```bash
   git add .
   git commit -m "Regenerate assets"
   git push
   ```

## Notes

- Les warnings ImageMagick sur `convert` vs `magick` peuvent être ignorés
- Chrome doit être installé pour générer og-image.png
- Tous les scripts sont idempotents (safe de réexécuter)
