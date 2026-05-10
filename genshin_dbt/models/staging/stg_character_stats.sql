SELECT
    character_name,
    stat_type,
    value,
    level_range,
    level_start
FROM {{ source('genshin_characters_dataset', 'character_stats') }}