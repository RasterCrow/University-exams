//Alexandru Stefan Andries 20018146
//riga e colonna dello spazio bianco
var blankRow, blankColumn;
// Variabili globali per controllo shuffle e vittoria
var shuffled, haswon;
//variabili final con n.pezzi e valore n della funzione random
let NPIECES = 15, N = 50;

/*al caricamento posiziono le pedine al posto giusto, le loro immagini, le funzioni onclick, faccio un controllo
* per pedine vicino allo spazio vuoto e attivo il pulsante shuffle
*/
window.onload = function () {
    newGame();
}

function newGame() {
    var indexRow = 0, indexColumn = 0;
    blankRow = 3;
    blankColumn = 3;
    haswon = false;
    //array con tutti i pezzi di gioco
    var pieces = document.getElementById("puzzlearea").getElementsByTagName("div");
    //inizializzo tutte le pedine
    for (var i = 0; i < pieces.length; i++) {
        pieces[i].classList.add("pezzo");
        initialSetPositionNameImage(pieces[i], indexRow, indexColumn);
        pieces[i].onclick = function () {
            if (shuffled) {
                if (!haswon)
                    movePiece(this);
            } else {
                alert("Se non mescoli non c'e' divertimento :)");
            }
        };
        //aggiorno riga e colonna
        if (i == 3 || i == 7 || i == 11) {
            indexRow++;
            indexColumn = 0;
        } else
            indexColumn++;
    }
    checkMovablePieces();
    document.getElementById("shufflebutton").onclick = function () {
        shuffle();
    };
}

//Usato solamente nel setup iniziale della pagina
function initialSetPositionNameImage(piece, row, column) {
    //Assegno un id con riga_colonna a ogni div
    piece.id = "piece_" + row + "_" + column;
    //posiziono la pedina
    piece.style.position = 'absolute';
    piece.style.left = column * 100 + 'px';
    piece.style.top = row * 100 + 'px';
    //posiziono il background
    piece.style.backgroundPosition = "-" + column * 100 + 'px -' + row * 100 + 'px';
}

//movePiece è il movimento di una pedina verso quella vuota
function movePiece(piece) {
    if (piece.classList.contains("movablepiece")) {
        setNewPositionAndName(piece, blankRow, blankColumn);
        checkWinStatus();
        checkMovablePieces();
    }
}

//Usato per aggiornare la posizione di una pedina e quella della pedina vuota
function setNewPositionAndName(piece, newRow, newColumn) {
    var currentRow = parseInt(piece.id.charAt(6));
    var currentColumn = parseInt(piece.id.charAt(8));
    //Assegno un id con riga_colonna a ogni div
    piece.id = "piece_" + newRow + "_" + newColumn;
    //posiziono la pedina nella suona nuova posizione
    piece.style.left = newColumn * 100 + 'px';
    piece.style.top = newRow * 100 + 'px';
    //aggiorno la nuova posizione della pedina vuota
    blankColumn = currentColumn; blankRow = currentRow;
    //imposto colore dello sfondo bianco alla posizione precedente ( non so perche ma funziona anche se ho gia cambiato la sua posizione ) 
    piece.style.backgroundColor = "white";
}

//controllo le pedine che si possono muovere tra tutte quelle sulla board
function checkMovablePieces() {
    var indexRow = 0, indexColumn = 0;
    var currentRow;
    var currentColumn;
    var piece;
    for (var i = 0; i <= NPIECES; i++) {
        //se la pedina non è quello vuota
        if ((indexRow != blankRow) || (indexColumn != blankColumn)) {
            piece = document.getElementById("piece_" + indexRow + "_" + indexColumn);
            //posizione della pedina attuale
            currentRow = parseInt(piece.id.charAt(6));
            currentColumn = parseInt(piece.id.charAt(8));
            //se il giocate ha gia vinto rimuovo semplicemente il movablepiece da tutti i pezzi che lo hanno
            if (haswon) {
                if (piece.classList.contains("movablepiece"))
                    piece.classList.remove("movablepiece");
            } else {
                //altrimenti controllo
                //se vicino al blank aggiungo la classe movablepiece, altrimenti controllo se in precedenza lo aveva e lo rimuovo
                if ((currentRow == (blankRow - 1) && currentColumn == blankColumn) ||
                    (currentRow == (blankRow + 1) && currentColumn == blankColumn) ||
                    (currentRow == blankRow && currentColumn == (blankColumn - 1)) ||
                    (currentRow == blankRow && currentColumn == (blankColumn + 1))) {
                    piece.classList.add("movablepiece");
                } else if (piece.classList.contains("movablepiece"))
                    piece.classList.remove("movablepiece");
            }
        }
        //aggiorno riga e colonna
        if (i == 3 || i == 7 || i == 11) {
            indexRow++;
            indexColumn = 0;
        } else
            indexColumn++;
    }
}

//controllo se il giocatore ha vinto
function checkWinStatus() {
    var completato = true;
    var indexRow = 0, indexColumn = 0;
    var piece;
    //se la blank non è nella posizione giusta non inizio neanche a controllare
    if (blankRow == 3 && blankColumn == 3) {
        for (var i = 0; i < NPIECES; i++) {
            //praticamente controllo che le pedine sia numerate da 1 a 15 in ordine. 
            piece = document.getElementById("piece_" + indexRow + "_" + indexColumn);
            if (parseInt(piece.innerHTML) != i + 1)
                completato = false;
            //aggiorno riga e colonna
            if (i == 3 || i == 7 || i == 11) {
                indexRow++;
                indexColumn = 0;
            } else
                indexColumn++;
        }
        if (completato) {
            //alert("Hai vinto");
            haswon = true;
            updatePage();
        }
    }
}

//update page mi nasconde il pulsante shuffle, aggiunge quello new game e l-immmagine di gameover.
//al momento il btn newgame refresha la pagina, ma potrebbe anche invocare la funzione newgame. questo però porterebbe 
// a una serie di funzioni annidate in base a quanti newgame fa il player. In pi\ il pulsante shuffle non è impostato per ricomparire nella funzione newGame()
function updatePage() {
    //nascondo il pulsante shuffle
    document.getElementById("shufflebutton").style.visibility = "hidden";
    //creo pulsante per il newgame
    var btn = document.createElement("BUTTON");
    btn.id = "newgamebtn";
    btn.innerHTML = "New Game";
    document.getElementById("controls").appendChild(btn);
    // posizione l-image del gameover
    var img = document.createElement('img');
    img.classList.add("gameoverimg");
    document.getElementById("puzzlearea").appendChild(img);
    btn.onclick = function () {
        //anziche richiamare la funzione newgame faccio un reload della pagina.
        //potrei anche richiamare quella funzione
        location.reload();
    };

}

// la funzione shuffle prende tutti i div con classe movable, ne sceglie uno a caso e lo sposta.
function shuffle() {
    //numero di mosse da fare per lo shuffle, minimo 25
    var x = parseInt(Math.random() * N) + 25;
    var movablePieces;
    var pieceToMove;
    var previouslyMoved = "";
    for (var i = 0; i < x; i++) {
        movablePieces = document.getElementsByClassName("movablepiece");
        //questo ciclo impedisce il movimento della stessa pedina più volte di seguito
        do {
            pieceToMove = movablePieces[parseInt(Math.random() * movablePieces.length)];
        } while (previouslyMoved == pieceToMove.innerHTML)
        movePiece(pieceToMove);
        previouslyMoved = pieceToMove.innerHTML;
        console.log("moved piece n' " + pieceToMove.innerHTML);
    }
    shuffled = true;
}