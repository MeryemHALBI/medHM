"""
Comparaison des modèles — Streamlit
=====================================

Interface interactive pour présenter et explorer les métriques de
comparaison des 5 modèles entraînés (EfficientNet, Swin Transformer,
ResNet50, ConvNeXt, ViT) sur la tâche de classification d'anomalies
digestives.

Les données proviennent de `full_classification_metrics.csv`, généré
par le notebook Model_Comparison.ipynb. Ce fichier ne fait QUE lire et
afficher ces résultats déjà calculés — aucun entraînement de modèle
n'est exécuté ici.

Pour lancer en local :
    pip install -r requirements.txt
    streamlit run app.py
"""

import pandas as pd
import streamlit as st

# -------------------------------------------------------------------
# Configuration
# -------------------------------------------------------------------

CSV_PATH = "full_classification_metrics.csv"
CLASS_NAMES = ["normal", "polype", "mici", "mauvaise_preparation"]

st.set_page_config(
    page_title="Comparaison des modèles — medet",
    page_icon="📊",
    layout="wide",
)

# -------------------------------------------------------------------
# Chargement des données
# -------------------------------------------------------------------


@st.cache_data
def load_data():
    try:
        return pd.read_csv(CSV_PATH)
    except FileNotFoundError:
        return None


df = load_data()

st.title("📊 Comparaison des modèles de classification")
st.caption(
    "EfficientNet · Swin Transformer · ResNet50 · ConvNeXt · ViT — "
    "détection d'anomalies digestives (normal, polype, mici, mauvaise préparation)"
)

if df is None:
    st.error(
        f"Fichier `{CSV_PATH}` introuvable. Place-le dans le même dossier "
        "que `app.py` (généré par le notebook Model_Comparison.ipynb, "
        "section 'Tableau complet des métriques')."
    )
    st.stop()

st.divider()

# -------------------------------------------------------------------
# Menu latéral — choix de la vue et de la métrique
# -------------------------------------------------------------------

st.sidebar.header("Options d'affichage")

view_mode = st.sidebar.radio(
    "Type de comparaison",
    ["Vue globale (macro)", "Par classe"],
)

if view_mode == "Vue globale (macro)":
    metric_options = {
        "Accuracy": "Accuracy",
        "Précision (macro)": "Precision (macro)",
        "Rappel (macro)": "Recall (macro)",
        "F1-score (macro)": "F1 (macro)",
        "Précision (weighted)": "Precision (weighted)",
        "Rappel (weighted)": "Recall (weighted)",
        "F1-score (weighted)": "F1 (weighted)",
        "Temps d'exécution (ms/image)": "Temps moyen (ms/image)",
    }
    selected_label = st.sidebar.selectbox("Métrique à comparer", list(metric_options.keys()))
    selected_metric = metric_options[selected_label]

else:
    selected_class = st.sidebar.selectbox("Classe", CLASS_NAMES)
    metric_options = {
        "Précision": f"Precision_{selected_class}",
        "Rappel": f"Recall_{selected_class}",
        "F1-score": f"F1_{selected_class}",
    }
    selected_label = st.sidebar.selectbox("Métrique à comparer", list(metric_options.keys()))
    selected_metric = metric_options[selected_label]

show_table = st.sidebar.checkbox("Afficher le tableau de données", value=True)

st.sidebar.divider()
st.sidebar.caption(
    "Les temps d'exécution sont mesurés sur le GPU utilisé lors de "
    "l'entraînement (Colab T4). Une métrique plus basse est meilleure "
    "uniquement pour le temps d'exécution."
)

# -------------------------------------------------------------------
# Graphique principal
# -------------------------------------------------------------------

is_time_metric = "Temps" in selected_metric
sorted_df = df.sort_values(selected_metric, ascending=is_time_metric)

col_chart, col_best = st.columns([3, 1])

with col_chart:
    st.subheader(f"{selected_label} — comparaison par modèle")
    st.bar_chart(
        sorted_df.set_index("Model")[selected_metric],
        height=420,
    )

with col_best:
    best_row = sorted_df.iloc[0]
    label_best = "Plus rapide" if is_time_metric else "Meilleur modèle"
    st.metric(
        label=label_best,
        value=best_row["Model"],
        delta=f"{best_row[selected_metric]:.4f}" if not is_time_metric else f"{best_row[selected_metric]:.1f} ms",
    )

    st.markdown("**Classement complet**")
    for i, (_, row) in enumerate(sorted_df.iterrows(), start=1):
        value_str = f"{row[selected_metric]:.4f}" if not is_time_metric else f"{row[selected_metric]:.1f} ms"
        st.write(f"{i}. {row['Model']} — {value_str}")

st.divider()

# -------------------------------------------------------------------
# Vue multi-métriques (toujours visible, pour une vision d'ensemble)
# -------------------------------------------------------------------

st.subheader("Vue d'ensemble — toutes les métriques principales")

overview_cols = ["Model", "Accuracy", "Precision (macro)", "Recall (macro)",
                  "F1 (macro)", "Temps moyen (ms/image)"]
overview_df = df[overview_cols].sort_values("Accuracy", ascending=False)

st.dataframe(
    overview_df.style.format({
        "Accuracy": "{:.4f}",
        "Precision (macro)": "{:.4f}",
        "Recall (macro)": "{:.4f}",
        "F1 (macro)": "{:.4f}",
        "Temps moyen (ms/image)": "{:.2f}",
    }),
    use_container_width=True,
    hide_index=True,
)

# -------------------------------------------------------------------
# Tableau de données complet (optionnel)
# -------------------------------------------------------------------

if show_table:
    st.divider()
    st.subheader("Tableau de données complet")
    st.dataframe(df, use_container_width=True, hide_index=True)

st.divider()
st.caption(
    "Données issues de Model_Comparison.ipynb — interface de présentation, "
    "aucun recalcul effectué ici."
)
