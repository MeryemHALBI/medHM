# Backend medet — étage 2 (cloud)

API FastAPI exposant le modèle EfficientNet entraîné dans
`Hybrid_Pipeline_YOLO_EfficientNet.ipynb`.

## Installation

```bash
pip install -r requirements.txt
```

## Placer les poids du modèle

Copier le fichier de poids entraîné (`efficientnet_etage2.pt`) dans :

```
weights/efficientnet_etage2.pt
```

Si ce fichier est absent, le serveur démarre quand même mais `/predict`
renverra une erreur 503 jusqu'à ce que les poids soient ajoutés.

## Lancer le serveur

```bash
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```

`--reload` est utile en développement (relance automatique si le code
change) — à retirer en production.

## Tester l'API

Documentation interactive auto-générée (Swagger UI) :

```
http://localhost:8000/docs
```

Vérifier que le serveur et le modèle sont bien chargés :

```bash
curl http://localhost:8000/health
```

Envoyer une image pour prédiction (remplacer `image.jpg` par un vrai
fichier) :

```bash
curl -X POST "http://localhost:8000/predict" \
  -F "file=@image.jpg"
```

Réponse attendue (exemple) :

```json
{
  "predicted_class": "polype",
  "confidence": 0.94,
  "all_probabilities": {
    "mauvaise_preparation": 0.01,
    "mici": 0.03,
    "normal": 0.02,
    "polype": 0.94
  }
}
```

## Notes pour la suite

- CORS est actuellement ouvert à tous les domaines (`allow_origins=["*"]`),
  pratique en développement mais à restreindre avant la mise en
  production (autoriser uniquement le domaine de l'app mobile/backend
  officiel).
- Pas d'authentification pour l'instant — à ajouter (clé API ou token)
  avant tout déploiement accessible publiquement.
- Le modèle est chargé une seule fois au démarrage du serveur, pas à
  chaque requête, pour des raisons de performance.
