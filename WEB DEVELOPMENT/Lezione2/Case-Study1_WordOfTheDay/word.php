<?php
include("top.html");
$WORDS_FILENAME = "words.txt";

# reads a random word line from disk and displays its text
function read_random_word() {
  global $WORDS_FILENAME;
  $lines = file($WORDS_FILENAME); # file, dato il nome del file, restituisce il numero di linee
  $random_index = rand(0, count($lines) - 1); # genero un numero casuale tra 0 e lines-1
  $random_line = $lines[$random_index]; # selezione random di una linea del file
  $tokens = explode("\t", $random_line); # ogni linea viene splittata in base al carattere tab \t
  list($word, $part, $definition) = $tokens;  # salvo le singole parole nelle variabili
  ?>  
  <blockquote>
    <p>
      <?= $word ?> - 
      <span class="partofspeech"><?= $part ?></span>. <br>
      <?= $definition ?>
    </p>
  </blockquote>

  <?php
}
?>
    <div>
      <?php
      for ($row = 1; $row <= 2; $row++) {
        for ($col = 1; $col <= 6; $col++) {
          ?>
          <img src="vocab.jpg" alt="vocab guy">
          <?php
        }
        ?>
        <br>
        <?php
      }
      ?>
    </div>
    
    <p>Your word of the day is:</p>
    <?php
    read_random_word();
    ?>
  </body>
</html>
