<?php include_once("top.html"); ?>

<?php
//Aggiungo l'utente al file
$user = implode(",", $_POST) . "\n";
file_put_contents("singles.txt", $user, FILE_APPEND);

?>
<div>
Welcome to NerdLuv, <?= $_POST["name"]?>!<br>
Now <a href="/esercizio2/matches.php">log in to see your matches!</a><br>

</div>
<?php include_once("bottom.html"); ?>
