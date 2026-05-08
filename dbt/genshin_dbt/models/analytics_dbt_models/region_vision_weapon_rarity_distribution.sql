SELECT
  region,
  vision,
  weapon_type,
  rarity,
  COUNT(*) AS character_count,
  STRING_AGG(character_name, ", ") AS characters
FROM {{ ref('characters') }}
GROUP BY weapon_type, region, vision, rarity
ORDER BY region, vision, rarity DESC