from pathlib import Path
import pandas as pd
import streamlit as st

BASE_DIR = Path(__file__).parent
CSV_PATH = BASE_DIR / "full_classification_metrics.csv"

st.set_page_config(
    page_title="Comparaison des modèles — medet",
    page_icon="📊",
    layout="wide",
)

@st.cache_data
def load_data():
    df = pd.read_csv(CSV_PATH)
    return df

st.title("📊 Comparaison des modèles")

st.write("App directory:", BASE_DIR)
st.write("CSV path:", CSV_PATH)
st.write("CSV exists:", CSV_PATH.exists())

if not CSV_PATH.exists():
    st.error(f"Le fichier est introuvable : {CSV_PATH}")
    st.stop()

try:
    df = load_data()
except Exception as e:
    st.exception(e)
    st.stop()

st.success("✅ CSV chargé avec succès")
st.write(df.head())
st.write("Colonnes :", list(df.columns))
