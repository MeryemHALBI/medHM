---
type: metric
title: EfficientNet — classification d'anomalies digestives
description: Modèle de transfer learning (EfficientNet-B0) entraîné sur le dataset deep_polypes pour la classification en 4 classes.
tags: [model, classification, transfer-learning, etage-2]
timestamp: 2026-06-29T00:00:00Z
---

# EfficientNet

## Description

Modèle EfficientNet-B0 pré-entraîné sur ImageNet, dont la tête de
classification a été remplacée pour s'adapter aux 4 classes du
[dataset deep_polypes](../data/deep_polypes.md).

## Résultats mesurés (jeu de test)

| Métrique | Valeur |
|---|---|
| Accuracy | 0.9655 |
| Précision (macro) | 0.9580 |
| Rappel (macro) | 0.9699 |
| F1 (macro) | 0.9626 |
| Temps moyen | 14.64 ms/image |

## Rôle dans l'architecture

Modèle retenu pour l'**étage 2** (cloud) de l'
[architecture hybride](../architecture/hybrid_pipeline.md), en raison de
son bon compromis précision/poids comparé aux modèles plus lourds
(Swin Transformer notamment). Exposé via le
[backend FastAPI](../components/backend_api.md).
