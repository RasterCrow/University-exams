<!-- In questa pagina è presente il banner del sito, caricato su tutte le pagine tranne che nell'index. -->
<?php if (isset($_SESSION['choice'])) {

    $selected_choice = $_SESSION['choice'];
} else {

    $selected_choice = "none";
}
?>
<div id="banner">
    <h1 id="logo" onclick="location.href = 'index.php'">
        Uni IBS
    </h1>
    <div id="ricercaTop">
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
            </select>
            <input id="searchBar" type="text" name="input" id="input" size="50" placeholder="Lascia vuoto per tutta la categoria">
            <input id="searchButton" type="submit" value="Cerca">
        </form>
    </div>
    <div id="utils">
        <input type="button" value="Account" onclick="location.href = 'account.php'">
        <input type="button" value="Carrello" onclick="location.href = 'carrello.php'">
    </div>
</div>