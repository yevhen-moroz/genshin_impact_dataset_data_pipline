## 🚀 Project Overview

This project implements a **data pipeline for processing and analyzing the Genshin Impact dataset**, with integration into **Google BigQuery**.

The pipeline follows the ETL approach:
- Extract raw data  
- Transform and clean it  
- Load structured data into BigQuery  

The goal of this project is to demonstrate practical skills in building a **data pipeline and integrating it with a cloud data warehouse**.
## 📂 Project structure
- dataset
  - analytic ready
    - `Genshin_Impact_character_dataset.csv`
    - `Genshin_Impact_character_level_stats_long_dataset.csv`
    - `Genshin_Impact_character_special_stats_long_dataset.csv`
  - processed
    - `Genshin_Impact_dataset_cleared.csv`
  - raw
    - `Genshin_Impact_dataset.csv`
- ETL
  - `ETL.py`
  - `queries.sql`
  - `transform.py`
  - `load.py`
- queries
  - query_result
    - `ascension_stage_distribution.csv`
    - `ascension_stat_distribution.csv`
    - `ascension_stats_by_is_special_stat_percent.csv`
    - `avg_stats_by_region_90.csv`
    - `characters_by_region.csv`
    - `region_rarity_distribution.csv`
    - `region_stat_levels_avg.csv`
    - `region_stat_levels_max.csv`
    - `region_stat_levels_min.csv`
    - `region_vision_rarity_distribution.csv`
    - `region_vision_weapon_rarity_distribution.csv`
    - `top_stats_90.csv`
    - `vision_stat_levels_avg.csv`
    - `vision_stat_levels_max.csv`
    - `vision_stat_levels_min.csv`
    - `weapon_stat_levels_avg.csv`
    - `weapon_stat_levels_max.csv`
    - `weapon_stat_levels_min.csv`
  - `queries.sql`
## 📊 Key Features

- Data cleaning and processing  
- Structured dataset generation  
- Preparation for analytics
- Work with a real-world dataset  

## 🎮 Dataset Context

The project uses data related to *Genshin Impact*, an open-world action RPG with multiple characters, stats, and attributes used for analysis. :contentReference[oaicite:1]{index=1}

## ⚠️ Important Note (BigQuery Integration)

The `load.py` module is designed to load processed data into **Google BigQuery**.

⚠️ Running this part of the pipeline requires:
- Google Cloud credentials  
- Configured BigQuery environment  

Because of this, the loading step may not work without proper authentication and will result in a **credentials error**.

👉 However:
- All processed datasets are already exported and available in **CSV format**  
- The transformation pipeline can be reviewed and validated using these files  

This ensures that the results of the data processing are accessible even without BigQuery setup.

## 🔄 Pipeline Workflow
**ETL (`ETL.py`)**
It sequentially runs all stages of the pipeline:
   - Data extraction  
   - Data transformation  
   - Data loading into BigQuery  

1. **Extract(`extract.py`)**  
   - Load raw data from source files  

2. **Transform (`transform.py`)**  
   - Clean and normalize data  
   - Handle missing values  
   - Convert data into a structured format  

3. **Load (`load.py`)**  
   - Load processed data and query result into **Google BigQuery**
   - Export results as CSV files for accessibility

## 🛠️ Technologies Used
- Python  
- Pandas  
- SQL   
- BigQuery

## 🛠️ BigQuery
## 👉 Genshin characters dataset
<img width="1773" height="536" alt="image" src="https://github.com/user-attachments/assets/a76dd46b-5d8c-4e88-8751-aa7fd0a20843" />

<img width="1385" height="496" alt="image" src="https://github.com/user-attachments/assets/7c7e5c91-9312-4e28-9396-8678cb6bd642" />

<img width="1904" height="713" alt="image" src="https://github.com/user-attachments/assets/901994fc-ce93-45fe-b030-485a81311f67" />

## 👉 Genshin characters dataset query result
<img width="2035" height="761" alt="image" src="https://github.com/user-attachments/assets/2ee858ee-20d5-497a-9893-22583e0d37ee" />

<img width="1903" height="712" alt="image" src="https://github.com/user-attachments/assets/0da10bb3-111e-4262-bef7-4059e8e88372" />

<img width="1984" height="744" alt="image" src="https://github.com/user-attachments/assets/89b0e724-cbfe-495e-abe2-d2c18e4bb78b" />



  
