/*Query 1:
Contare il numero di lingue in cui le release contenute nel database sono scritte (il risultato deve contenere soltanto il numero delle lingue, rinominato “Numero_Lingue”).

 Per la query controlliamo solamente nell'entità Release, il suo attributo language, senza fare join con altre entità.
 Prima abbiamo pensato a come distinguere i language per non contarli tutti, ed il comando distinct ci ha risolto il problema.
 Non abbiamo bisogno di entrare  nell'attributo language in quanto non ci interessa sapere quali sono queste lingue.
 Per il controllo del risultato bisogno controllare anche l'attributo ID nell'entità Language al quale Release.language fa riferimento.
*/

select count (distinct Language) as Numero_Lingue
from Release

/*Per controllare*/
select distinct Language.name 
from Release, Language
where Release.language= Language.ID


/*Query 2:
Elencare gli artisti che hanno cantato canzoni in italiano (il risultato deve contenere il nome dell’artista e il nome della lingua).

Per questa query essendo che la lingua Italiano non esiste nel database ( Viene inserita nel valore Multiple Languages ) abbiamo usato quella Francese.
Avendo bisogno sia del nome dell'artista che della lingua delle sue canzoni abbiamo dovuto analizzare le entità artist_credit, release e language.
Abbiamo fatto un join tra release e artist_credit fermandoci a lui ( non è encessario arrivare fino ad artist, in quanto anche artist_credit comprende il nome) tramite la chiave primaria id di artist_Credit e chiave esterna artist_credit di release.
Un secondo join tra release e language, con chiave primaria id di language e chiave esterna language di release.
Non è stato necessario analizzare sottoquery.
Non è stato necessario fare un controllo del risultato, in quanto questa query ci pare molto sintetica.
*/
select distinct artist.name as nome_artista, language.name as nome_lingua
from artist
join artist_credit_name on artist_credit_name.artist = artist.id
join artist_credit on artist_credit_name.artist_credit = artist_credit.id
join release on Artist.ID=release.artist_credit
join language on language.id=release.language
where language.name='French'


/*Query 3:
Elencare le release di cui non si conosce la lingua (il risultato deve contenere soltanto il nome della release).

Per questa query abbiamo assunto che con non si conosce la lingua si intenda che il valore language valga null.
Un altro possibile modo di intendere la frase era di di tenere in considerazione anche le release con multiple languages, in quanto non si conosce con esattezza la lingua della release.
Nella descrizione del database non viene fatto riferimento a questa cosa.
Abbiamo dunque analizzato semplicemente l'entità release con language is null.
Non è stato necessario analizzare sottoquery.
Per controllare nella select abbiamno aggiunto anche l'attributo language per vedere se tutti fossero null.

*/

select name as Nome_release 
from release
where language is null;

/*Per controllare*/
select name, language 
from release
where language is null

/*Query 4:
Elencare le release che nel nome hanno la parola “love”, in qualsiasi posizione (quindi anche in prima posizione; il risultato deve contenere soltanto il nome della release).

Per questa query abbiamo analizzato semplicemente nell'entità release l'attributo name.
Abbiamo dovuto mettere Love con L maiuscola in quanto con l minuscola non erano presenti risultati.
Non è stato necessario analizzare sottoquery.
Non è stato necessario fare un controllo del risultato, in quanto questa query ci pare molto sintetica.
*/

select distinct release.name as name  
from release
where name like '%Love%';

/*Query 5:
Elencare tutti gli pseudonimi di Prince con il loro tipo, se disponibile (il risultato deve contenere lo pseudonimo dell'artista, il nome dell’artista (cioè Prince) e il tipo di pseudonimo (se disponibile)).

In questa query abbiamo dovuto analizzare l'entità artist per il nome originale, artist_alias per lo pseudonimo e artist_alias_type per il tipo di quello pseudonimo.
Un join tra artist e artist_alias su chiave primaria ID di artist e chiave esterna artist di artist_alias.
Un join tra artist_alias e artist_alias_type su chiave esterna type del primo e chiave primaria id del secondo.
Non è stato necessario analizzare sottoquery.
Non è stato necessario fare un controllo del risultato, in quanto questa query ci pare molto sintetica.
*/

select artist_alias.name as pseudonimo, Artist.name as Nome, artist_alias_type.name as Tipo
from Artist 
join artist_alias on Artist.id=artist_alias.artist 
left join Artist_alias_type on artist_alias.Type=artist_alias_type.id
where Artist.name='Prince';


/*Query 6:
Elencare le release di gruppi inglesi ancora in attività 
(il risultato deve contenere il nome del gruppo e il nome della release e essere ordinato per nome del gruppo e nome della release)

In questa query abbiamo avuto bisogno di informazioni dall'entità artist, artist_type, area e release.
In artist abbiamo semplicemente avuto bisogno del nome e un controllo su artist.ended per vedere se il gruppo si è sciolto.
Abbiamo dunque fatto un join tra artist e artist_type con chiave esterna type nel primo e chiave primaria id nel secondo.
Artist_type ci serviva per sapere se l'artista era un gruppo.
Un altro join tra area e artist con chiave primaria id nel primo e chiave esterna area nel secondo.
Questa entità ci serviva per sapere se il gruppo proveniva dall' United Kingdom.
Infine abbiamo fatto il join tra artist e artist_credit_name, tra artist_credit_name e artist_credit, tra artist_credit e release.
Questo perche per arrivare da artist a release seguendo lo schema del database è necessario passare per queste "entità" prima.
In release abbiamo semplicemente preso il nome delle release di ogni gruppo.
Non è stato necessario analizzare sottoquery, sapevamo di dover analizzare solo queste entità, quindi abbiamo fatto join tra loro e preso i dati che ci interessavano.
Non è stato necessario fare un controllo del risultato, in quanto questa query ci pare molto sintetica.
*/
select distinct artist.name as Nome_artista, release.name as nome_release
from (((Artist 
        join artist_type on Artist.type=artist_type.ID ) 
        join Area on artist.area=area.ID) 
        join artist_credit_name on artist_credit_name.artist = artist.id
        join artist_credit on artist_credit_name.artist_credit = artist_credit.id
        join release on Artist.ID=release.artist_credit)
where artist_type.name='Group' and area.name='United Kingdom' and Artist.ended=false
order by artist.name asc, release.name asc;

/*Query 7:
Trovare le release in cui il nome dell’artista è diverso dal nome accreditato nella release 
(il risultato deve contenere il nome della release, il nome dell’artista accreditato (cioè artist_credit.name) e il nome dell’artista (cioè artist.name))

In questa query abbiamo utilizzato principalmente le entità artist e release.
Abbiamo dunque fatto il join tra le due, passando nuovamente tra artist_Credit_name e artist_credit.
Abbiamo infine preso  i dati richiesti dei soli casi in cui artist_credit.name <> artist.name
Non è stato necessario analizzare sottoquery.
Non è stato necessario fare un controllo del risultato, in quanto questa query ci pare molto sintetica.
*/

SELECT distinct release.name as Nome_release, artist_credit.name as Nome_Creditato, artist.name as Nome_Artista
  FROM artist_credit_name
  JOIN artist ON artist_credit_name.artist = artist.id
  JOIN artist_credit ON artist_credit_name.artist_credit = artist_credit.id
  JOIN release ON release.artist_credit = artist_credit.id
  WHERE artist_credit.name <> artist.name;

/*Query 8
Trovare gli artisti con meno di tre release (il risultato deve contenere il nome dell’artista ed il numero di release).

In questa query abbiamo usato solamente le entità release e artist.
Abbiamo nuovamente effettuato il join intermezzi per poterle joinare tra loro ( release e artist ).
Abbiamo dunque contato le release di ogni gruppo con la funzione count, mettendo il group by ad artist.name e abbiamo selezionato solo quelle con count < 3
Non è stato necessario analizzare sottoquery.
Per il controllo si possono controllare tutte le release di un artista trovato con la query principale, nel nostro caso per es. Phish
*/

SELECT distinct artist.name as Nome,  count(release.name) Numero_release
    from artist
    join artist_credit_name on artist_credit_name.artist = artist.id
    join artist_credit on artist_credit_name.artist_credit = artist_credit.id
    left join release on Artist.ID=release.artist_credit
    group by artist.name
    having count(release.name)<3

/*CONTROLLO */
SELECT *
    from artist
    join artist_credit_name on artist_credit_name.artist = artist.id
    join artist_credit on artist_credit_name.artist_credit = artist_credit.id
    join release on Artist.ID=release.artist_credit
    where artist.name='Phish'
	
/*Query 9 
Trovare la registrazione più lunga di un’artista donna 
(il risultato deve contenere il nome della registrazione, la sua durata in minuti e il nome dell’artista;
tenere conto che le durate sono memorizzate in millesimi di secondo) 
(scrivere due versioni della query con e senza operatore aggregato MAX).

In questa query abbiamo analizzato principalmente le entità artist/gender e recording.
Anche qui come per release abbiamo abbiamo dovuto fare i join tra artist_credit e artist_credit_name per arrivare al join finale
con recording tra artist_credit.id e recording.artist_Credit.
Abbiamo infine fatto un join anche tra artist e gender in quanto avevamo bisogno del'attributo gender.name per sapere se era Male o Female.
Questi controlli fino ad ora valgono per entrambe le versioni, da qui invece le cose sono diverse.
Nel caso della versione senza MAX abbiamo preso quello >= all da una sottoquery che seleziona tutti i recording di artisti donne.
Nel caso della versione con MAX abbiamo messo come condizione della query principale che recording.length valga  il MAX di una sottoquery che praticamente seleziona tutti i recording con length non null.
Per il controllo si può selezionare tutti i recording delle donne e andare a vedere di persona la più lunga per controllare il risultato.
*/

/* Senza MAX */	
SELECT  artist.name as Nome, recording.name as Nome_registrazione, recording.length as durata 
    from artist
    join gender on artist.gender = gender.id
    join artist_credit_name on artist_credit_name.artist = artist.id
    join artist_credit on artist_credit_name.artist_credit = artist_credit.id
    join recording on artist_credit.ID=recording.id
    where gender.name = 'Female' and recording.length>= all(
		select recording.length 
		from artist
   		join gender on artist.gender = gender.id
    	join artist_credit_name on artist_credit_name.artist = artist.id
    	join artist_credit on artist_credit_name.artist_credit = artist_credit.id
    	join recording on artist_credit.ID=recording.id
		where gender.name = 'Female' and recording.length is not null)
	
/* Con MAX */

SELECT  artist.name as Nome, recording.name as Nome_registrazione, recording.length as Durata
    from artist
    join gender on artist.gender = gender.id
    join artist_credit_name on artist_credit_name.artist = artist.id
    join artist_credit on artist_credit_name.artist_credit = artist_credit.id
    join recording on Artist.ID=recording.id
    where gender.name = 'Female' and recording.length=(
        SELECT max(recording.length) as durata 
        from artist
        join gender on artist.gender = gender.id
        join artist_credit_name on artist_credit_name.artist = artist.id
            join artist_credit on artist_credit_name.artist_credit = artist_credit.id
            join recording on Artist.ID=recording.id
        where gender.name = 'Female' and recording.length is not null
        )

/* QUERY 10 
Elencare le lingue cui non corrisponde nessuna release 
(il risultato deve contenere il nome della lingua, il numero di release in quella lingua, cioè 0, e essere ordinato per lingua) 
(scrivere due versioni della query; almeno una delle due versioni non deve utilizzare le viste).

In questa query abbiamo controllato principalmente le entità release e lingue e rispettivamente i loro campi lingua e nome_lingua
Entrambi le versioni usano la stessa tecnica, solo che quella con vista crea una vista a parte.
Abbiamo preso le lingue totali e contato quante volte compaiono in release, raggrupandolo per lingua.
Infine abbiamo preso solo quelle con count=0
*/
/*Senza vista */
SELECT language.name as nome_lingua, count(release.id) as frequenza
from language
left join release on release.language = language.id
group by language.name
having count(release.id)=0
		   

/*CON VISTA*/

create view  LingueUsate as
	SELECT language.name as nome_lingua, count(release.id) as frequenza
	from language
	left join release on release.language = language.id
	group by language.name
    
SELECT *
from LingueUsate
group by LingueUsate.nome_lingua, LingueUsate.frequenza
having LingueUsate.frequenza=0


/*QUERY 11
Ricavare la seconda registrazione per lunghezza di un artista uomo (il risultato deve comprendere l'artista accreditato, il nome della registrazione e la sua lunghezza) 
(scrivere due versioni della query; almeno una delle due versioni non deve utilizzare le viste).

Gli attributi principali che analizziamo sono artist.name, recording.name e recording.length.
Abbimao dunque fatto nelle query interessate i join tra artist e recording, passando ovviamente tra artist_credi e artist_credit_name.
Questa query senza limit divneta molto ridondante.
La logica principale della query è che inizialmente prendiamo il tutte le registrazioni con artisti maschi e durata non null.
Abbiamo chiamato questa sottoquery male_recordings.
Un'altra query seleziona in seguito il max con durata.length come attributo e lo mette all'except di nuovamente la query male_recordings.
In questo modo togliamo da male recordings il max per durata e il seconodo per durata diventa ora il primo.
Questa query totale l'abbiamo chiamata new_male_recordings.
In seguito prendiamo il max di new_male_recordings che è quello che ci interessa e prendiamo i dati ( artist.name ecc..) della recording con durata uguale a quella restituita dal max.
Nella versione con vista abbiamo preso le sottoquery male_recordings e new_male_recordings e le abbiamo inserite in due viste, ma la logica della query è sempre quella.
*/

/*SENZA VISTE */
SELECT distinct artist.name as Nome, recording.name as Nome_registrazione, recording.length as durata 
from artist 
join gender on artist.gender = gender.id
join artist_credit_name on artist_credit_name.artist = artist.id
join artist_credit on artist_credit_name.artist_credit = artist_credit.id
join recording on Artist.ID=recording.id
WHERE recording.length =
(select max(new_male_recordings.durata)
from(
	SELECT recording.length as durata 
	from artist 
	join gender on artist.gender = gender.id
    join artist_credit_name on artist_credit_name.artist = artist.id
    join artist_credit on artist_credit_name.artist_credit = artist_credit.id
    join recording on Artist.ID=recording.id
    WHERE gender.name = 'Male' and recording.length is not null
	except(
		select max(male_recordings.durata)
		from(
			SELECT distinct recording.id as id_record, recording.length as durata 
        	from artist 
        	join gender on artist.gender = gender.id
        	join artist_credit_name on artist_credit_name.artist = artist.id
        	join artist_credit on artist_credit_name.artist_credit = artist_credit.id
        	join recording on Artist.ID=recording.id
        	WHERE gender.name = 'Male' and recording.length is not null
		)male_recordings
	) 
)new_male_recordings
)
	
	
/* CON VISTA */
	create view male_recordings as
	SELECT distinct recording.id as id_record, recording.length as durata 
        	from artist 
        	join gender on artist.gender = gender.id
        	join artist_credit_name on artist_credit_name.artist = artist.id
        	join artist_credit on artist_credit_name.artist_credit = artist_credit.id
        	join recording on Artist.ID=recording.id
        	WHERE gender.name = 'Male' and recording.length is not null

		
	create view new_male_recordings as
	SELECT recording.length as durata 
		from artist 
		join gender on artist.gender = gender.id
		join artist_credit_name on artist_credit_name.artist = artist.id
		join artist_credit on artist_credit_name.artist_credit = artist_credit.id
		join recording on Artist.ID=recording.id
		WHERE gender.name = 'Male' and recording.length is not null
		except(
			select max(male_recordings.durata)
			from male_recordings
		) 		
	


SELECT distinct artist.name as Nome, recording.name as Nome_registrazione, recording.length as durata 
from artist 
join gender on artist.gender = gender.id
join artist_credit_name on artist_credit_name.artist = artist.id
join artist_credit on artist_credit_name.artist_credit = artist_credit.id
join recording on Artist.ID=recording.id
WHERE recording.length =
(select max(new_male_recordings.durata)
from new_male_recordings
)



/*QUERY 12 
Per ogni stato esistente riportare la lunghezza totale delle registrazioni di artisti di quello stato (il risultato deve comprendere il nome dello stato e la lunghezza totale in minuti delle registrazioni 
(0 se lo stato non ha registrazioni) 
(scrivere due versioni della query; almeno una delle due versioni non deve utilizzare le viste).

In questa query abbiamo analizzato principalmente l'entità area e registrazioni.
Nello specifico in area è stato necessario controllare il tipo di area, siccome ci interessano i 'Country' ed il nome dell'area.
In registrazioni abbiamo invece preso la somma delle registrazioni di quell'area con group by il nome dell'area.
Abbiamo quindi fatto join da area a registrazioni passando per artista.
La parte più complessa è stata mettere a 0 i paesi che hanno somma null.
Abbiamo deciso di mettere come sottoquery tutti i passi spiegati in precedenza e come query principale abbiamo selezionato i dati richiesti ( nome stato ) più 
COALESCE( NULLIF(recordings_sum.somma_registrazioni,null) , '0' ). Innanzitutto la nullif riturna null se il suo primo attributo vale il secondo, in questo caso se somma_registrazioni vale 0, altrimenti ritorna la somma.
Con coalesce se il primo valore vale null lo setto a 0, in questa caso se il valore ritornato dalla nullif vale null esso setta a 0 l'intera operazione.
Questo ci permette di avere a 0 i paesi con somma 0 anziche null.
La versione con vista è identica ma crea una vista con le somme delle registrazioni.
Come controllo si potrebbe controllare uno per volta tutte le registrazioni e sommarle.
*/


/* SENZA VISTA */	
select recordings_sum.nome_stato, COALESCE( NULLIF(recordings_sum.somma_registrazioni,null) , '0' ) as somma_registrazioni from(
	select  distinct area.name as nome_stato, sum(recording.length) as somma_registrazioni
	from area
	join area_type on area.type=area_type.id
	left join artist on artist.area=area.id
	left join artist_credit_name on artist_credit_name.artist = artist.id
	left join artist_credit on artist_credit_name.artist_credit = artist_credit.id
	left join recording on Artist.ID=recording.id
	where area_type.name='Country'
	group by area.name) as recordings_sum
group by recordings_sum.nome_stato, recordings_sum.somma_registrazioni



	
/*CON VISTA */
create view recordings_sum as
select  distinct area.name as nome_stato, sum(recording.length) as somma_registrazioni
	from area
	join area_type on area.type=area_type.id
	left join artist on artist.area=area.id
	left join artist_credit_name on artist_credit_name.artist = artist.id
	left join artist_credit on artist_credit_name.artist_credit = artist_credit.id
	left join recording on Artist.ID=recording.id
	where area_type.name='Country'
	group by area.name
	
	

select recordings_sum.nome_stato, COALESCE( NULLIF(recordings_sum.somma_registrazioni,null) , '0' ) as somma_registrazioni 
from recordings_sum
	
group by recordings_sum.nome_stato, recordings_sum.somma_registrazioni

/*CONTROLLO, seleziona tutti i paesi esistenti
*/
select distinct area.name
from area
	join area_type on area.type=area_type.id
	where area_type.name='Country'
	

/*QUERY 13 
Ricavare gli artisti britannici che hanno pubblicato almeno 10 release 
(il risultato deve contenere il nome dell’artista, il nome dello stato (cioè United Kingdom) e il numero di release) 
(scrivere due versioni della query; almeno una delle due versioni non deve utilizzare le viste).

In questa query abbiamo analizzato principalmente l'entità artist e release.
Abbiamo fatto join tra loro passando come sempre per artist_credit e artist_credit_name.
Abbiamo avuto bisogno anche dell'entità area in quanto dobbiamo vedere chi sono gli artisti britannici.
Abbiamo quindi fatto un join anche con l'entità area.
Per contare le release abbiamo semplicemente usato il count con group by nome artista.
Tutto questo è stato messo in una sottoquery dalla quale abbiamo preso in seguito solamente gli artisti con num release>10
La versione con vista usa la stessa tecnica ma abbiamo messo in una vista tutti gli artisti dell'uk, dalla quale poi abbiamo preso quelli con num release>10
Come controllo si potrebbe controllare uno per volta tutte le release di un determinato artista ma ci pare esagerato.
*/

/*SENZA VISTA */
select all_artist_uk.nome_artista, all_artist_uk.nome_stato, all_artist_uk.num_release
from(
	select distinct artist.name as nome_artista,area.name as nome_stato, count(release.name) as num_release
	from artist
	join area on artist.area=area.id
	join artist_credit_name on artist_credit_name.artist = artist.id
	join artist_credit on artist_credit_name.artist_credit = artist_credit.id
	join release on artist_credit.id=release.artist_credit
	where area.name='United Kingdom'
	group by artist.name, area.name) as all_artist_uk
where all_artist_uk.num_release >10

/*CON VISTA */
create view all_artist_uk as
select distinct artist.name as nome_artista,area.name as nome_stato, count(release.name) as num_release
	from artist
	join area on artist.area=area.id
	join artist_credit_name on artist_credit_name.artist = artist.id
	join artist_credit on artist_credit_name.artist_credit = artist_credit.id
	join release on artist_credit.id=release.artist_credit
	where area.name='United Kingdom'
	group by artist.name, area.name
	
select all_artist_uk.nome_artista, all_artist_uk.nome_stato, all_artist_uk.num_release
from all_artist_uk
where all_artist_uk.num_release >10
/*QUERY 14
Considerando il numero medio di tracce tra le release pubblicate su CD, ricavare gli artisti che hanno pubblicato esclusivamente release con più tracce della media 
(il risultato deve contenere il nome dell’artista e il numero di release ed essere ordinato per numero di release discendente) 
(scrivere due versioni della query; almeno una delle due versioni non deve utilizzare le viste).

In questa query siamo andati a controllare le entità arist_credit, medium e release.
Abbiamo fatto il join tra artist_Credit, medium e release  dalle quali ci interessano rispettivamente il nome dell'artista, il track_count e il nome_release
Oltre a questi join, abbiamo analizzatto innanzitutto una sottoquery che abbiamo chiamato media_traccie che ci restituisce appunto la media di traccie per release.
Grazie a questa possiamo tornare nella nostra query principale e prendere i dati richiesti solamente delle release con track_count > media_traccie.media
La versione senza vista è uguale solo che la sottoquery per la media di traccie è inserita in una vista.
*/

/*SENZA VISTA */


select distinct artist_credit.name as nome_artista, medium.track_count
from (select avg(medium.track_count) as media
	from medium 
	join medium_format on medium.format=medium_format.id
	where medium_format.name='CD'
	group by medium_format
	) as media_traccie,
	release
join artist_credit on release.artist_credit=artist_credit.id
join medium on medium.release=release.id
where track_count > media_traccie.media
order by medium.track_count desc
	
	/* CON VISTA */
create view
media_traccie as
	select avg(medium.track_count) as media
	from medium 
	join medium_format on medium.format=medium_format.id
	where medium_format.name='CD'
	group by medium_format
	
	
select distinct artist_credit.name as nome_artista, medium.track_count
from media_traccie, release
join artist_credit on release.artist_credit=artist_credit.id
join medium on medium.release=release.id
where track_count > media_traccie.media
order by medium.track_count desc	

/*Controllo */
select distinct release.name, medium.track_count from release 
join medium on medium.release=release.id
where release.name='Broken'

/*QUERY 15
Ricavare il primo artista morto dopo Louis Armstrong 
(il risultato deve contenere il nome dell’artista, la sua data di nascita e la sua data di morte) 
(scrivere due versioni della query; almeno una delle due versioni non deve utilizzare le viste).

In questa query abbiamo analizzato principalmente l'entità artista.
E' stato necessario usare diverse sottoquery siccome sono sorti diversi sottoproblemi.
Il primo era torvare inannzitutto trovare la data di morte di Lousi armstrong.
In seguito abbiamo selezionato solamente le persone che hanno data di morte > della sua. Questa sottoquery si chiama dopo_louis
Una volta trovato questo elenco dovevamo selezionare quello con la data più vicina.
Questo è stato il problema più grande in quanto ovviamente non è possibilef are il min di 3 attributi diversi.
Abbiamo quindi pensato inizialmente di sommare i valori della data di ognuno e selezionare la somma più piccola.
Avrebbe funzionato se non fosse che la somma poteva dare problemi con quelli morti prima e dopo il 2000 ( Es. 1999+12+31= 2042, 2001+1+1 = 2003 il primo è morto prima pur avendo somma maggiore).
Abbiamo quindi pensato di sommare a anno e mese dei valori abbastanza grandi da evitare questi problemi come 10000 e 100, e come metodo funziona.
Abbiamo quindi nella query princiapel i dati dell'artista che ha come data di morte quella min.
La versione con vista funziona in maniera identica ma mette in una vista la sottoquery dopo_louis.
Per fare il controllo usiamo la sottoquery dopo_louis con limit a 1.
*/

/*SENZA VISTA*/
select artist.name AS artista, (begin_date_year, begin_date_month, begin_date_day) as birth, (end_date_year, end_date_month, end_date_day) as death   
from artist   
join artist_type on  artist.type = artist_type.id   
where artist_type.name ='Person' and ((end_date_year * 10000) + (end_date_month * 100) + (end_date_day)) =   (
	select min(morte)       
	from (          
		select artista, morte	
		from(               
			select artist.name as artista, ((end_date_year * 10000) + (end_date_month * 100) + (end_date_day)) as morte
			from artist               
			join artist_type on artist.type = artist_type.id              
			where artist_type.name ='Person'
			) as morto_dopo          
		where morto_dopo.morte >(              
			select ((end_date_year * 10000) + (end_date_month * 100) + (end_date_day))
			from artist               
			where name = 'Louis Armstrong' 
		)       
	) as dopo_louis  
)
	
/*CON VISTA*/
create view
morto_dopo as
select artista, morte	
	from(               
		select artist.name as artista, ((end_date_year * 10000) + (end_date_month * 100) + (end_date_day)) as morte
		from artist               
		join artist_type on artist.type = artist_type.id              
		where artist_type.name ='Person'
		) as morto_dopo          
	where morto_dopo.morte >(              
		select ((end_date_year * 10000) + (end_date_month * 100) + (end_date_day))
		from artist               
		where name = 'Louis Armstrong' 
	)
		
		
select artist.name AS artista, (begin_date_year, begin_date_month, begin_date_day) as birth, (end_date_year, end_date_month, end_date_day) as death   
from artist   
join artist_type on  artist.type = artist_type.id   
where artist_type.name ='Person' and ((end_date_year * 10000) + (end_date_month * 100) + (end_date_day)) =   (
	select min(morte)       
	from morto_dopo
	)
	
	/* controllo */ 
	select artista, morte	
		from(               
			select artist.name as artista, ((end_date_year * 10000) + (end_date_month * 100) + (end_date_day)) as morte
			from artist               
			join artist_type on artist.type = artist_type.id              
			where artist_type.name ='Person'
			) as morto_dopo          
		where morto_dopo.morte >(              
			select ((end_date_year * 10000) + (end_date_month * 100) + (end_date_day))
			from artist               
			where name = 'Louis Armstrong' 
		)       
		order by morte limit 1