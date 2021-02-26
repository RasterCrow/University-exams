create table Utente(
	ID varchar(5),
	Email varchar(30) not null,
	Nome varchar(20) not null,
	Cognome varchar(20) not null,
	Data_di_nascita date not null,
	Città varchar(20) not null,
	Via varchar(20) not null,
	Superhost boolean default false,
	constraint pk_Utente primary key(ID)
);

create table Servizi(
	ID varchar(5),
	Wifi boolean default false,
	Ascensore boolean default false,
	Giardino boolean default false,
	Internet boolean default false,
	constraint pk_Servizi primary key(ID)
);

create table Alloggio(
	ID varchar(5),
	Servizi varchar(5) not null,
	Proprietario varchar(30) not null,
	Nome varchar(50),
	Tipo varchar(15) not null,
	Prezzo decimal(7,2) not null,
	Num_letti smallint,
	Num_camere smallint,
	Max_ospiti smallint,
	Città varchar(20) not null,
	Via varchar(20) not null,
	Paese varchar(20) not null,
	constraint pk_Alloggio primary key(ID),
	constraint fk_Alloggio_servizi foreign key(Servizi) references Servizi(ID)
	on delete cascade on update cascade,
	constraint fk_Alloggio foreign key(Proprietario) references Utente(ID)
	on delete cascade on update cascade
);

create domain votazione 
as smallint
check (value >=1 AND value <= 5);

create table Recensione_alloggio(
	ID varchar(10),
	Mittente varchar(30) ,
	Alloggio varchar(30),
	Voto votazione not null,
	"Data" date,
	constraint pk_Rec_alloggio primary key(ID),
	constraint fk_Rec_alloggio_mitt foreign key(Mittente) references Utente(ID)
	on delete set null on update cascade,
	constraint fk_Rec_alloggio_dest foreign key(Alloggio) references Alloggio(ID)
	on delete cascade on update cascade
);


create table Recensione_utente(
	ID varchar(10),
	Mittente varchar(30),
	Destinatario varchar(30),
	Voto votazione not null,
	"Data" date,
	constraint pk_Rec_utente primary key(ID),
	constraint fk_Rec_utente_mit foreign key(Mittente) references Utente(ID)
	on delete set null on update cascade,
	constraint fk_Rec_utente_dest foreign key(Destinatario) references Utente(ID)
	on delete cascade on update cascade
);


create table Commento(
	ID varchar(12),
	Mittente varchar(30),
	ID_recensione_alloggio varchar(10) default null,
	ID_recensione_utente varchar(10) default null,
	Data_ora timestamp,
	Private boolean default false,
	constraint pk_Commento primary key(ID),
	constraint fk_Commento_mitt foreign key(Mittente) references Utente(ID)
	on delete set null on update cascade,
	constraint fk_Commento_rec_all foreign key(ID_recensione_alloggio) references Recensione_alloggio(ID)
	on delete cascade on update cascade,
	constraint fk_Commento_rec_utente foreign key(ID_recensione_utente) references Recensione_utente(ID)
	on delete cascade on update cascade
);


create table Prenotazione_alloggio(
	Utente varchar(30)not null,
	Alloggio varchar(20)not null,
	ID_prenotazione varchar(10) ,
	Data_inizio date not null,
	Data_fine date not null,
	Tipo_pagamento varchar(20) not null,
	constraint pk_Prenotazione primary key(ID_prenotazione),
	constraint fk_Prenotazione_utente foreign key(Utente) references Utente(ID)
	on delete cascade on update cascade,
	constraint fk_Prenotazione_alloggio foreign key(Alloggio) references Alloggio(ID)
	on delete cascade on update cascade
);

