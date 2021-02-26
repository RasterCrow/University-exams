<%@ page import="java.sql.*" import="javax.sql.*" import="java.io.*" import="java.util.*" import="java.lang.*" import="java.security.MessageDigest" %>	<!--Importazioni dei Package senza il quale attraverso le JSP non potremo eseguire comandi SQL.-->
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.ResultSetMetaData"%>
<%@ page import="javax.servlet.ServletException"%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page session="true" %>

<%
    /* Dati per la connessione al database */
        String driver="com.mysql.jdbc.Driver";
        String connectionString="jdbc:mysql://";
        String url="localhost:";
        String port="3306";
        String dbname="unibs";          
        String userdb="alex";
        String pwd="alexalex97";
        String connectionUrl;
        Connection conn=null;
        String codAct="";
        String querySelect="";
        

        String categoria = request.getParameter("categoria");
        if(categoria.equals("dvd")){
            String name = request.getParameter("name");
            String regista = request.getParameter("regista");
            String yearRelease = request.getParameter("yearRelease");
            String price = request.getParameter("price");
            String numProd = request.getParameter("numProd");
            String foto = request.getParameter("foto");
            String spedizione = request.getParameter("spedizione");
            String genere = request.getParameter("genere");
            String descrizione = request.getParameter("descrizione");

        
            //Preparo la quesy principale
            querySelect="INSERT INTO `dvd` (`regista`, `titolo`, `anno_uscita`, `prezzo`, `num_prod`, `foto`, `spedizione`, `genere`, `descrizione`) VALUES ('"+regista+" ','"+name+" ', '"+yearRelease+" ', '"+price+" ' , '"+numProd+" ', '"+foto+" ', '"+spedizione+" ', '"+genere+" ', '"+descrizione+" ' )";
        }else if(categoria.equals("libro")){
            String name = request.getParameter("name");
            String autore = request.getParameter("autore");
            String editore = request.getParameter("editore");
            String isbn = request.getParameter("isbn");
            String yearRelease = request.getParameter("yearRelease");
            String pagine = request.getParameter("pagine");
            String price = request.getParameter("price");
            String numProd = request.getParameter("numProd");
            String foto = request.getParameter("foto");
            String spedizione = request.getParameter("spedizione");
            String genere = request.getParameter("genere");
            String descrizione = request.getParameter("descrizione");
            
           querySelect="INSERT INTO `libro` (`autore`, `titolo`, `editore`, `isbn`, `anno_uscita`, `pagine`, `prezzo`, `num_prod`, `foto`, `spedizione`, `genere`, `descrizione`) VALUES ('"+autore+" ','"+name+" ','"+editore+" ','"+isbn+" ', '"+yearRelease+" ','"+pagine+" ', '"+price+" ' , '"+numProd+" ', '"+foto+" ', '"+spedizione+" ', '"+genere+" ', '"+descrizione+" ' )";
        
        }else if(categoria.equals("musica")){
            String name = request.getParameter("name");
            String autore = request.getParameter("autore");
            String yearRelease = request.getParameter("yearRelease");
            String disco = request.getParameter("disco");
            String price = request.getParameter("price");
            String numProd = request.getParameter("numProd");
            String foto = request.getParameter("foto");
            String spedizione = request.getParameter("spedizione");
            String descrizione = request.getParameter("descrizione");

            querySelect="INSERT INTO `musica` (`autore`, `titolo`, `anno_uscita`, `" + disco +"`, `prezzo`, `num_prod`, `foto`, `spedizione`, `descrizione`) VALUES ('"+autore+" ','"+name+" ', '"+yearRelease+" ', '1', '"+price+" ' , '"+numProd+" ', '"+foto+" ', '"+spedizione+" ', '"+descrizione+" ' )";
        
        }
        try
        {
            Class.forName(driver).newInstance();
            connectionUrl=connectionString+url+port+"/"+dbname;
			
			conn = DriverManager.getConnection(connectionUrl, userdb, pwd);
			//conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/imdb_small",userdb, pwd);
			Statement statement= conn.createStatement();
            /*Eseguo la query di selezione  */
            statement.executeUpdate(querySelect);
            //Recupero id dell'item appena aggiunto 
            String queryGetID = "SELECT * from "+categoria+" order by id desc limit 1";
            ResultSet rs= statement.executeQuery(queryGetID);
            String id="";
             while (rs.next())
            {
                id = rs.getString("id");
            }
            //Dopo aver aggiunto l'item devo aggiungere attori/canzoni
            if(categoria.equals("dvd")){
            //inserisco gli attori aggiunti
                for(int i =1;i<=6;i++){
                    if(request.getParameter("attore"+i+"nome")!= ""){
                            statement.executeUpdate("INSERT INTO `attori` (`nome`, `cognome`,`film`) VALUES ('"+request.getParameter("attore"+i+"nome")+" ','"+request.getParameter("attore"+i+"cognome")+" ','" + id +"' )");
                    }
                }
            }else if(categoria.equals("musica")){
            //inserisco le canzoni aggiunte
                for(int i =1;i<=6;i++){
                    if(request.getParameter("canzone"+i+"titolo")!= ""){
                            statement.executeUpdate("INSERT INTO `canzone` (`titolo`, `durata`,`album`) VALUES ('"+request.getParameter("canzone"+i+"titolo")+" ','"+request.getParameter("canzone"+i+"durata")+" ','" + id +"' )");
                    }
                }
            }
            String redirectURL = "http://localhost:8000/item.php?categoria="+categoria+"&id="+id;
            response.sendRedirect(redirectURL);
            
        }
        catch(Exception ex)
        {
           out.println("Errore durante aggiunto film: "+ex.toString()); 
        }
   
    conn.close();
%>