---
type: table
title: Dataset deep_polypes
description: Jeu de données d'images endoscopiques/coloscopiques organisé en 4 dossiers de classe, utilisé pour entraîner les modèles de classification.
tags: [dataset, classification]
timestamp: 2026-06-29T00:00:00Z
---

# Dataset deep_polypes

## Structure

```
deep_polypes/deep_polypes/
├── normal/
├── polype/
├── mici/
└── mauvaise_preparation/
```

Format : classification par dossier (chaque image classée par son
dossier parent, sans annotation de localisation/bounding box).

## Volumétrie

580 images au total, réparties entre les 4 classes.

## Utilisation

- Entraînement et comparaison des modèles de classification : voir
  [EfficientNet](../models/efficientnet.md),
  [Swin Transformer](../models/swin_transformer.md),
  [ResNet50](../models/resnet50.md),
  [ConvNeXt](../models/convnext.md), [ViT](../models/vit.md).
- Source des images utilisées pour entraîner et tester le modèle
  [YOLO](../models/yolo_polype.md) (après pré-annotation, voir
  ci-dessous).

## Limite connue

Ce dataset ne contient que des labels de classe par image, pas de
bounding box. Pour entraîner YOLO (qui nécessite la localisation de
l'anomalie), les images de la classe `polype` ont été pré-annotées
automatiquement à l'aide d'un modèle YOLO entraîné sur
[Kvasir-SEG](kvasir_seg.md), puis vérifiées visuellement.

## Prochaine étape proposée

Le manager a proposé de donner à l'équipe médicale la possibilité
d'enrichir ce dataset (ajout de nouvelles images) afin de relancer
l'entraînement avec une base plus riche.
