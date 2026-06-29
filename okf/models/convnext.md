---
type: metric
title: ConvNeXt — classification d'anomalies digestives
description: Modèle ConvNeXt entraîné sur le dataset deep_polypes pour la classification en 4 classes.
tags: [model, classification, transfer-learning]
timestamp: 2026-06-29T00:00:00Z
---

# ConvNeXt

## Description

Modèle ConvNeXt entraîné par transfer learning sur le
[dataset deep_polypes](../data/deep_polypes.md).

## Résultats mesurés (jeu de test)

| Métrique | Valeur |
|---|---|
| Accuracy | 0.9770 |
| Précision (macro) | 0.9689 |
| Rappel (macro) | 0.9760 |
| F1 (macro) | 0.9716 |
| Temps moyen | 15.34 ms/image |

## Remarque

Meilleure accuracy mesurée à égalité avec [ViT](vit.md) sur ce jeu de
test, avec un temps d'exécution comparable à
[ResNet50](resnet50.md).
