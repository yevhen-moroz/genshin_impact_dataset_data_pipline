from google.cloud import bigquery
import pandas as pd
import os
project_ID = "genshin-impact-data-pipeline"
dataset_ID = "genshin_characters_dataset"
query_dataset_ID = "genshin_characters_dataset_query_result"
queries_result_folder = "queries\queries_result"
queries_sql = "queries\queries.sql"



client = bigquery.Client(project=project_ID)


def load_to_bigquery(df, table_name):
    table_id = f"{project_ID}.{dataset_ID}.{table_name}"

    job = client.load_table_from_dataframe(df, table_id)
    job.result()

    print(f"Loaded {table_name} to BigQuery!")


def load_all():
    cleared_dataset = pd.read_csv("dataset\_processed_\Genshin_Impact_dataset_cleared.csv")
    characters = pd.read_csv("dataset\_analytic_ready_\Genshin_Impact_character_dataset.csv")
    stats = pd.read_csv("dataset\_analytic_ready_\Genshin_Impact_character_level_stats_long_dataset.csv")
    special = pd.read_csv("dataset\_analytic_ready_\Genshin_Impact_character_special_stats_long_dataset.csv")

    load_to_bigquery(cleared_dataset, "cleared_dataset")
    load_to_bigquery(characters, "characters")
    load_to_bigquery(stats, "character_stats")
    load_to_bigquery(special, "special_stats")
    load_queries_to_bigquery()


def load_queries_to_bigquery():

    with open(queries_sql, "r", encoding="utf-8") as f:
        sql_script = f.read()

    _queries_ = [q.strip() for q in sql_script.split(";") if q.strip()]
    queries = {}

    current_name = None

    for querie_with_name in _queries_:

        _querie_with_name_ = querie_with_name.split("\n")

        for line in _querie_with_name_:
            if "-- name:" in line:
                current_name = line.replace("-- name:", "").strip()

        clean_query = "\n".join([l for l in _querie_with_name_ if not l.strip().startswith("--")])

        if current_name:
            queries[current_name] = clean_query


    for name, query in queries.items():

        print(f"\nRunning {name}")

        df = client.query(query).to_dataframe()

        table_id = f"{project_ID}.{query_dataset_ID}.{name}"

        job = client.load_table_from_dataframe(df, table_id)
        job.result()

        print(f"\nLoaded to BigQuery: {table_id}")

        file_path = os.path.join(queries_result_folder, f"{name}.csv")
        df.to_csv(file_path, index=False)

        print(f"\n Saved: {name}")