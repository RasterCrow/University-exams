
<?php
//Codice invocato quando viene inviata una recensione. I controlli vengono gia effettuati su js, qui controllo solo se gia presnete nel db
session_start();

include("db.php");

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
if (checkReview($_SESSION["cartItemCategory"], $_SESSION["cartItemId"], $_SESSION["userID"])->rowCount() === 0){
    addReview($_POST["desc"], $_POST["titolo"], $_POST["rate"], $_SESSION["cartItemCategory"], $_SESSION["cartItemId"], $_SESSION["userID"]);
    echo(true);
}else{
        echo (false);
    }
?>