<?php

session_start();

include("db.php");

//Controllo se item gia prenotato dall'utente non lo aggiungo ancora
$rows = checkPreorder($_SESSION["cartItemCategory"], $_SESSION["cartItemId"], $_SESSION["userID"]);
if ($rows->rowCount() <= 0) {
    //Aggiungo al db l'utente e l'item
    addToPreorder($_SESSION["userID"], $_SESSION["cartItemCategory"], $_SESSION["cartItemId"]);
    echo 0;
}else{
    echo 1;
}
