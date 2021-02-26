//Pagina js principale del sito

//loadReviwes e loadSearchItems vengono richiamate piu volte, quindi le ho aggiunte come funzioni
//Usato per caricare le reviews di un item nella sua pagina.
function loadReviews() {
    var orders = document.getElementById("reviewOrder");
    var order = orders.options[orders.selectedIndex].value;
    $.ajax({
        type: "POST",
        url: "loadReviews.php",
        data: {
            "order": order
        },
        success: function (result) {
            $("#orderedReviews").html(result);

        }
    });

}

//simile alle review, ma carico gli item durante la ricerca
function loadSearchItems() {
    var orders = document.getElementById("itemOrder");
    var order = orders.options[orders.selectedIndex].value;

    var searchPage = $("#main");
    var searchInput = searchPage.attr("data-input");
    var searchType = searchPage.attr("data-type");
    $.ajax({
        type: "POST",
        url: "loadItems.php",
        data: {
            "order": order,
            "input": searchInput,
            "categoria": searchType
        },
        success: function (result) {
            $("#main").html(result);

        }
    });
}

//Conto i caratteri di una recensione
function countChars(obj) {
    var maxLength = 512;
    var minLength = 80;
    var strLength = obj.value.length;
    if (strLength > maxLength) {
        document.getElementById("charNum").innerHTML = '<span style="color: red;">' + strLength + ' caratteri su ' + maxLength + ' consentiti.</span>';
    } else if (strLength < minLength) {
        document.getElementById("charNum").innerHTML = '<span style="color: red;">' + strLength + ' caratteri su un minimo di ' + minLength + ' richiesti.</span>';
    } else {
        document.getElementById("charNum").innerHTML = strLength + ' caratteri su ' + maxLength + ' consentiti';
    }
}
$(document).ready(function () {
    //Questo if serve per il caricamento iniziale di item/review in base alla pagina in cui sono
    if (top.location.pathname === '/item.php') {
        loadReviews();
    } else if (top.location.pathname === '/search.php') {
        loadSearchItems();
    }

    $("#sendReview").click(function () { 
        var titolo = document.getElementById("titoloRecWrite").value;
        var desc = document.getElementById("descRecWrite").value;
        var rates = document.getElementById("votoRecWrite");
        var rate = rates.options[rates.selectedIndex].value;
        //Faccio i controlli dei dati della review inseriti. 
        //Non essendo un form non posso usare jquery validator.
        if (!/^[a-zA-Z0-9!@#$&()\\-`.+,/]{1,}/.test(titolo)) {
            alert("Titolo ha valori non validi");
        } else if (!/^[a-zA-Z0-9!@#$&()\\-`.+,/]{1,}/.test(desc)) {
            alert("Descrizione ha valori non validi");
        } else if (titolo.length > 30 || titolo.length < 10) {
            alert("Titolo deve avere min 10 max 30 char");
        } else if (desc.length < 80 || desc.length > 512) {
            alert("Descrizione deve avere min 80 max 512 char");
        } else {
            $.ajax({
                type: "POST", 
                url: "writeReview.php", 
                data: {
                    "titolo": titolo,
                    "desc": desc,
                    "rate": rate
                }, 
                success: function (result) { 
                    if (!result) {
                        alert("Hai gia scritto una recensione per questo prodotto");
                    } else {
                        alert("Review aggiunta con successo");
                        loadReviews();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

    });

    $(".fakeButton").click(function () {
        alert("Devi loggarti per usare questo funzione");

    });

    $("#reviewOrder").on('change', function (e) {
        loadReviews();
    });

    $(".cartItemRemove").click(function () { 
        /* metodo vecchio
        //Aggiorno cookie e ricarico la pagina
        var cookieArr = document.cookie.split(";");;
        // Loop through the array elements
        for (var i = 0; i < cookieArr.length; i++) {
            var cookiePair = cookieArr[i].split("=");

            if (userID == cookiePair[0].trim()) {
                IDBCursor()
                // Decode the cookie value and return
                console.log(decodeURIComponent(cookiePair[1]));
            }
        }
        */
        //Recupero id e tipo del file
        var item = $(this).closest('.cartItemWrapper');
        var itemId = item.attr("data-id");
        var itemType = item.attr("data-type");

        //Mando richiesta di aggiornnamento cookies
        $.ajax({
            type: "POST",
            url: "removeItemFromCart.php",
            data: {
                "id": itemId,
                "type": itemType
            }
        }).done(function (msg) {
            //ricarico pagina per caricare nuovamente i cookie aggiornati
            alert("Item Rimosso");
            location.reload();
        });

    });

    $("#itemOrder").on('change', function (e) {
        loadSearchItems();

    });

    $("#buyButton").click(function () {
        $.ajax({
            url: "buyItemInCart.php",
        }).done(function (msg) {
            var result = JSON.parse(msg);
            if (result[0] == 0) {
                alert("Grazie per il tuo acquisto");
                location.reload();
            } else if (result[0] == 1) {
                alert("L'articolo : " + result[1] + " non è più disponibile");
            } else if (result[0] == 2) {
                alert("Il pagamento non è andato a buon fine");
            }
        });
    });

    $("#preorderButton").click(function () {
        //aggiungo utente nella tabella preorder per questo item
        //quando l'admin cambierà la quantità del prodotto prenotato, faccio un check nel db per quel prodotto
        // e invio email a tutti quelli con prenotazione ( funzione mail di php)
        $.ajax({
            url: "preorderItem.php",
        }).done(function (msg) {
            if (msg == 0) {
                alert("Prenotazione effettuata con successo");
            } else {
                alert("Hai gia prenotato questo prodotto");
            }
        });

    });

});

