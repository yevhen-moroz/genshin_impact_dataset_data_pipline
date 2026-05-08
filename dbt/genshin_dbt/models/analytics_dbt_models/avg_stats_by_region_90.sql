SELECT
  c.region,

  AVG(CASE WHEN stat_type = 'atk' THEN value END) AS average_atk_90_90,
  AVG(CASE WHEN stat_type = 'hp' THEN value END) AS average_hp_90_90,
  AVG(CASE WHEN stat_type = 'def' THEN value END) AS average_def_90_90

FROM {{ ref('character_stats') }} s
JOIN {{ ref('characters') }} c
  ON s.character_name = c.character_name
WHERE level_range = '90_90'
GROUP BY c.region
ORDER BY c.region