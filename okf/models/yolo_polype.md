---
type: metric
title: YOLO — détection de polypes (étage 1)
description: Modèle YOLO nano/small entraîné pour la détection de présence de polype, conçu pour tourner localement sur l'application mobile.
tags: [model, detection, yolo, etage-1, embarque]
timestamp: 2026-06-29T00:00:00Z
---

# YOLO — étage 1

## Description

Modèle YOLO nano (`yolo11n`) entraîné en deux temps :

1. Entraînement initial sur [Kvasir-SEG](../data/kvasir_seg.md) (bounding
   boxes de polypes déjà disponibles).
2. Utilisation de ce modèle pour pré-annoter automatiquement les images
   `polype` du [dataset deep_polypes](../data/deep_polypes.md), suivi
   d'une vérification visuelle et d'un ré-entraînement sur ce nouveau
   jeu de données filtré.

## Décision de scope

Sur demande du manager, ce modèle a été limité à une tâche binaire :
détecter si un polype est présent ou non (classes `polype` vs `normal`),
plutôt que les 4 classes complètes. Les classes `mici` et
`mauvaise_preparation` ne sont pas couvertes par YOLO à ce stade.

## Résultats mesurés (run initial, modèle Kvasir-SEG appliqué tel quel)

| Métrique | Valeur |
|---|---|
| Accuracy | 0.9342 |
| Précision | 1.0000 |
| Rappel | 0.7826 |

Matrice de confusion : 53 vrais normaux, 0 fausse alerte, 5 polypes
ratés, 18 vrais polypes détectés.

## Point d'attention

Le rappel (0.78) est jugé plus critique que la précision en contexte
médical : un polype raté (faux négatif) est plus coûteux qu'une fausse
alerte vérifiée par un médecin. Piste d'amélioration identifiée :
abaisser le seuil de confiance de détection (`conf`), au prix d'un
nombre plus élevé de fausses alertes.

## Rôle dans l'architecture

Constitue l'**étage 1** de l'[architecture hybride](../architecture/hybrid_pipeline.md),
intégré dans l'[application mobile Flutter](../components/mobile_app.md).
