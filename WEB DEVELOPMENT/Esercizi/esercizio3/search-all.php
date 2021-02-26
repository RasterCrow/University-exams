
   <?php
    include("top.html");
    include("common.php");

    //search-all.php recupera tutti i film dato un certo attore.
    //Prima di recuperare controlla anche di trovare l'attore giusto.
    ?>
    <h1>Results for <b><?=$_GET["firstname"] . " " .$_GET["lastname"]?></b></h1> <?php
        $rows = getCorrectActor($_GET["firstname"], $_GET["lastname"]);
        if ($rows->rowCount()) {

            //la query risultato ha solo una riga ma non riesco a recuperarla senza il foreach.
            foreach ($rows as $row) {
            $rows = getAllMovies($row["id"]);
            }
            //Solo dopo aver recuperato i dati inizio a creare la tabella
            ?>
            
            <table>
            <tr>
                <th> # </th>
                <th> Title </th>
                <th> Year </th>
            </tr>
            <?php
            $i = 1;
            foreach ($rows as $row) {
                ?>
                <tr>
                    <td> <?= $i++ ?> </td>
                    <td> <?= $row["title"] ?> </td>
                    <td> <?= $row["year"] ?> </td>
                </tr>
                <?php
            }
            ?>
            </table>
            <?php
        } else {
            //Se non trovo l'attore non creo la tabella ma mando un messaggio.
        ?>
        <p class="dataNotFound">Actor <b><?= $_GET["firstname"] . " " . $_GET["lastname"] ?></b> not found.</p>
        <?php
    }
    ?>
    <?php
    include("bottom.html");
    ?>