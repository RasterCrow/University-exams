<?php include_once("top.html"); ?>



<div>
    <h1>Matches for <?= $_GET["name"] ?>.</h1>
</div>
<?php

//recupero tutti gli utenti in una lista
$users = array();
$lines = file("singles.txt", FILE_IGNORE_NEW_LINES);
foreach ($lines as $line) {
    $person = explode(",", $line);
    //se trovo me stesso mi salvo in user e non mi aggiungo alla lista di utenti
    if (strcmp($person["0"], $_GET["name"]) == 0) {
        $user = $person;
    } else {
        $users[] = $person;
    }
}
//cerco i matches
function findMatches($user, $users)
{
    $matches = array();
    foreach ($users as $person) {
        if (strcmp($user[1], $person[1]) != 0) {
            if (($user[5] <= $person[2]) && ($user[6] >= $person[2])) {

                if (strcmp($user[4], $person[4]) == 0) {

                    if (
                        similar_text($user[3], $person[3]) >= 2
                    ) {
                        $matches[] = $person;
                    }
                }
            }
        }
    }
    return $matches;
}
$matches = findMatches($user, $users);

//mostro i matches
foreach ($matches as $match) {
    ?>
<div class=match>
    <p class=match> <?= $match[0] ?>
        <img class=match src="http://www.cs.washington.edu/education/courses/cse190m/12sp/homework/4/user.jpg">

        <ul class=match>
            <li>Gender : <?= $match[1] ?></li>
            <li>Age : <?= $match[2] ?></li>
            <li>Type : <?= $match[3] ?></li>
            <li> OS : <?= $match[4] ?></li>
        </ul>
    </p>
</div>
<?php
}

?>
<?php include_once("bottom.html"); ?>