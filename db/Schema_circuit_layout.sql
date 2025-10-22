USE mydb;

CREATE TABLE IF NOT EXISTS f1_circuit_layout_2025 (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  f1_weekend_id SMALLINT UNSIGNED NOT NULL,
  circuit_layout_url VARCHAR(255) NULL,
  race_distance_km DECIMAL(7,2) NULL,
  laps SMALLINT UNSIGNED NULL,
  tyre_soft VARCHAR(32) NULL,
  tyre_medium VARCHAR(32) NULL,
  tyre_hard VARCHAR(32) NULL,
  lap_record VARCHAR(120) NULL,
  race_lap_record VARCHAR(120) NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_layout_weekend (f1_weekend_id),
  KEY idx_layout_weekend (f1_weekend_id),
  CONSTRAINT fk_layout_weekend
    FOREIGN KEY (f1_weekend_id) REFERENCES f1_weekends_2025(id)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;