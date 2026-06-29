---
type: process
title: POC Streamlit
description: Interface de démonstration du pipeline hybride complet, destinée aux tests avec l'équipe métier avant présentation à l'équipe médicale.
resource: poc/app.py
tags: [poc, streamlit, demo]
timestamp: 2026-06-29T00:00:00Z
---

# POC Streamlit

## Objectif

Démontrer visuellement le fonctionnement de l'
[architecture hybride](../architecture/hybrid_pipeline.md) : upload
d'une image, passage par l'étage 1 ([YOLO](../models/yolo_polype.md)),
puis si nécessaire par l'étage 2
([EfficientNet](../models/efficientnet.md)), avec affichage du résultat
final et du chemin de décision suivi.

## Emplacement

`poc/app.py` dans le repository (dossier `poc/`).

## Mode démo

Si les poids des modèles ne sont pas trouvés, l'application bascule
automatiquement en mode démo (prédictions simulées), avec un avertissement
visuel explicite, pour permettre une présentation même sans modèle
entraîné disponible.

## Statut

Validé par le manager. Approuvé pour être maintenu dans le dossier
`poc/` du repository.

## Évolutions proposées

Le manager a proposé de donner à l'équipe médicale la possibilité,
via une interface à construire :

- d'enrichir le [dataset](../data/deep_polypes.md) ;
- d'évaluer les résultats d'inférence (validation/correction des
  prédictions), en vue d'un futur cycle de reinforcement learning.

Ces deux fonctionnalités ne sont pas encore implémentées.
