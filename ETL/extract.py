import pandas as pd

dataset_path = "dataset\_raw_\Genshin_Impact_dataset.csv"

def extract_data():
    try:
        df = pd.read_csv(dataset_path)
        return df
    except Exception as e:
        print("Error while loading data:", e)
        return None
