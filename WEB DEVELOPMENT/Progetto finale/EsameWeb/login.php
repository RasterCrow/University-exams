<!DOCTYPE html>
<html>

<head>
    <title>UnIBS</title>
    <meta charset="utf-8">
    <link href="unibs.css" type="text/css" rel="stylesheet">
</head>

<?php
session_start();
include("db.php");

?>

<body>
    <?php include("top.php");
    if (isset($_SESSION["badLogin"])) {
        ?>
        <div class="AlertMessageBad">
            <p> Le informazioni del login sono sbagliate! </p>
        </div>
    <?php
        unset($_SESSION["badLogin"]);
    } ?>
    <?php
    if (isset($_SESSION["logoutSuccess"])) {
        ?>
        <div class="AlertMessageGood">
            <p> Logout effettuato corretamente! </p>
        </div>
    <?php
        unset($_SESSION["logoutSuccess"]);
    } ?>
    <?php
    if (isset($_SESSION["goodSignup"])) {
        ?>
        <div class="AlertMessageGood">
            <p> Registrazione effettuata con successo! </p>
        </div>
    <?php
        unset($_SESSION["goodSignup"]);
    } ?>
    <?php
    if (isset($_SESSION["noLoginFound"])) {
        ?>
        <div class="AlertMessageBad">
            <p> Devi loggare per questa funzione! </p>
        </div>
    <?php
        unset($_SESSION["noLoginFound"]);
    } ?>
    <div id="containerLogin">
    <h2>Login </h2>
        <form id="loginFrame" action="authenticate.php" method="post">
           
            <label class="left" for="userEmail">E-mail</label>
            <input type="text" name="userEmail">
            <label class="left" for="userPassword">Password</label>
            <input type="password" name="userPassword">
            <input id="loginButton" type="submit" value="Login">
        </form>
        <button onclick="location.href = 'signup.php'" id = "signupButtonLogin">Create account </button>
    </div>
   
</body>

</html>