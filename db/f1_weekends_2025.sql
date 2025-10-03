--service mariadb start
--mariadb -u root -e "CREATE DATABASE IF NOT EXISTS mydb;"
--mariadb -u root < /workspaces/plain-php-codespace-Kadran-fork/src/Inserts.sql

USE mydb;

-- Melbourne
DELETE FROM f1_weekends_2025 WHERE place='Melbourne';
INSERT INTO f1_weekends_2025 (place, timezone, fp1_at, fp2_at, fp3_at, quali_at, race_at) VALUES
('Melbourne','Australia/Melbourne',
 '2025-03-14 12:30:00','2025-03-14 16:00:00',
 '2025-03-15 12:30:00','2025-03-15 16:00:00',
 '2025-03-16 15:00:00');

-- Suzuka
DELETE FROM f1_weekends_2025 WHERE place='Suzuka';
INSERT INTO f1_weekends_2025 VALUES
(NULL,'Suzuka','Asia/Tokyo',
 '2025-04-04 12:30:00','2025-04-04 16:00:00',
 '2025-04-05 12:30:00','2025-04-05 16:00:00',
 '2025-04-06 15:00:00', DEFAULT);

-- Shanghai
DELETE FROM f1_weekends_2025 WHERE place='Shanghai';
INSERT INTO f1_weekends_2025 (place, timezone, fp1_at, fp2_at, fp3_at, quali_at, race_at) VALUES
('Shanghai','Asia/Shanghai',
 '2025-04-18 12:30:00','2025-04-18 16:00:00',
 '2025-04-19 12:30:00','2025-04-19 16:00:00',
 '2025-04-20 15:00:00');

-- Sakhir
DELETE FROM f1_weekends_2025 WHERE place='Sakhir';
INSERT INTO f1_weekends_2025 (place, timezone, fp1_at, fp2_at, fp3_at, quali_at, race_at) VALUES
('Sakhir','Asia/Bahrain',
 '2025-03-07 12:30:00','2025-03-07 16:00:00',
 '2025-03-08 12:30:00','2025-03-08 16:00:00',
 '2025-03-09 18:00:00');

-- Verify
SELECT place, timezone, fp1_at, fp2_at, fp3_at, quali_at, race_at
FROM f1_weekends_2025
ORDER BY race_at;