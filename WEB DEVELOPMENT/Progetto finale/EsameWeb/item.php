<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>UnIBS</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="unibs.js"></script>
    <link href="unibs.css" type="text/css" rel="stylesheet">
</head>

<?php
session_start();

include("db.php");


//Valore per il quale mostrare avviso di scarsa giacenza
$lastItemsNum = 3;
$_SESSION["cartItemCategory"] = $_GET["categoria"];
$_SESSION["cartItemId"] = $_GET["id"];

?>

<body>
    <?php include("top.php"); ?>
    <div id="frame">

        <?php
        $item = getItemById($_GET["categoria"], $_GET["id"])->fetch();
        ?>

        <!-- Se l'item ha meno di X unità o è sold-out lo mostro un avviso sullo schermo -->
        <?php if ($item["num_prod"] < $lastItemsNum && $item["num_prod"] > 0) { ?>
            <div class="AlertMessageGood">
                <p> Rimangono solo <?= $item["num_prod"] ?> copie di questo prodotto, affrettati a comprarlo! </p>
            </div>
        <?php } else if ($item["num_prod"] == 0) { ?>
            <div class="AlertMessageBad">
                <p> Questo prodotto è attualmente sold-out </p>
            </div>
        <?php } ?>
        <?php if (!isset($_SESSION['userID'])) { ?>
            <div class="AlertMessageBad">
                <p> Devi loggare per poter comprare o aggiungere recensioni. </p>
            </div>
        <?php } ?>

        <div id="viewItemData">
            <!-- mostro i dati dell'item -->
            <div id="viewItemImageWrapper">
                <img id="viewItemImg" src=<?= $item["foto"] ?>>
            </div>
            <div id="viewItemBuyInfo">
                <?php
                //Controllo, se userid settato, allora permette o prenotazione o aggiunta al carello
                if (isset($_SESSION['userID'])) {
                    if ($item["num_prod"] == 0) { ?>
                        <button id="preorderButton"> Prenota </button>
                    <?php } else { ?>
                        <button onclick="location.href = 'addToCart.php'"> Aggiungi al carrello</button>
                    <?php }
                    } else {
                        //Altrimenti non glielo lascio fare
                        if ($item["num_prod"] == 0) { ?>
                        <button class='fakeButton'> Prenota </button>
                    <?php  } else { ?>
                        <button class='fakeButton'> Aggiungi al carrello</button>
                <?php }
                } ?>
            </div>
            <div id="viewItemText">
                <div id="viewItemTitolo">
                    <?= $item["titolo"] ?>
                </div>
                <!-- in base al tipo di oggetto mostro regista/autore -->
                <?php if ($_GET["categoria"] == "dvd") {
                    $autore = $item["regista"];
                } else {
                    $autore = $item["autore"];
                } ?>

                <div id="viewItemAutore">
                    <a class="attrLink" href="search.php?categoria=<?= $_GET['categoria'] ?>&input=<?= $autore ?>"><?= $autore ?></a>

                </div>

                <div id="viewItemPrezzo">

                    <?= $item["prezzo"] ?>€
                </div>

                <div id="viewItemDescrizione">

                    <?= $item["descrizione"] ?>
                </div>
            </div>
        </div>
        <div id="viewItemDataExtra">
            <h2> Informazioni Extra </h2>
            <div id="viewItemSpedizioneTipo">
                Spedizione : <?= $item["tipo_sped"] ?>
            </div>

            <div id="viewItemSpedizionePrezzo">
                Prezzo spedizione : <?= $item["prezzo_sped"] ?>€<br>
            </div>

            <div id="viewItemSpedizioneTempo">
                Tempo consegna : <?= $item["tempo_consegna"] ?> giorni
            </div>

            <div id="viewItemDataUscita">

                Anno uscita : <?= $item["anno_uscita"] ?>
            </div>

            <!-- qui arrivano informazioni che sono diverse in base al tipo di oggetto -->
            <!-- if dvd -->
            <?php if ($_GET["categoria"] == "dvd") { ?>

                <div id="viewItemGenere">
                    Genere :<a class="attrLink" href="search.php?categoria=<?= $_GET['categoria'] ?>&input=<?= $item['tipo_genere'] ?>"><?= $item["tipo_genere"] ?></a>
                </div>
                <!-- mostro lista di attori presenti nel film -->
                <div id="viewItemAttori">
                    <h3> Attori nel film </h3>
                    <ul id="listaAttori" style="list-style-type:circle">
                        <?php $attori = getActorsByMoviesId($_GET["id"]);
                            foreach ($attori as $attore) {
                                ?>
                            <li>
                                <div id="actorInSelectedItem">
                                    <a class="attrLink" href="search.php?categoria=<?= $_GET['categoria'] ?>&input=<?= $attore["nome"] ?>"><?= $attore["nome"] ?></a>
                                </div>
                            </li>
                        <?php } ?>
                    </ul>
                </div>
            <?php } ?>
            <!-- if musica -->
            <?php if ($_GET["categoria"] == "musica") { ?>
                <div id="viewItemTipoDisco">
                    <?php if ($item["cd"] == "1") {
                            print("Tipo di disco : cd");
                        } else {
                            print("Tipo di disco : vinile");
                        } ?>
                </div>
                <!-- per un cd devo fare anche una lista con tutte le canzioni presenti e durata di ciascuna -->
                <div id="viewItemCanzoni">
                    <h3> Canzoni nell'album </h3>
                    <ul id="listaCanzoni" style="list-style-type:circle">
                        <?php $canzoni = getSongsByAlbumId($_GET["id"]);
                            foreach ($canzoni as $canzone) {
                                ?>
                            <li>
                                <div id="titoloCanzone">
                                    Titolo : <?= $canzone["titolo"] ?> &nbsp;
                                </div>
                                <div id="durataCanzone">
                                    <?= $canzone["durata"] ?>
                                </div>

                            </li>
                        <?php } ?>
                    </ul>
                </div>
            <?php } ?>

            <!-- if libro -->
            <?php if ($_GET["categoria"] == "libro") { ?>
                <div id="viewItemGenere">
                    Genere : <a class="attrLink" href="search.php?categoria=<?= $_GET['categoria'] ?>&input=<?= $item['tipo_genere'] ?>"> <?= $item["tipo_genere"] ?></a>
                </div>
                <div id="viewItemEditore">
                    Editore : <a class="attrLink" href="search.php?categoria=<?= $_GET['categoria'] ?>&input=<?= $item['tipo_genere'] ?>"> <?= $item["editore"] ?></a>
                </div>
                <div id="viewItemIsbn">
                    ISBN : <?= $item["isbn"] ?>
                </div>
                <div id="viewItemPagine">
                    Num. Pagine : <?= $item["pagine"] ?>
                </div>
             <?php } ?>
        </div>
        <!-- qui mostro la lista con le recensioni 
                se utente loggato puo anche lasciarle.
                anche qui sono ordinabili per migliori o peggiori prima
            -->

        <div id="viewItemReviews">
            <h2> Recensioni </h2>
            <select id="reviewOrder">
                <option value="bestFirst" selected>Migliori</option>
                <option value="worstFirst">Peggiori</option>
            </select>
            <div id="orderedReviews">
            </div>
            <div id="writeReview">
                <h3> Scrivi una recensione </h3>
                <input id="titoloRecWrite" type="text" maxlength=30 minlength=10 placeholder="Titolo recensione (Obbligatorio)" required><br>
                <!-- uso maxLength maggiore di 512 solo per far uscire la scritta in rosso -->
                <input id="descRecWrite" type="text" maxlength=515 minlength=80 onkeyup="countChars(this);" placeholder="Scrivi il testo della tua recensione! (Obbligatorio)" required>
                <p id="charNum">0 caratteri usati</p>
                <select id="votoRecWrite">
                    <option value="1">1 stella</option>
                    <option value="2">2 stella</option>
                    <option value="3">3 stelle</option>
                    <option value="4">4 stelle</option>
                </select><?php
                            if (isset($_SESSION['userID'])) {
                                ?>
                    <button id="sendReview">Invia Recensione </button>
                <?php } else { ?>
                    <button class="fakeButton">Invia Recensione </button>
                <?php } ?>
            </div>
        </div>



        <?php
        ?>
    </div> <!-- end of #frame div -->
 </body>

</html>