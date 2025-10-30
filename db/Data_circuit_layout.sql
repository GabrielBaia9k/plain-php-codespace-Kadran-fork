USE mydb;

-- Bahrain GP (Sakhir) — circuit layout data
-- Requires the weekend row to exist in f1_weekends_2025 (see Data_f1_weekends_2025.sql)

INSERT INTO f1_circuit_layout_2025 (
  f1_weekend_id,
  circuit_layout_url,
  race_distance_km,
  laps,
  tyre_soft,
  tyre_medium,
  tyre_hard,
  lap_record,
  race_lap_record
)
SELECT
  w.id,
  '/Images/circuits/Bahrain_circuit.png',   -- ensure this file is web-accessible under src/Images/circuits/
  308.238,                         -- 57 laps × 5.412 km
  57,
  'C3 (Soft)',
  'C2 (Medium)',
  'C1 (Hard)',
  '1:27.264 — Lewis Hamilton (2020)',       -- overall/qualifying lap record
  '1:31.447 — Pedro de la Rosa (2005)'      -- race lap record
FROM f1_weekends_2025 AS w
WHERE w.place = 'Sakhir'
  AND w.race_at = '2025-03-09 18:00:00'
ON DUPLICATE KEY UPDATE
  circuit_layout_url = VALUES(circuit_layout_url),
  race_distance_km   = VALUES(race_distance_km),
  laps               = VALUES(laps),
  tyre_soft          = VALUES(tyre_soft),
  tyre_medium        = VALUES(tyre_medium),
  tyre_hard          = VALUES(tyre_hard),
  lap_record         = VALUES(lap_record),
  race_lap_record    = VALUES(race_lap_record);