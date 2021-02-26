    <?php
    include("top.html");
    include("common.php");


    //search-kevin.php recupera i film in cui sono presenti sia kevin bacon che l'attore dato in input.
    //Prima di recuperare controlla anche di trovare l'attore giusto dato in input.
    ?>
    <h1>Results for <b><?=$_GET["firstname"] . " " .$_GET["lastname"]?></b></h1>
     <?php
        $rows = getCorrectActor($_GET["firstname"], $_GET["lastname"]);
        if ($rows->rowCount()) {
            //la query risultato ha solo una riga ma non riesco a recuperarla senza il foreach.
            foreach ($rows as $row) {
            $rows = getMoviesSharedWithKevin($row["id"]);
            }
            if ($rows->rowCount()) {
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
            ?>
            <p class="dataNotFound">Actor <b><?= $_GET["firstname"] . " " . $_GET["lastname"] ?></b> wasn't in any movies with <i>Kevin Bacon.</i></p>
            <?php
            }
            ?>
        <?php
        } else {
            ?>
        <p class="dataNotFound">Actor <b><?= $_GET["firstname"] . " " . $_GET["lastname"] ?></b> not found.</p>
        <?php
        }   
    ?>
    <?php
    include("bottom.html");
    ?>