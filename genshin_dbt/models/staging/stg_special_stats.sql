SELECT
    character_name,
    ascension_stat,
    is_special_stat_percent,
    ascension_stage,
    value
FROM {{ source('genshin_characters_dataset', 'special_stats') }}