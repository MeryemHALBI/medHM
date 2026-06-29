---
type: metric
title: ViT — classification d'anomalies digestives
description: Vision Transformer entraîné sur le dataset deep_polypes pour la classification en 4 classes.
tags: [model, classification, transfer-learning, transformer]
timestamp: 2026-06-29T00:00:00Z
---

# ViT (Vision Transformer)

## Description

Vision Transformer entraîné par transfer learning sur le
[dataset deep_polypes](../data/deep_polypes.md).

## Résultats mesurés (jeu de test)

| Métrique | Valeur |
|---|---|
| Accuracy | 0.9770 |
| Précision (macro) | 0.9714 |
| Rappel (macro) | 0.9731 |
| F1 (macro) | 0.9713 |
| Temps moyen | 20.33 ms/image |

## Remarque

Meilleure accuracy mesurée à égalité avec [ConvNeXt](convnext.md), mais
temps d'exécution le plus élevé des 5 modèles comparés.
