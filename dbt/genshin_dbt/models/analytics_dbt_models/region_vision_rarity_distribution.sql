SELECT
  region,
  vision,
  rarity,
  COUNT(*) AS character_count,
  STRING_AGG(character_name, ", ") AS characters
FROM {{ ref('characters') }}
GROUP BY region, vision, rarity
ORDER BY region, vision, rarity DESC