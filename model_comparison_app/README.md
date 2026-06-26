# Comparaison des modèles — interface interactive

Interface Streamlit pour explorer et comparer les métriques des 5
modèles entraînés sur la tâche de classification (`normal`, `polype`,
`mici`, `mauvaise_preparation`) : EfficientNet, Swin Transformer,
ResNet50, ConvNeXt, ViT.

## Contenu

```
model_comparison_app/
├── app.py                          interface Streamlit
├── requirements.txt                dépendances
├── full_classification_metrics.csv données (générées par le notebook)
└── README.md
```

## Origine des données

Le fichier `full_classification_metrics.csv` est généré par le notebook
`Model_Comparison.ipynb` (section « Tableau complet des métriques »).
Cette application ne fait que **lire et afficher** ces résultats —
aucun entraînement ni recalcul n'est effectué ici.

Si le dataset ou les modèles sont mis à jour, il faut réexécuter le
notebook puis remplacer ce fichier CSV.

## Installation et lancement en local

```bash
pip install -r requirements.txt
streamlit run app.py
```

## Fonctionnalités

- **Menu latéral** pour choisir :
  - la vue globale (macro/weighted) ou le détail par classe,
  - la métrique à comparer (Accuracy, Précision, Rappel, F1, Temps
    d'exécution).
- **Graphique en barres** des modèles, triés du meilleur au moins bon
  (ou du plus rapide au plus lent pour le temps d'exécution).
- **Mise en avant automatique** du meilleur modèle pour la métrique
  sélectionnée, avec classement complet.
- **Vue d'ensemble** récapitulant toutes les métriques principales.
- **Tableau de données complet** (optionnel, activable/désactivable).

## Déploiement (lien partageable pour présentation)

1. Committer ce dossier (avec le CSV) sur GitHub.
2. Aller sur [share.streamlit.io](https://share.streamlit.io) et se
   connecter avec son compte GitHub.
3. « New app » → sélectionner le repo, la branche, et le chemin de
   `app.py` dans ce dossier.
4. Déployer — un lien du type `https://nom-app.streamlit.app` est
   généré, prêt à partager.
