/*Popolamento tabelle con informazioni principali. Il resto verra' aggiunto tramite il sito.*/

/*Popolamento tabella carta */
insert into carta(num,ccv,scadenza,soldi) values('1234567891234567', '123', '2020-04-19',9999.00)


/*Popolamento tabella Utente*/
insert into utente(email,nome,cognome,data_di_nascita, citta, via, citta_sped, via_sped, gestore, carta, user_password) values('potato3@gmail.com', 'Kentang', 'Rossi', '1980-04-19', 'Milano', 'Via Mastrocchio 13','Milano', 'Via Mastrocchio 13', true, '1',SHA1("potato1"));


/*Popolamento tabella spedizione */
insert into spedizione values('1','Posta Prioritaria', '5','7');
insert into spedizione values('2','Corriere', '10','2');


/*Popolamento tabella genere */
insert into genere values('1','Fantasy');
insert into genere values('2','Horror');
insert into genere values('3','Fantascienza');
insert into genere values('4','Drama');
insert into genere values('5','Avventura');
insert into genere values('6','Azione');
insert into genere values('7','Documentario');