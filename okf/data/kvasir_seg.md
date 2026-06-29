---
type: table
title: Dataset Kvasir-SEG
description: Dataset public de polypes coloscopiques avec bounding boxes, utilisé pour pré-entraîner le modèle YOLO et pré-annoter le dataset deep_polypes.
resource: https://datasets.simula.no/kvasir-seg/
tags: [dataset, detection, yolo, public]
timestamp: 2026-06-29T00:00:00Z
---

# Dataset Kvasir-SEG

## Description

Dataset public contenant 1000 images de polypes coloscopiques, avec
leurs bounding boxes stockées dans un fichier JSON
(`kavsir_bboxes.json`).

## Rôle dans le projet

- Sert à entraîner un premier modèle [YOLO](../models/yolo_polype.md)
  capable de détecter la classe `polype` avec localisation.
- Ce modèle entraîné sur Kvasir-SEG est ensuite utilisé pour
  pré-annoter automatiquement les images `polype` du dataset
  [deep_polypes](deep_polypes.md), qui n'avait initialement que des
  labels de classe sans bounding box.

## Limite connue

Kvasir-SEG ne couvre que la classe `polype`. Les classes `mici` et
`mauvaise_preparation` n'ont pas d'équivalent public en bounding boxes
et nécessiteraient une annotation manuelle si elles devaient être
intégrées à l'étage YOLO dans une phase future.
