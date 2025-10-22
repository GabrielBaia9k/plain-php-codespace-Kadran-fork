USE mydb;

DROP TABLE IF EXISTS f1_full_classification_2025;
CREATE TABLE IF NOT EXISTS f1_full_classification_2025 (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  /* must match f1_weekends_2025.id (SMALLINT UNSIGNED) */
  f1_weekend_id SMALLINT UNSIGNED NOT NULL,
  position TINYINT UNSIGNED NOT NULL,
  driver_name VARCHAR(100) NOT NULL,
  driver_code CHAR(3) NULL,
  car_number SMALLINT UNSIGNED NULL,
  team_name VARCHAR(100) NOT NULL,
  status VARCHAR(100) NULL,         -- e.g., Finished, +12.345s, DNF
  time_text VARCHAR(64) NULL,       -- optional human-readable time gap
  points TINYINT UNSIGNED NOT NULL DEFAULT 0,
  grid_position TINYINT UNSIGNED NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_class_pos (f1_weekend_id, position),
  KEY idx_class_weekend (f1_weekend_id),
  CONSTRAINT fk_class_weekend
    FOREIGN KEY (f1_weekend_id) REFERENCES f1_weekends_2025(id)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;