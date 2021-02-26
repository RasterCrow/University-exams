<?php
session_start();
include("db.php");
//Siccome i controlli sono gia fatti in js, arrivo su questa con dati corretti.Devo solo controllare se esistono gia sul sito.

//Controllo se la carta esiste gia
$row = getUserCard($_POST["userCardNum"]);
if ($row->rowCount() > 0) {
    $_SESSION["badSignup"] = true;
    header("Location: /signup.php");
    exit();
}
//Controllo se l'utente ha inserito una spedizione diversa
if ($_POST["userCityShipping"] == '') {
    $_POST["userCityShipping"] = $_POST["userCity"];
}
if ($_POST["userStreetShipping"] == '') {
    $_POST["userStreetShipping"] = $_POST["userStreet"];
}
//Controlo se l'email è gia registrata
$row = getUserByEmail($_POST["userEmail"]);
if ($row->rowCount() > 0) {
    $_SESSION["badSignup"] = true;
    header("Location: /signup.php");
    exit();
}
//Aggiungo la carta al db
$cardId = addCard($_POST["userCardNum"], $_POST["userCardCcv"], $_POST["userCardExp"]);
if (!$cardId) {
    $_SESSION["badSignup"] = true;
    header("Location: /signup.php");
    exit();
}
//Creo l'utente
$row = createUser($_POST["userEmail"], $_POST["userName"], $_POST["userSurname"], $_POST["userDate"], $_POST["userCity"], $_POST["userStreet"], $_POST["userCityShipping"], $_POST["userStreetShipping"], $cardId, sha1($_POST["userPassword"]));
if ($row) {
    //lo faccio tornare alla pagina login avvisandolo del login riuscito
    $_SESSION["goodSignup"] = true;
    header("Location: /login.php");
    exit();
} else {
    $_SESSION["badSignup"] = true;
    header("Location: /signup.php");
    exit();

}
