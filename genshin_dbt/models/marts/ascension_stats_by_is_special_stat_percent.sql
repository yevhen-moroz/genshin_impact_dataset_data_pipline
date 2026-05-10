SELECT
  is_special_stat_percent,
  STRING_AGG(DISTINCT ascension_stat, ", ") AS ascension_stats,
  COUNT(DISTINCT character_name) AS character_count
FROM {{ ref('stg_special_stats') }}
GROUP BY is_special_stat_percent
ORDER BY is_special_stat_percent