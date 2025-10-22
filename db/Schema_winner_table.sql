USE mydb;

DROP TABLE IF EXISTS f1_winner_2025;
CREATE TABLE IF NOT EXISTS f1_winner_2025 (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  /* must match f1_weekends_2025.id (SMALLINT UNSIGNED) */
  f1_weekend_id SMALLINT UNSIGNED NOT NULL,
  winner_name VARCHAR(100) NOT NULL,
  winner_team_name VARCHAR(100) NOT NULL,
  winner_team_icon_url VARCHAR(255) NULL,
  winner_nationality VARCHAR(80) NULL,
  winner_points_total SMALLINT UNSIGNED NULL,
  winner_photo_url VARCHAR(255) NULL,
  podium_photo_url VARCHAR(255) NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_winner_weekend (f1_weekend_id),
  KEY idx_winner_weekend (f1_weekend_id),
  CONSTRAINT fk_winner_weekend
    FOREIGN KEY (f1_weekend_id) REFERENCES f1_weekends_2025(id)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;