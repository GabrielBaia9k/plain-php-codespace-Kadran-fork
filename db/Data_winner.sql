USE mydb;

-- Bahrain GP (safe insert)
INSERT INTO f1_winner_2025 (
  f1_weekend_id, winner_name, winner_team_name, winner_team_icon_url,
  winner_nationality, winner_points_total, winner_photo_url, podium_photo_url
)
SELECT
  id, 'Oscar_Piastri', 'McLaren', '/Images/teams/McLaren.png', 'Australia', 25,
  '/Images/winners/oscar_piastri.jpg', '/Images/podiums/Bahrain_podium.jpg'
FROM f1_weekends_2025
WHERE place='Sakhir' AND race_at='2025-03-09 18:00:00'
ON DUPLICATE KEY UPDATE
  winner_name=VALUES(winner_name),
  winner_team_name=VALUES(winner_team_name),
  winner_team_icon_url=VALUES(winner_team_icon_url),
  winner_nationality=VALUES(winner_nationality),
  winner_points_total=VALUES(winner_points_total),
  winner_photo_url=VALUES(winner_photo_url),
  podium_photo_url=VALUES(podium_photo_url);

-- Australian GP (safe insert)
INSERT INTO f1_winner_2025 (
  f1_weekend_id, winner_name, winner_team_name, winner_team_icon_url,
  winner_nationality, winner_points_total, winner_photo_url, podium_photo_url
)
SELECT
  id, 'TBD', 'TBD', '/Images/teams/TBD.jpg', 'TBD', NULL,
  '/Images/winners/TBD.jpg', '/Images/podiums/TBD.jpg'
FROM f1_weekends_2025
WHERE place='Melbourne' AND race_at='2025-03-16 15:00:00'
ON DUPLICATE KEY UPDATE
  winner_name=VALUES(winner_name),
  winner_team_name=VALUES(winner_team_name),
  winner_team_icon_url=VALUES(winner_team_icon_url),
  winner_nationality=VALUES(winner_nationality),
  winner_points_total=VALUES(winner_points_total),
  winner_photo_url=VALUES(winner_photo_url),
  podium_photo_url=VALUES(podium_photo_url);