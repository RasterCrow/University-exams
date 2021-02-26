<!DOCTYPE html>
<html>

<head>
    <title>UnIBS</title>
    <meta charset="utf-8">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.1/jquery.validate.min.js"></script>
    <script src="js/form-validator.js"></script>
    <link href="unibs.css" type="text/css" rel="stylesheet">
</head>

<?php
session_start();
include("db.php");

?>

<body>
    <?php include("top.php");
    if (isset($_SESSION["badSignup"])) {
        ?>
        <div class="AlertMessageBad">
            <p> Inserisci correttamente le informazioni della creazione account </p>
        </div>
    <?php
        unset($_SESSION["badSignup"]);
    } ?>
    <div>
        <form id="signupFrame" name="signup" action="verifyAccountCreation.php" method="post">
            <div id="userData">
                <h2>Crea un account </h2>
                <ul>
                    <li>
                        <label for="userEmail">E-mail</label>
                        <input type="email" name="userEmail" maxlength="30">
                    </li>
                    <li>
                        <label for="userPassword">Password</label>
                        <input type="password" name="userPassword">
                    </li>
                    <li>
                        <label for="userName">Nome</label>
                        <input type="text" name="userName" maxlength="20">
                    </li>
                    <li>
                        <label for="userSurname">Cognome</label>
                        <input type="text" name="userSurname" maxlength="20">

                    </li>
                    <li>
                        <label for="userDate">Data di nascita</label>
                        <input type="date" name="userDate" min="1950-01-01" max="2001-01-01">
                    </li>
                    <li>
                        <label for="userCity">Città di residenza</label>
                        <input type="text" name="userCity" maxlength="50">
                    </li>
                    <li>
                        <label for="userStreet">Via di residenza</label>
                        <input type="text" name="userStreet" maxlength="50">
                    </li>
                </ul>
            </div>
            <div id="shippingInfo">
                <ul>
                    <li>
                        <label for="userCityShipping">Città di spedizione ( opzionale )</label>
                        <input type="text" name="userCityShipping" maxlength="50" placeholder="Lasciare vuoto per usare la stessa della residenza">
                    </li>
                    <li>
                        <label for="userStreetShipping">Via di spedizione ( opzionale )</label>
                        <input type="text" name="userStreetShipping" maxlength="50" placeholder="Lasciare vuoto per usare la stessa della residenza">
                    </li>
                </ul>
            </div>
            <div id="cardInfo">
                <ul>
                    <li>
                        <label for="userCardNum">Numero carta</label>
                        <input type="text" maxlength="16" name="userCardNum">
                    </li>
                    <li>
                        <label for="userCardCcv">CCV carta</label>
                        <input type="text" maxlength="3" name="userCardCcv">
                    </li>
                    <li>
                        <label for="userCardExp">Data di scadenza</label>
                        <input type="date" name="userCardExp" min="<?php
                                                                    echo date('Y-m-d');
                                                                    ?>" max="2025-01-01">
                    </li>
                </ul>
            </div>
            <input id="signupButton" type="submit" value="Signup">
        </form>
    </div>
</body>

</html>