USE mydb;

-- 2025 Bahrain GP (Sakhir) — Full classification
-- Requires the weekend row to exist in f1_weekends_2025

INSERT INTO f1_full_classification_2025 (
  f1_weekend_id,
  position,
  driver_name,
  driver_code,
  car_number,
  team_name,
  status,
  time_text,
  points,
  grid_position
)
SELECT
  w.id AS f1_weekend_id,
  r.pos AS position,
  r.driver_name,
  r.driver_code,
  r.car_number,
  r.team_name,
  r.status,
  r.time_text,
  CASE r.pos
    WHEN 1 THEN 25 WHEN 2 THEN 18 WHEN 3 THEN 15 WHEN 4 THEN 12 WHEN 5 THEN 10
    WHEN 6 THEN 8 WHEN 7 THEN 6 WHEN 8 THEN 4 WHEN 9 THEN 2 WHEN 10 THEN 1
    ELSE 0
  END AS points,
  r.grid_position
FROM f1_weekends_2025 AS w
JOIN (
  SELECT 1  AS pos, 'Oscar Piastri'         AS driver_name, 'PIA' AS driver_code, 81 AS car_number, 'McLaren'        AS team_name, 'Finished' AS status, '1:35:39.435' AS time_text, 1  AS grid_position
  UNION ALL SELECT 2 ,'George Russell'                         ,'RUS', 63, 'Mercedes'       , 'Finished', '+15.499s'     , 3
  UNION ALL SELECT 3 ,'Lando Norris'                           ,'NOR', 4 , 'McLaren'        , 'Finished', '+16.273s'     , 6
  UNION ALL SELECT 4 ,'Charles Leclerc'                        ,'LEC', 16, 'Ferrari'        , 'Finished', '+19.679s'     , 2
  UNION ALL SELECT 5 ,'Lewis Hamilton'                         ,'HAM', 44, 'Ferrari'        , 'Finished', '+27.993s'     , 9
  UNION ALL SELECT 6 ,'Max Verstappen'                         ,'VER', 1 , 'Red Bull Racing', 'Finished', '+34.395s'     , 7
  UNION ALL SELECT 7 ,'Pierre Gasly'                           ,'GAS', 10, 'Alpine'         , 'Finished', '+36.002s'     , NULL
  UNION ALL SELECT 8 ,'Esteban Ocon'                           ,'OCO', 31, 'Haas'           , 'Finished', '+44.244s'     , NULL
  UNION ALL SELECT 9 ,'Yuki Tsunoda'                           ,'TSU', 22, 'Red Bull Racing', 'Finished', '+45.061s'     , 10
  UNION ALL SELECT 10,'Oliver Bearman'                         ,'BEA', 23, 'Haas'           , 'Finished', '+47.594s'     , NULL
  UNION ALL SELECT 11,'Andrea Kimi Antonelli'                  ,'AKA', 4 , 'Mercedes'       , 'Finished', '+48.016s'     , NULL
  UNION ALL SELECT 12,'Alexander Albon'                        ,'ALB', 14, 'Williams'       , 'Finished', '+48.839s'     , NULL
  UNION ALL SELECT 13,'Nico Hülkenberg'                        ,'HUL', 5 , 'Sauber'         , 'Finished', '+53.472s'     , NULL
  UNION ALL SELECT 14,'Isack Hadjar'                           ,'HAD', 20, 'Racing Bulls'   , 'Finished', '+56.314s'     , NULL
  UNION ALL SELECT 15,'Jack Doohan'                            ,'DOO', 3 , 'Alpine'         , 'Finished', '+57.806s'     , NULL
  UNION ALL SELECT 16,'Fernando Alonso'                        ,'ALO', 28, 'Aston Martin'   , 'Finished', '+60.340s'     , NULL
  UNION ALL SELECT 17,'Liam Lawson'                            ,'LAW', 24, 'Racing Bulls'   , 'Finished', '+64.435s'     , NULL
  UNION ALL SELECT 18,'Lance Stroll'                           ,'STR', 18, 'Aston Martin'   , 'Finished', '+65.489s'     , NULL
  UNION ALL SELECT 19,'Gabriel Bortoleto'                      ,'BOR', 27, 'Sauber'         , 'Finished', '+66.872s'     , NULL
  UNION ALL SELECT 20,'Carlos Sainz'                           ,'SAI', 11, 'Williams'       , 'DNF'     , NULL           , NULL
) AS r
  ON w.place = 'Sakhir' AND w.race_at = '2025-03-09 18:00:00'
ON DUPLICATE KEY UPDATE
  driver_name   = VALUES(driver_name),
  driver_code   = VALUES(driver_code),
  car_number    = VALUES(car_number),
  team_name     = VALUES(team_name),
  status        = VALUES(status),
  time_text     = VALUES(time_text),
  points        = VALUES(points),
  grid_position = VALUES(grid_position);