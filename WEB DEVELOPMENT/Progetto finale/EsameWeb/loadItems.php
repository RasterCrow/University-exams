<?php

session_start();
include("db.php");

if ($_POST["input"] == '') {
    //Se non ho valori in input recupero i dati in base all'ordine scelto
    if ($_POST["order"] == "latestArrivals")
        $rows = getAllItems($_POST["categoria"]);
    else if ($_POST["order"] == "priceHigher")
        $rows = getAllItemsByPrice($_POST["categoria"], "desc");
    else if ($_POST["order"] == "priceLower")
        $rows = getAllItemsByPrice($_POST["categoria"], "asc");
} else {
    //Se ho valori di ricerca in input recupero i dati tramite quei valori e ordino in base alla scelta
    if (strcmp($_POST["categoria"], "dvd") == 0) {
        if ($_POST["order"] == "latestArrivals")
            $rows = getDvdByValue($_POST["input"]);
        else if ($_POST["order"] == "priceHigher")
            $rows = getDvdByValueAndPrice($_POST["input"], "desc");
        else if ($_POST["order"] == "priceLower")
            $rows = getDvdByValueAndPrice($_POST["input"], "asc");
    } else if (strcmp($_POST["categoria"], "musica") == 0) {
        if ($_POST["order"] == "latestArrivals")
            $rows = getMusicByValue($_POST["input"]);
        else if ($_POST["order"] == "priceHigher")
            $rows = getMusicByValueAndPrice($_POST["input"], "desc");
        else if ($_POST["order"] == "priceLower")
            $rows = getMusicByValueAndPrice($_POST["input"], "asc");
    } else if (strcmp($_POST["categoria"], "libro") == 0) {
        if ($_POST["order"] == "latestArrivals")
            $rows = getBooksByValue($_POST["input"]);
        else if ($_POST["order"] == "priceHigher")
            $rows = getBooksByValueAndPrice($_POST["input"], "desc");
        else if ($_POST["order"] == "priceLower")
            $rows = getBooksByValueAndPrice($_POST["input"], "asc");
    }
}

//sistema strano, per passare i dati ad ajax, mando con echo.
if ($rows->rowCount() > 0) {
    // inizio a creare la lista di oggetti 
    echo '<ul id="listaSearched" style="list-style-type:none">';

    foreach ($rows as $row) {
        echo ' <li>
         
        <div class="itemSearched" onclick ="location.href=\'item.php?id=' . $row["id"] . '&categoria=' . $_POST["categoria"] . '\'">
        <img src=' . $row["foto"] . '>      
                <div class="titoloSearched">' . $row["titolo"] . '</div>
                <div class="autoreSearched"> ';
        if ($_POST["categoria"] == "dvd")
            echo $row["regista"];
        else
            echo $row["autore"];
        echo ' </div>
                <div class="prezzoSearched">' . $row["prezzo"] . "€" . '</div>
            </div>

            </li>';
    }
    echo '</ul>';
} else {
    //Se non trovo risultati non creo la lista ma mando un messaggio.
    echo '<p class="dataNotFound">Non ho trovato risultati!</p>';
}
