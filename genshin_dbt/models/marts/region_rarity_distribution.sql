SELECT
  region,
  rarity,
  COUNT(*) AS character_count,
  STRING_AGG(character_name, ", ") AS characters
FROM {{ ref('stg_characters') }}
WHERE rarity IN (4, 5)
GROUP BY region, rarity
ORDER BY region, rarity DESC