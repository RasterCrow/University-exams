
<?php
// in questo file eseguo l'acquisto degli item presenti nel carrello
session_start();
include("db.php");

//recupero gli item dal cookie
$totalSpent=0;
$itemsInCart = unserialize($_COOKIE[$_SESSION["userID"]]);
foreach ($itemsInCart as $cartItem) {
    $item = getItemById($cartItem[1], $cartItem[0])->fetch();
    //controllo se gli item sono ancora disponibili
    if ($item["num_prod"] == 0) {
        echo json_encode(array(1, $item["titolo"]));
        exit();
    }
    $totalSpent+=$item["prezzo"];
}
//Recupero carta
$card = getUserCardFromUserID($_SESSION["userID"])->fetch();
    
//controllo se ha soldi sulla carta
if($card["soldi"] < $totalSpent){
    echo json_encode(array(2, $item["titolo"]));
    exit;
}
//Non gestisco gli ordini al momento
//Rimuovo soldi dalla carta
updateCardMoney($card["id"],$card["soldi"]-$totalSpent);
    
//Aggiorno quantità item sul db
foreach ($itemsInCart as $cartItem) {
    decreaseItemQuantity($cartItem[1], $cartItem[0]);
}
//svuoto carrello
setcookie($_SESSION["userID"], "", time() - 3600);

//ritorno il messaggio di acquisto riuscito
echo json_encode(array(0, $item["titolo"]));

