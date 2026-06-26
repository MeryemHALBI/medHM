from pathlib import Path
import os
import pandas as pd
import streamlit as st

BASE_DIR = Path(__file__).parent
CSV_PATH = BASE_DIR / "full_classification_metrics.csv"

st.write("Current working directory:", os.getcwd())
st.write("App directory:", BASE_DIR)
st.write("Files in app directory:", os.listdir(BASE_DIR))
st.write("CSV path:", CSV_PATH)
st.write("CSV exists:", CSV_PATH.exists())

@st.cache_data
def load_data():
    return pd.read_csv(CSV_PATH)

df = load_data()
