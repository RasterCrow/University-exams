<?php
session_start();

include("db.php");

$newCart = array();
//Creo un nuovo array con tutti gli item tranne quello da rimuovere
$itemsInCart = unserialize($_COOKIE[$_SESSION["userID"]]);
foreach ($itemsInCart as $cartItem) {
    if ($cartItem[1] == $_POST["type"] && $cartItem[0] == $_POST["id"]) { } else {

        $newCart[] = array($cartItem[0], $cartItem[1]);
    }
}
//Aggiorno cookie con nuova data di scandeza
setcookie($_SESSION["userID"], serialize($newCart), time() + (86400 * 30), '/');
