
<?php
//in questo file provo a effettuare l'autenticazione dell'utente
session_start();
include("db.php");

$row = getUserByEmail($_POST["userEmail"]);
if($row){
    $row = $row->fetch();
    if($row["user_password"] ==  sha1($_POST["userPassword"])){
        //Se i dati del login sono corretti salvo nella sessioni alcune informazioni dell'utente
        $_SESSION["userID"] = $row["id"];
        if($row["gestore"]==1){
            $_SESSION["admin"] = true;
        }
        
        //lo faccio tornare alla pagina account avvisandolo del login riuscito
        $_SESSION["goodLogin"] = true;
        header("Location: /account.php");

    }else{
        //Se il login è errato lo rimando al login con messaggio di errore
        $_SESSION["badLogin"] = true;
        header("Location: /login.php");
    }
}else{
    $_SESSION["badLogin"] = true;
    header("Location: /login.php");
}

?>
