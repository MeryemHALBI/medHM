# medet — Application mobile (Flutter)

Application mobile du projet **medet**, premier maillon du pipeline hybride
de détection de polypes du tube digestif.

## Statut actuel

Structure de base de l'application, avec un pipeline d'analyse **simulé**
(mock). Les deux points d'intégration réels — modèle YOLO embarqué et appel
au backend cloud — sont identifiés par des commentaires `TODO` dans le
code, prêts à être branchés une fois disponibles.

## Structure du projet

```
lib/
├── main.dart                       point d'entrée de l'application
├── models/
│   └── analysis_result.dart        modèle de données du résultat d'analyse
├── services/
│   ├── analysis_provider.dart      état partagé (Provider) de l'analyse en cours
│   └── pipeline_service.dart       logique du pipeline (étage 1 + étage 2)
└── screens/
    ├── home_screen.dart            écran d'accueil (prendre photo / importer)
    ├── analysis_screen.dart        écran de chargement pendant l'analyse
    └── result_screen.dart          écran de résultat final
```

## Écrans

1. **Accueil** — deux boutons : prendre une photo (caméra) ou importer une
   image existante (galerie).
2. **Analyse** — écran de chargement pendant l'inférence de l'étage 1
   (YOLO local), puis de l'étage 2 (cloud) si nécessaire.
3. **Résultat** — affiche la classe finale (`normal`, `polype`, `mici`,
   `mauvaise_preparation`) avec un code couleur, et indique si le modèle
   cloud a été appelé ou non.

## Installation

Prérequis : [Flutter SDK](https://flutter.dev) installé.

```bash
flutter pub get
flutter run
```

## Points d'intégration à venir

### 1. Étage 1 — modèle YOLO local (`pipeline_service.dart`)

Actuellement simulé par un tirage aléatoire. À remplacer par :
- Conversion du modèle entraîné (`yolo_polype_best.pt`) en `.tflite`.
- Intégration via le package `tflite_flutter`.
- Chargement du modèle en asset (voir commentaire dans `pubspec.yaml`).

### 2. Étage 2 — backend cloud (`pipeline_service.dart`)

Actuellement simulé. À remplacer par un appel HTTP réel vers le backend
FastAPI (`backend/main.py`, endpoint `/predict`). L'exemple de code est déjà
présent en commentaire dans `_runCloudStage()` — il suffit de renseigner
`backendUrl` et de décommenter le bloc correspondant.

## Notes

- Gestion d'état : `provider` (choisi pour sa simplicité, suffisant pour
  les besoins actuels de l'application).
- Pas encore d'écran "historique" ni "détail anomalie" — à ajouter une fois
  le besoin confirmé avec le manager et l'équipe médicale (cf. schéma
  d'architecture mobile discuté en amont).
