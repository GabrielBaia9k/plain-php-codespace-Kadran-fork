-- Create DB and table (idempotent)
CREATE DATABASE IF NOT EXISTS mydb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE mydb;

-- Recreate the table
DROP TABLE IF EXISTS f1_weekends_2025;
CREATE TABLE f1_weekends_2025 (
  id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  place VARCHAR(255) NOT NULL,
  timezone VARCHAR(64) NOT NULL,
  fp1_at DATETIME NOT NULL,
  fp2_at DATETIME NOT NULL,
  fp3_at DATETIME NOT NULL,
  quali_at DATETIME NOT NULL,
  race_at DATETIME NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_place (place),
  INDEX idx_race_at (race_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;