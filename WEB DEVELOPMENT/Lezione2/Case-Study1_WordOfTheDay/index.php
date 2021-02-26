<?php
include("top.html");
$HIT_COUNTER_FILENAME = "hits.txt";

# Reads hit count from disk, increments/writes it, and returns it.
function hit_counter() {
  global $HIT_COUNTER_FILENAME;
  if (file_exists($HIT_COUNTER_FILENAME)) {
    $hits = file_get_contents($HIT_COUNTER_FILENAME);
  } else {
    $hits = 0;
  }
  $hits++;
  file_put_contents($HIT_COUNTER_FILENAME, $hits);
  return $hits;
}
?>
    <p>Welcome to Jessica's GRE vocab word of the day page!  Each time
      you visit, a random word and its definition will be shown.</p>
    <p><a href="word.php">See my word of the day!</a></p>
    <hr />
    <p>This page has been accessed <?= hit_counter() ?> times.</p>
  </body>
</html>
