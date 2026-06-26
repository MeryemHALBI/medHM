import pandas as pd
import streamlit as st
from pathlib import Path
import traceback

BASE_DIR = Path(__file__).parent
CSV_PATH = BASE_DIR / "full_classification_metrics.csv"

@st.cache_data
def load_data():
    try:
        df = pd.read_csv(CSV_PATH)
        st.success("CSV loaded successfully!")
        return df
    except Exception as e:
        st.error(f"Exception type: {type(e).__name__}")
        st.exception(e)
        st.code(traceback.format_exc())
        return None
