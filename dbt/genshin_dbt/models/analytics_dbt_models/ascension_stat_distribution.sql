SELECT
  ascension_stat,
  COUNT(DISTINCT character_name) AS character_with_stat,
  ROUND(
    COUNT(DISTINCT character_name)
      * 100.0
      / SUM(COUNT(DISTINCT character_name)) OVER (),
    2
  ) AS percentage_of_total
FROM {{ ref('special_stats') }}
GROUP BY ascension_stat
ORDER BY percentage_of_total DESC