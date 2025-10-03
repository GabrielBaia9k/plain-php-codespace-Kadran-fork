<?php
// This is an excersise for learning how to connect a database with php, and using css for styling the data into a good looking website.

// RUNNING PHP in port 8080 (in codespaces)
// run php with an absolute docroot: php -S 0.0.0.0:8080 -t /workspaces/plain-php-codespace-Kadran-fork/src
// test with "$BROWSER" "http://localhost/Dynamic_page.php"
// if it is showing default apache2 page do: 
// rm /var/www/html/index.html and 
// service apache2 restart
// then rm -rf /var/www/html && ln -s /workspaces/plain-php-codespace-Kadran-fork/src /var/www/html


// RUNNING MARIADB in port 3306 (in codespaces)
// service mariadb start
// Login via Unix socket as OS root (no sudo needed):
// mariadb -u root
// mariadb was falling back to the Unix socket and not sending your password. Force TCP and ensure the user exists with a password for the right host.
// creating a TCP user and giving it permissions:
// CREATE USER IF NOT EXISTS 'Kadrandev'@'localhost' IDENTIFIED BY 'your_password';
// GRANT ALL PRIVILEGES ON mydb.* TO 'Kadrandev'@'127.0.0.1';
// GRANT ALL PRIVILEGES ON mydb.* TO 'Kadrandev'@'localhost';
// acessing mariadb and using mydb database:
// mariadb --no-defaults --protocol=TCP -h 127.0.0.1 -P 3306 -u Kadrandev -p
// USE mydb;
// If its not there Create mydb and the table f1_weekends_2025 for this excercise and insert the data unsing the .sql files in db
// CREATE DATABASE IF NOT EXISTS mydb;
// SOURCE /workspaces/plain-php-codespace-Kadran-fork/db/Schema_f1_weekends_2025.sql;

declare(strict_types=1);

// add a index to route the page
///require __DIR__ . '/Dynamic_page.php';

$title = 'F1 Weekends 2025';
$generatedAt = (new DateTimeImmutable('now', new DateTimeZone('UTC')))
    ->format('Y-m-d H:i:s \U\T\C');

//getting the database from MariaDB
$dbHost = '127.0.0.1';
$dbPort = 3306;
$dbName = 'mydb';
$dbUser = 'Kadrandev';
$dbPass = 'your_password'; 


$f1Rows = [];
$f1Error = null;

try {
    $pdo = new PDO(
        "mysql:host={$dbHost};port={$dbPort};dbname={$dbName};charset=utf8mb4",
        $dbUser,
        $dbPass,
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        ]
    );
    $stmt = $pdo->query("
        SELECT place, timezone, fp1_at, fp2_at, fp3_at, quali_at, race_at
        FROM f1_weekends_2025
        ORDER BY race_at
    ");
    $f1Rows = $stmt->fetchAll();
} catch (Throwable $e) {
    $f1Error = $e->getMessage();
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><?= htmlspecialchars($title, ENT_QUOTES, 'UTF-8') ?></title>
    <link rel="stylesheet" href="Dynamic_page.css" />
</head>
<body>
    <header><h1>This is an exercise to show a table with the F1 2025 Weekends data</h1></header>
    <main>
        <p>This page was rendered at <?= htmlspecialchars($generatedAt, ENT_QUOTES, 'UTF-8') ?>.</p>
        <!-- F1 2025 Weekends table (data from MariaDB) -->
        <section aria-labelledby="f1-2025-heading">
            <h2 id="f1-2025-heading">F1 2025 Weekends</h2>
            <table id="f1-weekends-2025" border="1" cellpadding="6" cellspacing="0">
                <thead>
                    <tr>
                        <th>Place</th>
                        <th>Timezone</th>
                        <th>FP1</th>
                        <th>FP2</th>
                        <th>FP3</th>
                        <th>Qualifying</th>
                        <th>Race</th>
                    </tr>
                </thead>
                <tbody>
                <?php if ($f1Error): ?>
                    <tr>
                        <td colspan="7">Error: <?= htmlspecialchars($f1Error, ENT_QUOTES, 'UTF-8') ?></td>
                    </tr>
                <?php elseif (!$f1Rows): ?>
                    <tr>
                        <td colspan="7">No data yet. Insert rows into f1_weekends_2025 and refresh.</td>
                    </tr>
                <?php else: ?>
                    <?php foreach ($f1Rows as $r): ?>
                        <tr>
                            <td><?= htmlspecialchars($r['place'], ENT_QUOTES, 'UTF-8') ?></td>
                            <td><?= htmlspecialchars($r['timezone'], ENT_QUOTES, 'UTF-8') ?></td>
                            <td><?= htmlspecialchars($r['fp1_at'], ENT_QUOTES, 'UTF-8') ?></td>
                            <td><?= htmlspecialchars($r['fp2_at'], ENT_QUOTES, 'UTF-8') ?></td>
                            <td><?= htmlspecialchars($r['fp3_at'], ENT_QUOTES, 'UTF-8') ?></td>
                            <td><?= htmlspecialchars($r['quali_at'], ENT_QUOTES, 'UTF-8') ?></td>
                            <td><?= htmlspecialchars($r['race_at'], ENT_QUOTES, 'UTF-8') ?></td>
                        </tr>
                    <?php endforeach; ?>
                <?php endif; ?>
                </tbody>
            </table>
        </section>
    </main>
</body>
</html>