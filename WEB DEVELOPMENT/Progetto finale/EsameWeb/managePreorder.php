<!-- in questo file gestisco le email da inviare a chi ha prenotato il prodotto-->

<?php

session_start();
include("db.php");


//Recupero utenti con preorder su questo item
$rows = retrievePreorders($_GET["categoria"], $_GET["id"]);
if ($rows->rowCount() > 0) {
    foreach ($rows as $row) {
        //Invio mail a ciascun utente
        $to = $row["email"];
        $subject = $row["titolo"] . " è ora disponibile!";
        $txt = 'L\'articolo che avevi prenotato su Unibs è ora tornato disponibile. Sbrigati a comprarlo!';
        $headers = "From: unibsalert@mailinator.com";
        $value = mail($to, $subject, $txt, $headers);
        if($value){
            echo ' email inviata a ' . $row["email"]; 
        }else{
            echo ' Errore nell\'invio della mail a ' . $row["email"]; 
        }
        ?> <br>
<?php

        //Rimuovo il preorder dal sito
        removePreorder($row["preorderID"]);
    }
} else {
    echo 'Non ho trovato preordini';
}
?>
<br>
<input type="button" value="Torna su unIBS" onClick="document.location.href='account.php'">