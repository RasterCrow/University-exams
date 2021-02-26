<?php

session_start();

include("db.php");

if ($_POST["order"] == "bestFirst") {
    $rows = getReviews($_SESSION["cartItemCategory"], $_SESSION["cartItemId"], "desc");
} else {
    $rows = getReviews($_SESSION["cartItemCategory"], $_SESSION["cartItemId"], "asc");
}
if ($rows->rowCount() > 0) {
    // inizio a creare la lista di oggetti 
    echo '<ul id="listaReviews" style="list-style-type:none">';
        
            foreach ($rows as $row) {
           echo' <li>
                <div class="reviewLoaded">
                    <div class="titoloReviewLoad"> <b>Titolo : </b>'.$row["titolo"].'</div>
                    <div class="autoreReviewLoad"><b>Autore : </b> '.$row["nome"].'</div>
                    <div class="votoReviewLoad"><b> Voto : </b> '.$row["voto"].' stelle.</div>
                    <div class="descrizioneReviewLoad"><b>Descrizione : </b> <br>'. $row["descrizione"].'</div>
                </div>

            </li>
            <hr>
            ';
            }
    echo '</ul>';
} else {
    //Se non trovo risultati non creo la lista ma mando un messaggio.
   echo '<p class="reviewNotFound">Non ci sono recensioni!</p>';
}
?>