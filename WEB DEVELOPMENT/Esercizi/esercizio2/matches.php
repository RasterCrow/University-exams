<?php include("top.html"); ?>

<form action="/esercizio2/matches-submit.php" method="get">
    <fieldset>
        <legend>Returning User:</legend>
        <label for="name">Name:</label>
        <input type="text" name="name" id="name" size="16"><br>

        <input type="submit" value="View My Matches">
    </fieldset>
</form>

<?php include("bottom.html"); ?>