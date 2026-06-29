---
type: process
title: Backend FastAPI
description: API REST exposant le modèle EfficientNet (étage 2) pour la classification d'images jugées suspectes par l'étage 1.
resource: backend/main.py
tags: [backend, api, fastapi, etage-2]
timestamp: 2026-06-29T00:00:00Z
---

# Backend FastAPI

## Objectif

Exposer le modèle [EfficientNet](../models/efficientnet.md) (étage 2 de
l'[architecture hybride](../architecture/hybrid_pipeline.md)) via une
API REST, appelée par l'[application mobile](mobile_app.md) uniquement
lorsque l'étage 1 détecte une anomalie suspecte.

## Endpoints

- `GET /health` — vérifie que le serveur tourne et que le modèle est
  chargé.
- `POST /predict` — reçoit une image, renvoie la classe prédite, la
  confiance, et le détail des probabilités pour les 4 classes.

## Emplacement

`backend/main.py`, `backend/requirements.txt`, poids attendus dans
`backend/weights/efficientnet_etage2.pt`.

## Statut

Testé en local avec succès (`uvicorn main:app`), réponses validées sur
`/health` et `/predict`. Pas encore déployé en ligne — accessible
uniquement depuis la machine de développement (`localhost:8000`).

## Prochaine étape

Déploiement sur un service cloud accessible publiquement, pour que
l'[application mobile](mobile_app.md) puisse l'appeler en dehors du
réseau local de développement.
