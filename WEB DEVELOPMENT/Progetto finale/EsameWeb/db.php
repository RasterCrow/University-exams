<?php
//In questo file sono presenti le funzioni in comune, principalmente quelle sul db.
$DB_USER = 'alex';
$DB_PSW = 'alexalex97';


ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

//Di default sono ordinate in base a ultime aggiunte al catalogo
function getAllItems($type)
{
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    $value = $db->quote($type);
    return $db->query("SELECT *
                       FROM $type
                       order by id desc");
}

function getAllItemsByPrice($type,$order)
{
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    $value = $db->quote($type);
    return $db->query("SELECT *
                       FROM $type
                       order by prezzo $order");
}

//Mi pare che questa funzione sia inutilizzata
function getAllItemsByReview($type)
{
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    $value = $db->quote($type);
    return $db->query("SELECT *
                       FROM $type");
}

// Queste funzioni sotto potrebbero essere riassunte con una sola
function getBooksByValue($value)
{
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    $value = $db->quote("%" . $value . "%");
    return $db->query("SELECT libro.*
                       FROM libro
                       join genere on genere.id = libro.genere
                       WHERE genere.tipo LIKE $value OR libro.autore LIKE $value OR libro.editore LIKE $value OR libro.isbn LIKE $value OR libro.titolo LIKE $value OR libro.anno_uscita LIKE $value
                       order by id desc");
}

//Usata per recupero un libro con un input ma ordinato per prezzo
function getBooksByValueAndPrice($value, $order)
{
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    $value = $db->quote("%" . $value . "%");
    return $db->query("SELECT libro.*
                       FROM libro
                       join genere on genere.id = libro.genere
                       WHERE genere.tipo LIKE $value OR libro.autore LIKE $value OR libro.editore LIKE $value OR libro.isbn LIKE $value OR libro.titolo LIKE $value OR libro.anno_uscita LIKE $value
                       order by prezzo $order");
}

function getDvdByValue($value)
{
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    $value = $db->quote("%" . $value . "%");
    return $db->query("SELECT dvd.*
                       FROM dvd
                       JOIN attori on dvd.id = attori.film
                       join genere on genere.id = dvd.genere
                       WHERE genere.tipo LIKE $value OR concat(attori.nome, ' ' , attori.cognome) LIKE $value OR attori.nome LIKE $value OR attori.cognome LIKE $value OR dvd.genere LIKE $value OR dvd.titolo LIKE $value OR dvd.regista LIKE $value
                       GROUP BY dvd.id
                       order by id desc");
}
function getDvdByValueAndPrice($value, $order)
{
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    $value = $db->quote("%" . $value . "%");
    return $db->query("SELECT dvd.*
                       FROM dvd
                       JOIN attori on dvd.id = attori.film
                       join genere on genere.id= dvd.genere
                       WHERE  concat(attori.nome, ' ' , attori.cognome) LIKE $value OR genere.tipo LIKE $value OR attori.nome LIKE $value OR attori.cognome LIKE $value OR dvd.genere LIKE $value OR dvd.titolo LIKE $value OR dvd.regista LIKE $value
                       GROUP BY dvd.id
                       order by prezzo $order");
}


function getMusicByValue($value)
{
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    if($value=="cd" || $value=="vinile"){
        return $db->query("SELECT musica.*
                       FROM musica
                       WHERE $value = 1
                       order by id desc");
    }else{
    $value = $db->quote("%" . $value . "%");
    return $db->query("SELECT musica.*
                       FROM musica
                       JOIN canzone on musica.id = canzone.album
                       WHERE canzone.titolo LIKE $value OR musica.autore LIKE $value OR musica.titolo LIKE $value OR musica.anno_uscita LIKE $value
                       GROUP BY musica.id
                       order by id desc");

    }
}
function getMusicByValueAndPrice($value, $order)
{
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    if($value=="cd" || $value=="vinile"){
        return $db->query("SELECT musica.*
                       FROM musica
                       WHERE $value = 1
                       order by prezzo $order");
    }else{
    $value = $db->quote("%" . $value . "%");
    return $db->query("SELECT musica.*
                       FROM musica
                       JOIN canzone on musica.id = canzone.album
                       WHERE canzone.titolo LIKE $value OR musica.autore LIKE $value OR musica.titolo LIKE $value OR musica.anno_uscita LIKE $value
                       GROUP BY musica.id
                       order by prezzo $order");
    }
}

function getItemById($type, $ID)
{
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    $ID = $db->quote($ID);
    //Se è un libro o dvd recupero anche il genere
    if ($type == "dvd" || $type =="libro") {
        $data = $db->query("SELECT $type.*, genere.tipo as tipo_genere, spedizione.tipo as tipo_sped, spedizione.prezzo as prezzo_sped, spedizione.tempo_consegna
    FROM $type join genere on $type.genere= genere.id join spedizione on spedizione.id= $type.spedizione
                       WHERE $type.id = $ID;");
    }else{
        $data = $db->query("SELECT $type.*, spedizione.tipo as tipo_sped, spedizione.prezzo as prezzo_sped, spedizione.tempo_consegna
    FROM $type join spedizione on spedizione.id= $type.spedizione
                       WHERE $type.id = $ID;");
    }

    return $data;
}
function getUserById($ID)
{
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    $ID = $db->quote($ID);
    return $db->query("SELECT *
                       FROM utente
                       WHERE id = $ID;");
}

function getUserByEmail($email)
{
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    $email = $db->quote($email);
    return $db->query("SELECT *
                       FROM utente
                       WHERE email = $email");
}

function getUserCard($cardId)
{
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    $cardId = $db->quote($cardId);
    return $db->query("SELECT *
                       FROM carta
                       WHERE id = $cardId");
}

//user creation
function createUser($userEmail, $userName, $userSurname, $userDate, $userCity, $userStreet, $userCityShipping, $userStreetShipping, $cardId, $userPassword)
{
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $statement = $db->prepare("INSERT INTO utente (email, nome, cognome, data_di_nascita, citta, via, citta_sped, via_sped, carta, user_password)
VALUES (:umail, :uname, :usurname, :udate, :ucity, :ustreet, :ucityship, :ustreetship, :ucard, :upsw)");

    return $statement->execute([
        'umail' => $userEmail,
        'uname' => $userName,
        'usurname' => $userSurname,
        'udate' => $userDate,
        'ucity' => $userCity,
        'ustreet' => $userStreet,
        'ucityship' => $userCityShipping,
        'ustreetship' => $userStreetShipping,
        'ucard' => $cardId,
        'upsw' => $userPassword
    ]);
}

function addCard($num, $ccv, $exp)
{

    //Solo per testare, assegno randomicamente i soldi
    $soldiIniziali = rand(10,100);
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    $db->query("INSERT INTO carta (num,ccv,scadenza,soldi)
    VALUES ('$num','$ccv','$exp','$soldiIniziali')");
    return $db->lastInsertId();
}

function getSongsByAlbumId($id)
{
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    return $db->query("SELECT *
                       FROM canzone
                       WHERE album = $id");
}

function getReviews($type, $id, $order)
{
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    return $db->query("SELECT recensione.*, utente.nome as nome
                       FROM $type
                       join recensione on $type.id = recensione.$type
                       join utente on utente.id = recensione.autore
                       WHERE $type.id = $id
                       order by voto $order
                       ");
}
//controlla se un utente ha gia aggiunto una review per tale oggetto
function checkReview($type, $id, $userId)
{
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    return $db->query("SELECT recensione.*, utente.nome as nome
                           FROM $type
                           join recensione on $type.id = recensione.$type
                           join utente on utente.id = recensione.autore
                           WHERE $type.id = $id and recensione.autore =  $userId
                           ");
}

//aggiunge una review al db
function addReview($desc, $titolo, $rate, $type, $id, $userId)
{
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $statement = $db->prepare("INSERT INTO recensione (autore, $type, voto, titolo, descrizione)
VALUES (:rautor, :rcategoria, :rvoto, :rtitolo, :rdesc)");

    return $statement->execute([
        'rautor' => $userId,
        'rcategoria' => $id,
        'rvoto' => $rate,
        'rdesc' => $desc,
        'rtitolo' => $titolo,
    ]);
}


function addToPreorder($userID, $itemType, $itemID)
{
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    $db->query("INSERT INTO preordini (utente,$itemType)
    VALUES ('$userID','$itemID')");
}

function checkPreorder($type, $id, $userId)
{
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    return $db->query("SELECT preordini.*, utente.nome as nome
                           FROM $type
                           join preordini on $type.id = preordini.$type
                           join utente on utente.id = preordini.utente
                           WHERE $type.id = $id and preordini.utente =  $userId
                           ");
}


function retrievePreorders($type, $id)
{
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    return $db->query("SELECT preordini.id as preorderID, utente.email as email, $type.titolo as titolo
                           FROM $type
                           join preordini on $type.id = preordini.$type
                           join utente on utente.id = preordini.utente
                           WHERE $type.id = $id
                           ");
}

function removePreorder($id){
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    return $db->query("DELETE FROM preordini where preordini.id = $id");

}

function decreaseItemQuantity($type, $ID)
{
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    $ID = $db->quote($ID);
    $db->query("UPDATE $type
     SET num_prod = num_prod - 1 
     WHERE id = $ID;");
}

function getActorsByMoviesId($id){
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    return $db->query("SELECT concat(attori.nome, ' ' , attori.cognome) as nome
                       FROM attori
                       WHERE attori.film = $id");
}

function getUserCardFromUserID($id){
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    return $db->query("SELECT carta.*
                       FROM carta join utente on utente.carta = carta.id
                       WHERE utente.id = $id");
}

function updateCardMoney($cardID,$newMoney){
    $dsn = 'mysql:dbname=unibs;host=localhost;port=3306';
    $db = new PDO($dsn, $GLOBALS['DB_USER'], $GLOBALS['DB_PSW']);
    $sql = "UPDATE carta SET soldi=? WHERE id=?";
    $stmt= $db->prepare($sql);
    return $stmt->execute([$newMoney,$cardID]);
}