SELECT
    character_name,
    rarity,
    vision,
    region,
    weapon_type,
    affiliation,
    CAST(release_date AS STRING) AS release_date,
    limited,
    ascension_stat,
    is_special_stat_percent
FROM {{ source('genshin_characters_dataset', 'characters') }}