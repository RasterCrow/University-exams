
<?php
//Questo file posso probabilmente rimuoverlo e inserire la funzion onclick nel bottone
session_start();
session_destroy();
session_start();
$_SESSION["logoutSuccess"] = true;
header('Location: account.php')
?>