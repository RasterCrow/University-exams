<!DOCTYPE html>

<html lang="en">

    <?php
    $movie = filter_input(INPUT_GET, "film");
    /*
    * Notare che la funzione php nativa 'filter_input' consente di accedere 
    * al valore passato tramite metodo GET e parametro film.
    * In questo caso non applica alcun filtro all'input e sarebbe equivalente 
    * all'istruzione:
    * $movie = $_GET['film']; 
    */
    $lines = file($movie . "/info.txt", FILE_IGNORE_NEW_LINES);
    list($title, $age, $rating) = $lines; // ogni riga in una variabile
    ?>
    <head>
        <title><?= "$title" ?> - Rancid Tomatoes</title>

        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link href="movie.css" type="text/css" rel="stylesheet" />
    </head>

    <body>
        <div id="banner">
            <img src="http://www.cs.washington.edu/education/courses/cse190m/11sp/homework/2/banner.png" alt="Rancid Tomatoes" />
        </div>

        <h1><?= "$title ($age)" ?> </h1>
        <div id="box">
            <div id="turtle">
                <div>
                    <img src="<?= $movie ?>/overview.png" alt="general overview" />
                </div>
                <div id="list">

                    <?php
                    // importo il file e divido il file in base al ':'
                    foreach (file($movie . "/overview.txt") as $overview) {
                        list($first, $second) = explode(":", trim($overview));
                        ?>
                        <dl>
                            <dt><?= "$first" ?></dt>
                            <dd><?= "$second" ?></dd>
                        </dl>
                    <?php } ?>

                </div>
            </div>

            <?php
            // utilizzo glob per contare i file di tipo 'review.txt'
            $reviews = glob($movie . "/review*.txt");
            $TotalReviews = count($reviews);
            $NumReviews = $TotalReviews;
            
            ?>

            <div id="rotten">
                <div id="rottenbig">
                    <img  src="http://www.cs.washington.edu/education/courses/cse190m/11sp/homework/2/rottenbig.png" alt="Rotten" />
                    <span id="label"><?= "$rating" ?>%</span>
                </div>
                

                    <?php
                    /*
                    * viene controllato che il totale di review sia 10
                    * altrimenti il numero di recensioni che saranno visualizzate
                    * sara' posto a 10
                    */
                    if ($TotalReviews > 10) {
                        $NumReviews = 10;
                    }
                    // si stabilisce la meta': $half
                    if ($NumReviews % 2 == 0) {
                        $half = $NumReviews / 2;
                    } else {
                        $half = (int) ($NumReviews / 2) + 1;
                    }

                    ?>
                    
                    <?php
                    // estrazione delle righe del file review*.txt
                    for ($i = 0; $i < $NumReviews; $i++) {
       					
       					/* il controllo successivo stabilisce se siamo all'inizio e quindi
       					* dobbiamo 'aprire' la prima colonna, oppure se siamo a meta' delle
       					* recensioni da visualizzare e dobbiamo chiudere la prima colonna
       					* per aprire la seconda
       					*/ 
       					if ($i == 0) {
       					?>
       			<div id="colon1">
       					<?php 
       					} else if ($i == $half) {
       					?>
       			</div>
       			<div id="colon2">
       					<?php
       					}
       					/* 
       					* grazie alla funzione list riusciamo ad assegnare un valore
       					* alla recensione ($quote) al voto finale ($feedback = FRESH o ROTTEN)
       					* al recensore ($reviewer) e all'editore della rivista ($publisher)
       					*
       					* Notare l'uso del strtolower su $feedback (es., FRESH->fresh) e 
       					* della sua combinazione con ucfirst, che rende maiuscolo solo il primo 
       					* carattere (es., fresh->Fresh) per avere un valore per l'alt piu'
       					* preciso.
       					*/
                        list($quote,$feedback,$reviewer,$publisher) = 
                        	file($reviews[$i], FILE_IGNORE_NEW_LINES);
                        ?>
                        
                        <p class="paragrph">
                            <img class="icon1" src="http://www.cs.washington.edu/education/courses/cse190m/11sp/homework/2/<?= strtolower($feedback) ?>.gif" alt="<?= ucfirst(strtolower($feedback)) ?>"/>
                            <q><?= "$quote" ?></q>
                        </p>
                        <p class="reviewer">
                            <img class="icon2" src="http://www.cs.washington.edu/education/courses/cse190m/11sp/homework/2/critic.gif" alt="Critic" />
                            <?= "$reviewer" ?> <br />
                            <span class="cursive"><?= "$publisher" ?></span>
                        </p>
                    <?php } ?>
                </div>
                
            </div>

            <p id="footbar">(1-<?= "$NumReviews" ?>) of <?= "$TotalReviews" ?></p>
        </div>
        
        <!-- 
        il div sotto e' stato modificato
        in modo da richiamare i validatori html5 e non xhtml come nella versione 
        di skeleton.htm che era stata distribuita con il testo del compito precedente
        -->
        <div id="validator">
			<a href="http://validator.w3.org/check/referer"><img src="http://webster.cs.washington.edu/w3c-html.png" alt="Validate"></a> 
        <br>
			<a href="http://jigsaw.w3.org/css-validator/check/referer"><img src="http://jigsaw.w3.org/css-validator/images/vcss" alt="Valid CSS!"></a>
        </div>
    </body>
</html>
