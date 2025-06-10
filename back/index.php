<?php
header("Content-Type: application/json");

include '../config/constantes.php';
include './config.php';
include './database.php';
include "./entities/note.php";
include "./entities/tag.php";

$loc = filter_input(INPUT_GET, "loc");

switch($loc){
    case "notes":
        include "controller/note.php";
    break;
    case "tags":
        include "controller/tag.php";
    break;
    default:
      http_response_code(404);
      $data = ["error" => "Cette route n'existe pas"];
      echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
      die;
}

?>