<?php
// $sql = "SELECT
// note.id,
// note.title AS 'Note',
// GROUP_CONCAT(tag.name) AS 'Tags'
// FROM note
// LEFT JOIN tag_by_note ON id_note = note.id
// LEFT JOIN tag on id_tag = tag.id
// GROUP BY note.id
// ";

$sql = "SELECT * FROM note";
$stmt = $conn->query($sql);
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
die;

?>