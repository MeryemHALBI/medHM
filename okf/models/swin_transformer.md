---
type: metric
title: Swin Transformer — classification d'anomalies digestives
description: Modèle Swin Transformer entraîné sur le dataset deep_polypes pour la classification en 4 classes.
tags: [model, classification, transfer-learning, transformer]
timestamp: 2026-06-29T00:00:00Z
---

# Swin Transformer

## Description

Modèle Swin Transformer entraîné par transfer learning sur le
[dataset deep_polypes](../data/deep_polypes.md).

## Résultats mesurés (jeu de test)

| Métrique | Valeur |
|---|---|
| Accuracy | 0.9655 |
| Précision (macro) | 0.9568 |
| Rappel (macro) | 0.9522 |
| F1 (macro) | 0.9514 |
| Temps moyen | 12.39 ms/image |

## Remarque

Bien que ce modèle ait obtenu de bons scores lors de la comparaison
initiale, il est jugé trop lourd pour un déploiement serveur classique
comparé à [EfficientNet](efficientnet.md), qui offre un meilleur
compromis précision/poids. Non retenu pour l'étage 2 de l'
[architecture hybride](../architecture/hybrid_pipeline.md) actuelle.
