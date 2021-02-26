
<?php
//in questo file aggiorno i cookie con il nuovo articolo passato da aggiungere al carrello
session_start();
//Recupero e aggiorno carrello
if (empty($_COOKIE[$_SESSION["userID"]])) {
    $itemsInCart = array();
} else {
    $itemsInCart = unserialize($_COOKIE[$_SESSION["userID"]]);
}
//controllo se è gia nel carrello
$found = false;
foreach ($itemsInCart as $item) {
    if ($item[0] == $_SESSION["cartItemId"] && $item[1] == $_SESSION["cartItemCategory"]) {
        $found = true;
    }
}
//se non lo è lo aggiungo
if (!$found) {
    $itemsInCart[] = array($_SESSION["cartItemId"], $_SESSION["cartItemCategory"]);
    setcookie($_SESSION["userID"], serialize($itemsInCart), time() + (86400 * 30), '/');

    header("Location: /carrello.php");
} else {
    //Avverto che è gia nel carrello
    $_SESSION["alreadyInCart"] = true;
    header("Location: /carrello.php");
}

?>