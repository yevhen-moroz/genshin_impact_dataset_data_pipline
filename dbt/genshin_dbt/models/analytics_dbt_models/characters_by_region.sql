SELECT
  region,
  STRING_AGG(character_name, ", ") AS characters,
  COUNT(*) AS character_count
FROM {{ ref('characters') }}
GROUP BY region
ORDER BY region