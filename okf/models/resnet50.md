---
type: metric
title: ResNet50 — classification d'anomalies digestives
description: Modèle ResNet50 entraîné sur le dataset deep_polypes pour la classification en 4 classes.
tags: [model, classification, transfer-learning]
timestamp: 2026-06-29T00:00:00Z
---

# ResNet50

## Description

Modèle ResNet50 entraîné par transfer learning sur le
[dataset deep_polypes](../data/deep_polypes.md).

## Résultats mesurés (jeu de test)

| Métrique | Valeur |
|---|---|
| Accuracy | 0.9540 |
| Précision (macro) | 0.9386 |
| Rappel (macro) | 0.9491 |
| F1 (macro) | 0.9432 |
| Temps moyen | 15.23 ms/image |

## Remarque

Modèle de référence classique, performances légèrement inférieures aux
4 autres modèles comparés sur ce dataset.
