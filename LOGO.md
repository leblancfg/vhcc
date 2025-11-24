# Logo Vieux Hull Cycling Club

## Design

Le logo représente une roue de vélo stylisée avec les éléments suivants:
- **Roue avec rayons** : Symbolise le cyclisme
- **VHCC** : Initiales du club au centre
- **2026** : Année de la saison WTRL
- **Lignes de vitesse** : Effet dynamique
- **Couleurs Tokyo Night** : Cohérent avec le site web

## Fichiers disponibles

### Logo source
- `logo.svg` - Version vectorielle (scalable à l'infini)

### Pour Discord
- `discord-logo.png` - 512x512px, idéal pour serveur Discord

### Favicons (site web)
- `favicon.ico` - Multi-taille (16x16, 32x32)
- `favicon-32x32.png` - Standard
- `favicon-16x16.png` - Fallback
- `favicon-192x192.png` - Android/Chrome
- `apple-touch-icon.png` - 180x180px, iOS

## Utilisation Discord

### Changer le logo du serveur Discord:

1. Ouvrir les paramètres du serveur Discord
2. Aller dans "Overview" / "Aperçu"
3. Cliquer sur l'icône du serveur actuelle
4. Télécharger `discord-logo.png`
5. Sauvegarder

**Recommandations:**
- Format: PNG
- Taille: 512x512px (minimum 128x128)
- Taille fichier: <10MB (notre logo: ~96KB)

## Régénération

Si vous devez modifier le logo et régénérer les fichiers:

```bash
# Éditer logo.svg avec votre éditeur préféré

# Régénérer toutes les tailles
./generate-logos.sh
```

### Prérequis pour régénération:
- **Chrome/Chromium** : Pour conversion SVG → PNG
- **ImageMagick** (optionnel) : Pour favicon.ico multi-taille
  ```bash
  brew install imagemagick
  ```

## Palette de couleurs

Basée sur Tokyo Night theme:

| Couleur | Hex | Usage |
|---------|-----|-------|
| Background | `#1a1b26` | Fond principal |
| Background Alt | `#24283b` | Fond secondaire |
| Blue | `#7aa2f7` | Roue (dégradé) |
| Cyan | `#7dcfff` | Texte VHCC, roue |
| Magenta | `#bb9af7` | Centre hub |
| Green | `#9ece6a` | Texte 2026 |
| Yellow/Orange | `#e0af68` | Lignes de vitesse |

## Licence

© 2026 Vieux Hull Cycling Club. Logo créé pour usage interne du club.
