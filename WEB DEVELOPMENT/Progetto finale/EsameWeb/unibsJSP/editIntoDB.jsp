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
        String id = request.getParameter("id");
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
            querySelect="UPDATE dvd SET `regista` ='"+regista+"', `titolo` ='"+name+"', `anno_uscita` ='"+yearRelease+"', `prezzo` ='"+price+"', `num_prod` ='"+numProd+"', `foto` ='"+foto+"', `spedizione` ='"+spedizione+"', `genere` ='"+genere+"', `descrizione` ='"+descrizione+"' where id='"+id+"'";
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
            
            querySelect="UPDATE libro SET `autore` ='"+autore+"', `titolo` ='"+name+"', `editore` ='"+editore+"', `isbn` ='"+isbn+"', `anno_uscita` ='"+yearRelease+"', `pagine` ='"+pagine+"', `prezzo` ='"+price+"', `num_prod` ='"+numProd+"', `foto` ='"+foto+"', `spedizione` ='"+spedizione+"', `genere` ='"+genere+"', `descrizione` ='"+descrizione+"' where id='"+id+"'";
        
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

            querySelect="UPDATE musica SET `autore` ='"+autore+"', `titolo` ='"+name+"', `anno_uscita` ='"+yearRelease+"', `prezzo` ='"+price+"', `num_prod` ='"+numProd+"', `foto` ='"+foto+"', `spedizione` ='"+spedizione+"', `descrizione` ='"+descrizione+"' where id='"+id+"'";
        
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
            //Dopo aver modificato l'item rimando l'admin alla pagina
            String redirectURL="";
            if(request.getParameter("numProd").equals("0")){
                redirectURL = "http://localhost:8000/item.php?categoria="+categoria+"&id="+id;   
            }else{
                redirectURL = "http://localhost:8000/managePreorder.php?categoria="+categoria+"&id="+id;
            }response.sendRedirect(redirectURL);
            
        }
        catch(Exception ex)
        {
           out.println("Errore durante aggiunto film: "+ex.toString()); 
        }
   
    conn.close();
%>