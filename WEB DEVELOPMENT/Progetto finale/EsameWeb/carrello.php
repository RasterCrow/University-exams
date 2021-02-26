<!-- qui visualizzo gli item nel carrello recuperati dai cookie carrello
offro anche l'opportunità di pagare-->
<?php session_start();

include("db.php");
?>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>UnIBS</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
    </script>
    <script src="unibs.js"></script>
    <link href="unibs.css" type="text/css" rel="stylesheet">
</head>


<body>
    <?php
    include("top.php");
    //valore totale del carrello
    $totale = 0;

    //Se utente non loggato lo rimando al login
    if (!isset($_SESSION['userID'])) {
        $_SESSION["noLoginFound"] = true;
        header("Location: /login.php");
    } else {
        if (isset($_SESSION["alreadyInCart"])) {
            ?>
            <div class="AlertMessageBad">
                <p> Item gia nel carrello </p>
            </div>
        <?php
                unset($_SESSION["alreadyInCart"]);
            }
            //Recupero carrello e lo mostro
            ?>
        <h2 id="titleCarrello"> Carrello </h2>
        <?php
            if (empty($_COOKIE[$_SESSION['userID']])) {
                ?> <p id="noItemInCart">Non ci sono oggetti nel tuo carrello</p><br>
            <?php
                } else {
                    $itemsInCart = unserialize($_COOKIE[$_SESSION["userID"]]);
                    if ($itemsInCart == null) {
                        ?> <p id="noItemInCart">Non ci sono oggetti nel tuo carrello</p><br>
            <?php
                    } else {
                        ?> <div id="cart"> <?php
                                                        foreach ($itemsInCart as $cartItem) {
                                                            //Per ogni item faccio una query per recuperare le sue info
                                                            //Metto anche un link alla pagina dell'articolo
                                                            $item = getItemById($cartItem[1], $cartItem[0])->fetch();
                                                            ?>
                        <div class="cartItemWrapper" data-type=<?= $cartItem[1] ?> data-id=<?= $cartItem[0] ?>>
                            <div onclick="location.href = 'item.php?id=<?= $cartItem[0] ?>&categoria=<?= $cartItem[1] ?>'">
                                <img class="cartItemImg" src=<?= $item["foto"] ?>>
                            </div>

                            <div class="cartItemTitolo">
                                Titolo : <?= $item["titolo"] ?>
                            </div>

                            <div class="cartItemPrezzo">
                                prezzo : <?= $item["prezzo"] ?>
                            </div>
                            <div class="cartItemRemove" onclick="">
                                <button id="removeItem"> Rimuovi articolo</button>
                            </div>
                            <?php $totale += $item["prezzo"]; ?>
                        </div>
                    <?php
                                }
                                //Mostro pulsante per comprare
                                ?>
                </div>
                <div id="buyCartDiv">
                    <p id="prezzoTotale"> Prezzo totale : <?= $totale ?>€ </p>
                    <button id="buyButton"> Compra</button>
                </div>
    <?php
            }
        }
    }
    ?>

</body>

</html>