/*Inserimento di un Utente */
insert into Utente values('U0365','l.grandi@gmail.com', 'Lucia', 'Grandi', '19-07-1990', 'Novara', 'Via Papaveri 12', true);
insert into Utente values('U1111','provaEliminazione@gmail.com', 'Prova', 'Provetto', '19-07-1990', 'Novara', 'Via Papaveri 12', true);

/* Inserimento dei servizi*/
insert into Servizi values('S8403',true, true, false, true);

/*Inserimento di un Alloggio */
insert into Alloggio values('A1319','S8403','U0365', 'Big room', 'Stanza', 30, 2, 1, 1, 'Novara', 'Via marzapane 5', 'Italia');

/*Ricerca alloggio per prezzo*/
select ID, Nome, prezzo
from Alloggio
order by Prezzo asc;

/*Mostra recensioni di un alloggio*/
select alloggio.nome, Voto, utente.email
from Recensione_alloggio
join alloggio on alloggio.id=recensione_alloggio.alloggio
join utente on utente.id=recensione_alloggio.mittente
where alloggio.nome='Albergo punte arrotondate'

/*Rimozione utente*/
delete from Utente where Email='provaEliminazione@gmail.com';
