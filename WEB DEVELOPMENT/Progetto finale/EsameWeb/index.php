<!-- Metodologie per il web - A.A. 2018/2019 - Esame -->

<!DOCTYPE html>
<html>

<head>
    <title>UnIBS</title>
    <meta charset="utf-8">
    <link href="mainPage.css" type="text/css" rel="stylesheet">
</head>

<?php
session_start();
if (isset($_SESSION['choice'])) {

$selected_choice = $_SESSION['choice'];
} else {

$selected_choice = "none";
}
?>
<body>
    
        <div id="top">
            <div id="titolo" onclick="location.href = 'index.php'">
                Uni IBS
            </div>
            <div id = "sottoTitolo"> Il mercato dell'Uniupo </div>

        </div>
        <div id="main">
            <div>
                <h1>Fai la tua ricerca!</h1>
            </div>
            <form action="search.php" method="get">
                <label class="left" for="categoria">Seleziona una categoria:</label>
                <select name="categoria">
                <option value="libro" <?php if ($selected_choice == "libro") {
                                            print "selected='selected'";
                                        } ?>>Libri</option>
                <option value="dvd" <?php if ($selected_choice == "dvd") {
                                        print "selected='selected'";
                                    } ?>>Dvd</option>
                <option value="musica" <?php if ($selected_choice == "musica") {
                                            print "selected='selected'";
                                        } ?>>Musica</option>
                </select><br>
                <label class="left"></label>
                <input type="text" name="input" id="input" size="50" placeholder="Cerca un articolo, o lascia vuoto per tutta la categoria">
                <input type="submit" value="Cerca">
            </form>
            <input type="button" value="Account" onclick="location.href = 'account.php'">

        </div>
</body>

</html>