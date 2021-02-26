<!DOCTYPE html>
<html>

<head>
    <title>UnIBS</title>
    <meta charset="utf-8">
    <link href="unibs.css" type="text/css" rel="stylesheet">
</head>

<?php

//Pagina che mostra i dati principali dell'utente, e nel caso di admin anche i pulsante per aggiunta o modifica item nel db.
//Permette anche il logout 
session_start();
include("db.php");
?>

<body>
    <?php include("top.php");

    //Se arriva con un messaggio di buon login lo mostro
    if (isset($_SESSION["goodLogin"])) {
        ?>
        <div class="AlertMessageGood">
            <p> Login effettuato correttamente! </p>
        </div>
    <?php
        unset($_SESSION["goodLogin"]);
    }
    ?>
    <div id="accountFrame">
        <?php if (isset($_SESSION['userID'])) {

            //Recupero dati utenti
            $row = getUserById($_SESSION['userID'])->fetch();
            $carta = getUserCard($row["carta"])->fetch();
            ?>
            <div id="infoPanel">
                <ul>Benvenuto <?= $row["nome"] ?>, ecco i tuoi dati :</ul>
                <li>Email : <?= $row["email"] ?> </li>
                <li>Nome : <?= $row["nome"] ?> </li>
                <li>Cognome : <?= $row["cognome"] ?> </li>
                <li>Data di nascità : <?= $row["data_di_nascita"] ?> </li>
                <li>Numero carta : <?= $carta["num"] ?> </li>
                <?php
                if (isset($_SESSION["admin"])) {
                    ?>
                    <input type="button" value="Aggiungi articolo" onclick="location.href = 'http://localhost:8080/unibs/addItem.jsp'">
                    <input type="button" value="Modifica articoli" onclick="location.href = 'http://localhost:8080/unibs/editItem.jsp'">
                <?php
            }
            ?>
                <a href="logout.php"><input type="button" value="Logout"></a>
            </div>
            
        <?php
        } else {
            header("Location: /login.php");
        }
        ?>
    </div>
</body>

</html>