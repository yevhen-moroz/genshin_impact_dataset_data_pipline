-- name: ascension_stat_distribution
SELECT
  ascension_stat,
  COUNT(DISTINCT character_name) AS character_with_stat,
  ROUND(
    COUNT(DISTINCT character_name)
      * 100.0
      / SUM(COUNT(DISTINCT character_name)) OVER (),
    2)
    AS percentage_of_total
FROM `genshin-impact-data-pipeline`.`genshin_characters_dataset`.`special_stats`
GROUP BY ascension_stat
ORDER BY percentage_of_total DESC;



-- name: top_stats_90
SELECT stat_type, character_name, value AS max_value
FROM
  `genshin-impact-data-pipeline`.`genshin_characters_dataset`.`character_stats`
WHERE level_range = '90_90' AND stat_type IN ('hp', 'atk', 'def')
QUALIFY ROW_NUMBER() OVER (PARTITION BY stat_type ORDER BY value DESC) = 1;



-- name: region_rarity_distribution
SELECT
  region,
  rarity,
  COUNT(*) AS character_count,
  STRING_AGG(character_name, ", ") AS characters
FROM `genshin-impact-data-pipeline.genshin_characters_dataset.characters`
WHERE rarity IN (4, 5)
GROUP BY region, rarity
ORDER BY region, rarity DESC;



-- name: region_vision_rarity_distribution
SELECT
  region,
  vision,
  rarity,
  COUNT(*) AS character_count,
  STRING_AGG(character_name, ", ") AS characters
FROM `genshin-impact-data-pipeline.genshin_characters_dataset.characters`
GROUP BY region, vision, rarity
ORDER BY region, vision, rarity DESC;



-- name: region_vision_weapon_rarity_distribution
SELECT
  region,
  vision,
  weapon_type,
  rarity,
  COUNT(*) AS character_count,
  STRING_AGG(character_name, ", ") AS characters
FROM `genshin-impact-data-pipeline.genshin_characters_dataset.characters`
GROUP BY weapon_type, region, vision, rarity
ORDER BY region, vision, rarity DESC;



-- name: avg_stats_by_region_90
SELECT
  t2.region,
  AVG(CASE WHEN stat_type = 'atk' AND level_range = '90_90' THEN value END) AS average_atk_90_90,
  AVG(CASE WHEN stat_type = 'hp' AND level_range = '90_90' THEN value END) AS average_hp_90_90,
  AVG(CASE WHEN stat_type = 'def' AND level_range = '90_90' THEN value END) AS average_def_90_90
FROM `genshin-impact-data-pipeline.genshin_characters_dataset.character_stats` t1
JOIN `genshin-impact-data-pipeline.genshin_characters_dataset.characters` t2
  ON t1.character_name = t2.character_name
GROUP BY t2.region
ORDER BY t2.region;



-- name: ascension_stage_distribution
SELECT
  ascension_stat,
  MAX(CASE WHEN ascension_stage = 0 THEN value END) AS ascension_stage_stat_0,
  MAX(CASE WHEN ascension_stage = 1 THEN value END) AS ascension_stage_stat_1,
  MAX(CASE WHEN ascension_stage = 2 THEN value END) AS ascension_stage_stat_2,
  MAX(CASE WHEN ascension_stage = 3 THEN value END) AS ascension_stage_stat_3,
  MAX(CASE WHEN ascension_stage = 4 THEN value END) AS ascension_stage_stat_4,
  MAX(CASE WHEN ascension_stage = 5 THEN value END) AS ascension_stage_stat_5,
  MAX(CASE WHEN ascension_stage = 6 THEN value END) AS ascension_stage_stat_6
FROM `genshin-impact-data-pipeline`.`genshin_characters_dataset`.`special_stats`
GROUP BY ascension_stat
ORDER BY ascension_stat;



-- name: region_stat_levels_max
SELECT
  t2.region,
  t1.stat_type,

  MAX(CASE WHEN level_start = 1  THEN value END) AS lvl_1_20,
  MAX(CASE WHEN level_start = 20 THEN value END) AS lvl_20_40,
  MAX(CASE WHEN level_start = 40 THEN value END) AS lvl_40_50,
  MAX(CASE WHEN level_start = 50 THEN value END) AS lvl_50_60,
  MAX(CASE WHEN level_start = 60 THEN value END) AS lvl_60_70,
  MAX(CASE WHEN level_start = 70 THEN value END) AS lvl_70_80,
  MAX(CASE WHEN level_start = 80 THEN value END) AS lvl_80_90,
  MAX(CASE WHEN level_start = 90 THEN value END) AS lvl_90_90

FROM `genshin-impact-data-pipeline.genshin_characters_dataset.character_stats` t1
JOIN `genshin-impact-data-pipeline.genshin_characters_dataset.characters` t2
  ON t1.character_name = t2.character_name

GROUP BY t2.region, t1.stat_type
ORDER BY t2.region;



-- name: region_stat_levels_avg
SELECT
  t2.region,
  t1.stat_type,

  AVG(CASE WHEN level_start = 1  THEN value END) AS lvl_1_20,
  AVG(CASE WHEN level_start = 20 THEN value END) AS lvl_20_40,
  AVG(CASE WHEN level_start = 40 THEN value END) AS lvl_40_50,
  AVG(CASE WHEN level_start = 50 THEN value END) AS lvl_50_60,
  AVG(CASE WHEN level_start = 60 THEN value END) AS lvl_60_70,
  AVG(CASE WHEN level_start = 70 THEN value END) AS lvl_70_80,
  AVG(CASE WHEN level_start = 80 THEN value END) AS lvl_80_90,
  AVG(CASE WHEN level_start = 90 THEN value END) AS lvl_90_90

FROM `genshin-impact-data-pipeline.genshin_characters_dataset.character_stats` t1
JOIN `genshin-impact-data-pipeline.genshin_characters_dataset.characters` t2
  ON t1.character_name = t2.character_name

GROUP BY t2.region, t1.stat_type
ORDER BY t2.region;



-- name: region_stat_levels_min
SELECT
  t2.region,
  t1.stat_type,

  MIN(CASE WHEN level_start = 1  THEN value END) AS lvl_1_20,
  MIN(CASE WHEN level_start = 20 THEN value END) AS lvl_20_40,
  MIN(CASE WHEN level_start = 40 THEN value END) AS lvl_40_50,
  MIN(CASE WHEN level_start = 50 THEN value END) AS lvl_50_60,
  MIN(CASE WHEN level_start = 60 THEN value END) AS lvl_60_70,
  MIN(CASE WHEN level_start = 70 THEN value END) AS lvl_70_80,
  MIN(CASE WHEN level_start = 80 THEN value END) AS lvl_80_90,
  MIN(CASE WHEN level_start = 90 THEN value END) AS lvl_90_90

FROM `genshin-impact-data-pipeline.genshin_characters_dataset.character_stats` t1
JOIN `genshin-impact-data-pipeline.genshin_characters_dataset.characters` t2
  ON t1.character_name = t2.character_name

GROUP BY t2.region, t1.stat_type
ORDER BY t2.region;



-- name: weapon_stat_levels_max
SELECT
  t2.weapon_type,
  t1.stat_type,

  MAX(CASE WHEN level_start = 1  THEN value END) AS lvl_1_20,
  MAX(CASE WHEN level_start = 20 THEN value END) AS lvl_20_40,
  MAX(CASE WHEN level_start = 40 THEN value END) AS lvl_40_50,
  MAX(CASE WHEN level_start = 50 THEN value END) AS lvl_50_60,
  MAX(CASE WHEN level_start = 60 THEN value END) AS lvl_60_70,
  MAX(CASE WHEN level_start = 70 THEN value END) AS lvl_70_80,
  MAX(CASE WHEN level_start = 80 THEN value END) AS lvl_80_90,
  MAX(CASE WHEN level_start = 90 THEN value END) AS lvl_90_90

FROM `genshin-impact-data-pipeline.genshin_characters_dataset.character_stats` t1
JOIN `genshin-impact-data-pipeline.genshin_characters_dataset.characters` t2
  ON t1.character_name = t2.character_name

GROUP BY t2.weapon_type, t1.stat_type
ORDER BY t2.weapon_type;



-- name: weapon_stat_levels_avg
SELECT
  t2.weapon_type,
  t1.stat_type,

  AVG(CASE WHEN level_start = 1  THEN value END) AS lvl_1_20,
  AVG(CASE WHEN level_start = 20 THEN value END) AS lvl_20_40,
  AVG(CASE WHEN level_start = 40 THEN value END) AS lvl_40_50,
  AVG(CASE WHEN level_start = 50 THEN value END) AS lvl_50_60,
  AVG(CASE WHEN level_start = 60 THEN value END) AS lvl_60_70,
  AVG(CASE WHEN level_start = 70 THEN value END) AS lvl_70_80,
  AVG(CASE WHEN level_start = 80 THEN value END) AS lvl_80_90,
  AVG(CASE WHEN level_start = 90 THEN value END) AS lvl_90_90

FROM `genshin-impact-data-pipeline.genshin_characters_dataset.character_stats` t1
JOIN `genshin-impact-data-pipeline.genshin_characters_dataset.characters` t2
  ON t1.character_name = t2.character_name

GROUP BY t2.weapon_type, t1.stat_type
ORDER BY t2.weapon_type;



-- name: weapon_stat_levels_min
SELECT
  t2.weapon_type,
  t1.stat_type,

  MIN(CASE WHEN level_start = 1  THEN value END) AS lvl_1_20,
  MIN(CASE WHEN level_start = 20 THEN value END) AS lvl_20_40,
  MIN(CASE WHEN level_start = 40 THEN value END) AS lvl_40_50,
  MIN(CASE WHEN level_start = 50 THEN value END) AS lvl_50_60,
  MIN(CASE WHEN level_start = 60 THEN value END) AS lvl_60_70,
  MIN(CASE WHEN level_start = 70 THEN value END) AS lvl_70_80,
  MIN(CASE WHEN level_start = 80 THEN value END) AS lvl_80_90,
  MIN(CASE WHEN level_start = 90 THEN value END) AS lvl_90_90

FROM `genshin-impact-data-pipeline.genshin_characters_dataset.character_stats` t1
JOIN `genshin-impact-data-pipeline.genshin_characters_dataset.characters` t2
  ON t1.character_name = t2.character_name

GROUP BY t2.weapon_type, t1.stat_type
ORDER BY t2.weapon_type;



-- name: vision_stat_levels_max
SELECT
  t2.vision,
  t1.stat_type,

  MAX(CASE WHEN level_start = 1  THEN value END) AS lvl_1_20,
  MAX(CASE WHEN level_start = 20 THEN value END) AS lvl_20_40,
  MAX(CASE WHEN level_start = 40 THEN value END) AS lvl_40_50,
  MAX(CASE WHEN level_start = 50 THEN value END) AS lvl_50_60,
  MAX(CASE WHEN level_start = 60 THEN value END) AS lvl_60_70,
  MAX(CASE WHEN level_start = 70 THEN value END) AS lvl_70_80,
  MAX(CASE WHEN level_start = 80 THEN value END) AS lvl_80_90,
  MAX(CASE WHEN level_start = 90 THEN value END) AS lvl_90_90

FROM `genshin-impact-data-pipeline.genshin_characters_dataset.character_stats` t1
JOIN `genshin-impact-data-pipeline.genshin_characters_dataset.characters` t2
  ON t1.character_name = t2.character_name

GROUP BY t2.vision, t1.stat_type
ORDER BY t2.vision;



-- name: vision_stat_levels_avg
SELECT
  t2.vision,
  t1.stat_type,

  AVG(CASE WHEN level_start = 1  THEN value END) AS lvl_1_20,
  AVG(CASE WHEN level_start = 20 THEN value END) AS lvl_20_40,
  AVG(CASE WHEN level_start = 40 THEN value END) AS lvl_40_50,
  AVG(CASE WHEN level_start = 50 THEN value END) AS lvl_50_60,
  AVG(CASE WHEN level_start = 60 THEN value END) AS lvl_60_70,
  AVG(CASE WHEN level_start = 70 THEN value END) AS lvl_70_80,
  AVG(CASE WHEN level_start = 80 THEN value END) AS lvl_80_90,
  AVG(CASE WHEN level_start = 90 THEN value END) AS lvl_90_90

FROM `genshin-impact-data-pipeline.genshin_characters_dataset.character_stats` t1
JOIN `genshin-impact-data-pipeline.genshin_characters_dataset.characters` t2
  ON t1.character_name = t2.character_name

GROUP BY t2.vision, t1.stat_type
ORDER BY t2.vision;



-- name: vision_stat_levels_min
SELECT
  t2.vision,
  t1.stat_type,

  MIN(CASE WHEN level_start = 1  THEN value END) AS lvl_1_20,
  MIN(CASE WHEN level_start = 20 THEN value END) AS lvl_20_40,
  MIN(CASE WHEN level_start = 40 THEN value END) AS lvl_40_50,
  MIN(CASE WHEN level_start = 50 THEN value END) AS lvl_50_60,
  MIN(CASE WHEN level_start = 60 THEN value END) AS lvl_60_70,
  MIN(CASE WHEN level_start = 70 THEN value END) AS lvl_70_80,
  MIN(CASE WHEN level_start = 80 THEN value END) AS lvl_80_90,
  MIN(CASE WHEN level_start = 90 THEN value END) AS lvl_90_90

FROM `genshin-impact-data-pipeline.genshin_characters_dataset.character_stats` t1
JOIN `genshin-impact-data-pipeline.genshin_characters_dataset.characters` t2
  ON t1.character_name = t2.character_name

GROUP BY t2.vision, t1.stat_type
ORDER BY t2.vision;

-- name: characters_by_region
SELECT region, STRING_AGG(character_name, ", ") AS characters, COUNT(*) AS character_count
FROM `genshin-impact-data-pipeline`.`genshin_characters_dataset`.`characters`
WHERE
  region IN (
    "Mondstadt", "Liyue", "Inazuma", "Sumeru", "Fontaine", "Natlan",
    "Snezhnaya", "Unknown")
GROUP BY region
ORDER BY region;

-- name: ascension_stats_by_is_special_stat_percent
SELECT
  is_special_stat_percent,
  STRING_AGG(DISTINCT ascension_stat, ", ") AS ascension_stats,
  COUNT(DISTINCT character_name) AS character_count
FROM `genshin-impact-data-pipeline`.`genshin_characters_dataset`.`special_stats`
WHERE is_special_stat_percent IN (TRUE, FALSE)
GROUP BY is_special_stat_percent
ORDER BY is_special_stat_percent;


