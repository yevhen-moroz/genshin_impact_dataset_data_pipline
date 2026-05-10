SELECT stat_type, character_name, value AS max_value
FROM {{ ref('stg_character_stats') }}
WHERE level_range = '90_90'
  AND stat_type IN ('hp', 'atk', 'def')
QUALIFY ROW_NUMBER() OVER (
  PARTITION BY stat_type
  ORDER BY value DESC
) = 1