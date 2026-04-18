import pandas as pd
import re

def transform_data(df):

    df.columns = df.columns.str.lower().str.strip()

    df["region"] = df["region"].fillna("Unknown")
    df["arkhe"] = df["arkhe"].fillna("None")
    df["limited"] = df["limited"].fillna("False")
    df = df.rename(columns= {"ascension" : "ascension_stat"})

    special_stat_columns = [
    col for col in df.columns
    if re.match(r"^special_\d+$", col.lower())
]

    rename_dict = {}
    for i, column_name in enumerate(special_stat_columns):
        rename_dict[column_name] = f"special_ascension_stat_{i}"

    df = df.rename(columns=rename_dict)

    special_cols = [
    col for col in df.columns
    if re.match(r"^special_ascension_stat_\d+$", col)
]

  
    df["is_special_stat_percent"] = df[special_cols] \
        .astype(str) \
        .apply(lambda row: row.str.contains("%").any(), axis=1)


    df = types_normalization(df)
    create_analytics_datasets(df)
    save_cleared_data_to_csv(df)
    

def types_normalization(df):

    for column_name in df.columns:
        column_name_ = column_name.lower()

        if re.match(r"^special_ascension_stat_\d+$", column_name_):
            df[column_name_] = (
                df[column_name_]
                .astype(str)
                .str.replace("%", "", regex=False)
                .str.strip()
            )
            df[column_name_] = pd.to_numeric(df[column_name_], errors="coerce").astype(float)

        elif re.match(r"^(hp|atk|def)_\d+_\d+$", column_name_) or column_name_ == "rarity":
            df[column_name] = pd.to_numeric(df[column_name_], errors="coerce").astype(int)
            
        elif column_name_ == "release_date":
            df[column_name_] = pd.to_datetime(df[column_name_], errors="coerce")
            
    return df

def save_cleared_data_to_csv(df):
    df.to_csv("dataset\_processed_\Genshin_Impact_dataset_cleared.csv", index=False)
    print("Data transformed and saved!")

def create_analytics_datasets(df):
    create_character_table(df)
    create_character_stats_long(df)
    create_special_stats_long(df)
    
def create_character_table(df):
    cols = [
        "character_name", "rarity", "vision", "region",
        "weapon_type", "affiliation", "release_date",
        "limited", "ascension_stat", "is_special_stat_percent"
    ]

    cols = [c for c in cols if c in df.columns]

    character_df = df[cols].copy()

    character_df.to_csv("dataset\_analytic_ready_\Genshin_Impact_character_dataset.csv", index=False)

    print("Character table created!")

    return character_df

def create_special_stats_long(df):
    special_cols = [
        col for col in df.columns
        if "special_ascension_stat_" in col
    ]

    long_df = df.melt(
        id_vars=["character_name", "ascension_stat", "is_special_stat_percent"],
        value_vars=special_cols,
        var_name="ascension_stage",
        value_name="value"
    )

    long_df["ascension_stage"] = long_df["ascension_stage"].str.extract(r"(\d+)").astype(int)
    long_df = long_df.sort_values(
    by=["character_name", "ascension_stage"]
)

    long_df.to_csv("dataset\_analytic_ready_\Genshin_Impact_character_special_stats_long_dataset.csv", index=False)

    print("Special stats long created!")

    return long_df

def create_character_stats_long(df):
    stat_cols = [
        col for col in df.columns
        if any(stat in col for stat in ["hp_", "atk_", "def_"])
    ]

    long_df = df.melt(
        id_vars=["character_name"],
        value_vars=stat_cols,
        var_name="stat_level",
        value_name="value"
    )

    long_df[["stat_type", "level_range"]] = long_df["stat_level"].str.extract(
        r"(hp|atk|def)_(\d+_\d+)"
    )

    long_df = long_df.drop(columns=["stat_level"])
    long_df["level_start"] = long_df["level_range"].str.extract(r"(\d+)").astype(int)

    long_df = long_df.sort_values(
    by=["character_name", "stat_type", "level_start"]
)
    long_df.to_csv("dataset\_analytic_ready_\Genshin_Impact_character_level_stats_long_dataset.csv", index=False)

    print("Character stats long created!")

    return long_df
