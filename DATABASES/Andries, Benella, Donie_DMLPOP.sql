/*Popolamento tabella Utente*/
insert into Utente values('U0001','potato3@gmail.com', 'Kentang', 'Rossi', '19-04-1980', 'Milano', 'Via Mastrocchio 13', false);
insert into Utente values('U0002','affleck50@gmail.com', 'Ben', 'Affleck', '3-10-1975', 'Roma', 'Via Laderlappen 9b', false);
insert into Utente values('U0003','pliskin@yahoo.it', 'David', 'Pliskin', '26-08-1986', 'Palermo', 'Via Serpente Solido', false);
insert into Utente values('U0004','whitewolf99@gmail.com', 'Geraldo', 'Bianchi', '11-03-1990', 'Roma', 'Viale Riviano', true);
insert into utente values('U0005', 'marco@gmail.com', 'Marco', 'Carega', '14-01-1996' , 'Villalvernia', 'Via dei gatti', false);
insert into utente values('U0006', 'giovanni_mucia@gmail.com', 'Giovanni', 'Muciaccia', '16-03-1965' , 'Catania', 'Via delle banane', true);
insert into utente values('U0007', 'dario_bosi@hotmail.it', 'Dario', 'Bosi', '14-01-1968' , 'Tortona', 'Via dei gamberi', true);
insert into utente values('U0008', 'matteo_salve@gmail.com', 'Matteo', 'Salvini', '09-03-1973' , 'Milano', 'Via del nord', false);
insert into utente values('U0009', 'cristiano_cr7@gmail.com', 'Cristiano', 'Ronaldo', '05-02-1985' , 'Torino', 'Via dello sport', false);
insert into utente values('U0010', 'matty_gaggiu@gmail.com', 'Mattia', 'Gargiulo', '15-06-1997' , 'Tortona', 'Via madre michela', false);
insert into Utente(id, email,nome,cognome,data_di_nascita,città,via) values('U0011','antony_canna@outlook.com', 'Antonino', 'Cannavacciuolo', '16-05-1975', 'Vico Equense', 'Via Balaustra 12');
insert into Utente values('U0012','provaEliminazione@gmail.com', 'Prova', 'Eliminazione', '1-01-1991','Unotopia','Via numero uno', false); 


/*Popolamento tabella Servizi */
insert into Servizi values('S0001',true, true, false, true);
insert into Servizi values('S0002',true, true, true, true);
insert into Servizi values('S0003',false, true, false, true);
insert into Servizi values('S0004',false, true, false, true);
insert into Servizi values('S0005',true, false, true, true);
insert into Servizi values('S0006',false, true, false, false);


/*Popolamento tabella Alloggio*/
insert into Alloggio (ID, Servizi, Proprietario, Nome, Tipo, Prezzo, Num_letti, Num_camere, Città, Via, Paese) values('A0001', 'S0001', 'U0004','Albergo del lupo','Appartamento', 50, 2, 3, 'Roma', 'Via San Gennaro 12', 'Italia');
insert into Alloggio values('A0002', 'S0002', 'U0004', 'Camera Bianca', 'Stanza', 50, 2, 1, 1, 'Roma', 'Via Passpartout 3', 'Italia');
insert into alloggio values('A0003', 'S0003','U0007', 'Ostello Fregatello', 'Appartamento', '25', '4', '3', '6', 'Tortona', 'Via delle banane', 'Italia');
insert into alloggio values('A0004', 'S0004','U0010', 'Pizza Pazza' , 'Camera', '10', '1', '1', '2', 'Tortona', 'Via madre michela', 'Italia');
insert into alloggio values('A0005', 'S0005','U0006', 'Albergo punte arrotondate' , 'Appartamento', 80, 3, 2, 2, 'Genova', 'Via colla vinilica', 'Italia');
insert into alloggio values('A0006', 'S0006','U0009', 'Apparamento Sport&go' , 'Appartamento', 100, 2, 2, 1, 'Bari', 'Piazza Orologiai', 'Italia');
 
/*Popolamento recensioni utente */
insert into recensione_utente values('UT03A', 'U0004', 'U0005', '5', '12-03-2018');
insert into recensione_utente values('UT19B', 'U0008', 'U0007', '2', '12-03-2018');
insert into recensione_utente values('1111', 'U0011', 'U0001','1', '1-1-2001');

/*Popolamento recensioni alloggi*/
insert into recensione_alloggio values('AE81K', 'U0009', 'A0002', '5', '25-08-2018');
insert into recensione_alloggio values('AO29C', 'U0001', 'A0003', '4', '05-05-2018');
insert into recensione_alloggio values('A111', 'U0011', 'A0005', '1', '1-1-2011');
insert into recensione_alloggio values('AO35C', 'U0009', 'A0005','2', '06-05-2018');

/*Popolamento commenti*/
insert into commento values('OF0E33', 'U0005', 'AE81K',null, '26-08-2018 19:35', false );
insert into commento values('N1BB4', 'U0008', 'AO29C', null, '12-06-2018 8:11', false);
insert into commento values('X01OL', 'U0002', 'AO29C', null, '30-07-2018 15:03', true);
insert into commento values('X55P', 'U0002', null, 'UT03A', '11-07-2018 09:28', true);
insert into commento values('C011', 'U0011', null, '1111', '11-11-2012',true);

/*Popolamento associazione Prenotazione */
insert into prenotazione_alloggio values('U0001', 'A0006', 'P012','8-05-2018', '15-05-2018', 'bonifico');
insert into prenotazione_alloggio values('U0001', 'A0004', 'P088','1-07-2018', '15-07-2018', 'bonifico');
insert into prenotazione_alloggio values('U0003', 'A0004', 'P075','15-06-2018', '17-06-2018', 'paypal');
