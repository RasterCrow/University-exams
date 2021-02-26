<!-- In questa pagina carico gli item in base alla ricerca. Gli item vengono caricati dalla pagina loadItems con una chiamata ajax, in questo modo
posso riordinarli senza dover ricaricare la pagina-->
<!DOCTYPE html>
<html>

<head>
    <title>UnIBS</title>
    <meta charset="utf-8">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
    </script>
    <script src="unibs.js" ></script>
    <link href="unibs.css" type="text/css" rel="stylesheet">
</head>

<!-- your HTML output follows -->
<?php
session_start();

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

include("db.php");

//$itemsPerPage = 5; Inutilizzato, si poteva implementare un sistema dinamico di caricamento pagina

$_SESSION['choice'] = $_GET["categoria"];
?>

<body>
    <?php include("top.php"); ?>
    <div id="frame">
        <div id="topFrame">
            <div>
                <h2>Risultati nella categoria <b><?= $_GET["categoria"] ?></b> per la tua ricerca : </h2>
            </div>
            <div>
                <select id="itemOrder">
                    <option value="latestArrivals" selected>Ultimi arrivi</option>
                    <option value="priceLower">Prezzo crescente </option>
                    <option value="priceHigher">Prezzo descrescente </option>
                </select>
            </div>
        </div>
        <div id="main" data-type=<?=$_GET["categoria"]?> data-input=<?=$_GET["input"]?>>

            
        </div> <!-- end of #main div -->
    </div> <!-- end of #frame div -->

</body>

</html>