
CREATE TABLE unibs.carta (
    id int unsigned NOT NULL AUTO_INCREMENT,
    num varchar(16) NOT NULL,
    ccv smallint NOT NULL,
    scadenza date NOT NULL,
	soldi int not null,
	PRIMARY KEY (id)
);



CREATE TABLE unibs.utente (
    id int unsigned NOT NULL AUTO_INCREMENT,
    email varchar(30) NOT NULL,
    nome varchar(50) NOT NULL,
    cognome varchar(50) NOT NULL,
    data_di_nascita date NOT NULL,
    `citta` varchar(50) NOT NULL,
    via varchar(50) NOT NULL,
    `citta_sped` varchar(50) NOT NULL,
    via_sped varchar(50) NOT NULL,
    gestore boolean DEFAULT 0,
    carta int unsigned NOT NULL,
	user_password varchar(255) NOT NULL,
	soldi decimal(19,2) NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (carta) REFERENCES carta(id)
);


CREATE TABLE unibs.spedizione (
    id int unsigned NOT NULL AUTO_INCREMENT,
    tipo varchar(20) NOT NULL,
    prezzo numeric(5,2) NOT NULL,
    tempo_consegna smallint NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE unibs.genere (
    id int unsigned NOT NULL AUTO_INCREMENT,
    tipo varchar(20) NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE unibs.libro (
    id int unsigned NOT NULL AUTO_INCREMENT,
    autore varchar(20) NOT NULL,
    titolo varchar(30) NOT NULL,
	descrizione TEXT NOT NULL,
    editore varchar(20) NOT NULL,
    isbn varchar(13),
    anno_uscita smallint NOT NULL,
    pagine smallint,
    prezzo numeric(5,2) NOT NULL,
    num_prod smallint NOT NULL,
    foto varchar(30) NOT NULL,
    spedizione int unsigned NOT NULL,
	genere int unsigned NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (spedizione) REFERENCES spedizione(id),
	FOREIGN KEY (genere) REFERENCES genere(id)
	
);


CREATE TABLE unibs.musica (
    id int unsigned NOT NULL AUTO_INCREMENT,
    autore varchar(20) NOT NULL,
    titolo varchar(30) NOT NULL,
	descrizione TEXT NOT NULL,
    anno_uscita smallint NOT NULL,
    cd boolean DEFAULT 0,
    vinile boolean DEFAULT 0,
    prezzo numeric(5,2) NOT NULL,
    num_prod smallint NOT NULL,
    foto varchar(30) NOT NULL,
    spedizione int unsigned NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (spedizione) REFERENCES spedizione(id)
);

CREATE TABLE unibs.canzone (
    id int unsigned NOT NULL AUTO_INCREMENT,
    titolo varchar(30) NOT NULL,
    durata smallint NOT NULL,
    album int unsigned NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (album) REFERENCES musica(id)
);



CREATE TABLE unibs.dvd (
    id int unsigned NOT NULL AUTO_INCREMENT,
    regista varchar(20) NOT NULL,
    titolo varchar(30) NOT NULL,
	descrizione TEXT NOT NULL,
    anno_uscita smallint NOT NULL,
    prezzo numeric(5,2) NOT NULL,
    num_prod smallint NOT NULL,
    foto varchar(30) NOT NULL,
    spedizione int unsigned NOT NULL,
    genere int unsigned NOT NULL,
 	PRIMARY KEY (id),
	FOREIGN KEY (spedizione) REFERENCES spedizione(id),
	FOREIGN KEY (genere) REFERENCES genere(id)

);

CREATE TABLE unibs.attori (
    id int unsigned NOT NULL AUTO_INCREMENT,
    nome varchar(20) NOT NULL,
    cognome varchar(20) NOT NULL,
    film int unsigned NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (film) REFERENCES dvd(id) 
);

CREATE TABLE unibs.recensione (
    id int unsigned NOT NULL AUTO_INCREMENT,
    autore int unsigned NOT NULL,
    libro int unsigned,
    musica int unsigned,
    dvd int unsigned,
    voto smallint NOT NULL,
	titolo varchar(50) NOT NULL,
	descrizione TEXT NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (autore) REFERENCES utente(id),
	FOREIGN KEY (libro) REFERENCES libro(id),
	FOREIGN KEY (musica) REFERENCES musica(id),
	FOREIGN KEY (dvd) REFERENCES dvd(id)
);

CREATE TABLE unibs.preordini (
    id int unsigned NOT NULL AUTO_INCREMENT,
    utente int unsigned NOT NULL,
    libro int unsigned,
    musica int unsigned,
    dvd int unsigned,
	PRIMARY KEY (id),
	FOREIGN KEY (utente) REFERENCES utente(id),
    FOREIGN KEY (libro) REFERENCES libro(id),
	FOREIGN KEY (musica) REFERENCES musica(id),
	FOREIGN KEY (dvd) REFERENCES dvd(id)
);

