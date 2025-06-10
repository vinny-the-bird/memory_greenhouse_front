<?php

// $servername = getenv('SERVER_NAME');
// $username = getenv('USERNAME');
// $password = getenv('PASSWORD');
// $bdd_name = getenv('DB_DATABASE');

$servername = SERVER_NAME;
$username = USERNAME;
$password = PASSWORD;
$bdd_name = DB_DATABASE;

try {
  $conn = new PDO("mysql:host=$servername;dbname=$bdd_name", $username, $password);
  // set the PDO error mode to exception
  $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
  // echo json_encode(strlen($password));
  echo json_encode("Connection failed: " . $e->getMessage());
  die;
}
?>