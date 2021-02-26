<html>
<head>
<title>Aggiungi prodotto</title>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.1/jquery.validate.min.js"></script>
    <script src="form-validator.js"></script>
</head>
<body>
 <style type="text/css">
<!--
.Stile1 {
	color: #0000FF;
	font-style: italic;
	font-weight: bold;
}
-->
</style>
<body>
<h1 align='center'><span class="Stile1">Modifica l'articolo</span></h1><br />
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
        //preparo query per recupero item
        String categoria = request.getParameter("categoria");
        String id = request.getParameter("id");
        String querySelect ="SELECT * FROM "+ categoria +" where id ='"+ id + "'";
        //Recupero item
        try
        {
        Class.forName(driver).newInstance();
        connectionUrl=connectionString+url+port+"/"+dbname;	
		conn = DriverManager.getConnection(connectionUrl, userdb, pwd);
        Statement statement= conn.createStatement();
        //Eseguo la query 
        ResultSet rs= statement.executeQuery(querySelect);
        //in base al tipo di dato carico valori diversi
        while (rs.next()){
            //Sto praticamente riusando il codice dell'aggiungi item
            if(categoria.equals("dvd")){
                %>
                <div>
                    <form class="item" action="editIntoDB.jsp" method="post">

                        <input name="categoria" type="hidden" value="dvd">
                        <input name="id" type="hidden" value="<%  out.println(rs.getString("id")); %>">
                        <ul>
                            <li>
                                <label for="name">Nome Dvd : </label>
                                <input type="text" name="name" maxlength="30" value="<%  out.println(rs.getString("titolo")); %>">
                            </li>
                            <li>
                                <label for="regista">Regista : </label>
                                <input type="text" name="regista" maxlength="50" value="<%  out.println(rs.getString("regista")); %>">
                            </li>
                            <li>
                                <label for="yearRelease">Anno uscita : </label>
                                <input type="number" name="yearRelease" min="1900" max="2025"  value="<%  out.println(rs.getString("anno_uscita")); %>" required >
                            </li>
                            <li>
                                <label for="price">Prezzo : </label>
                                <input type="number" name="price" step="0.01" min="0" max="100" value="<%  out.println(rs.getString("prezzo")); %>"  required>

                            </li>
                            <li>
                                <label for="numProd">Quantità disponibile : </label>
                                <input type="number" name="numProd" min="0" max="1000" value="<%  out.println(rs.getString("num_prod")); %>" required>
                            </li>
                            <li>
                                <label for="foto">Copertina ( usare bitly ) : </label>
                                <input type="text" name="foto" maxlength="30" value="<%  out.println(rs.getString("foto")); %>" required>
                            </li>
                            <li>
                                <label for="spedizione">Spedizione : </label>
                                <select name="spedizione">
                                    <option value="1" selected='selected'> Posta Prioritaria ( 7 gg - 5 euro )</option>
                                    <option value="2"> Corriere ( 2gg - 10 euro )</option>
                                </select>
                            </li>
                            <li><label for="genere">Genere : </label>
                                <select name="genere">
                                    <option value="1" selected='selected'> Fantasy</option>
                                    <option value="2">Horror</option>
                                    <option value="3">Fantascienza</option>
                                    <option value="4">Drama</option>
                                    <option value="5">Avventura</option>
                                    <option value="6">Azione</option>
                                    <option value="7">Biografico</option>
                                    <option value="8">Commedia</option>
                                    <option value="9">Bambini</option>
                                </select>
                            </li>
                            <li>
                                <label for="descrizione">Descrizione : </label>
                                <input type="text" name="descrizione" maxlength="500" value="<%  out.println(rs.getString("descrizione")); %>" required>
                            </li>
                          
                        </ul>

                        <input id="addItem" type="submit" value="Modifica Articolo">   
                    </form>
                </div>
                
                <%
            }else if (categoria.equals("libro")){
                %>
                <div>
                    <form class="item" action="editIntoDB.jsp" method="post">

                        <input name="categoria" type="hidden" value="libro">
                        <input name="id" type="hidden" value="<%  out.println(rs.getString("id")); %>">
                        <ul>
                            <li>
                                <label for="name">Nome Libro : </label>
                                <input type="text" name="name" maxlength="30" value="<%  out.println(rs.getString("titolo")); %>">
                            </li>
                            <li>
                                <label for="autore">Autore : </label>
                                <input type="text" name="autore" maxlength="50" value="<%  out.println(rs.getString("autore")); %>">
                            </li>
                            <li>
                                <label for="editore">Editore : </label>
                                <input type="text" name="editore" maxlength="20" value="<%  out.println(rs.getString("editore")); %>" required>
                            </li>
                            <li>
                                <label for="isbn">ISBN : </label>
                                <input type="text" name="isbn" minlength="13" maxlength="13" value="<%  out.println(rs.getString("isbn")); %>" required>
                            </li>
                            <li>
                                <label for="yearRelease">Anno uscita : </label>
                                <input type="number" name="yearRelease" min="1900" max="2025" value="<%  out.println(rs.getString("anno_uscita")); %>" required>
                            </li>
                            <li>
                                <label for="pagine">Pagine : </label>
                                <input type="number" name="pagine" min="1" max="3000" value="<%  out.println(rs.getString("pagine")); %>" required>
                            </li>
                            <li>
                                <label for="price">Prezzo : </label>
                                <input type="number" name="price" step="0.01" min="0" max="100" value="<%  out.println(rs.getString("prezzo")); %>" required>

                            </li>
                            <li>
                                <label for="numProd">Quantità disponibile : </label>
                                <input type="number" name="numProd" min="0" max="1000" value="<%  out.println(rs.getString("num_prod")); %>" required>
                            </li>
                            <li>
                                <label for="foto">Copertina ( usare bitly ) : </label>
                                <input type="text" name="foto" maxlength="30"  value="<%  out.println(rs.getString("foto")); %>" required>
                            </li>
                            <li>
                                <label for="spedizione">Spedizione : </label>
                                <select name="spedizione">
                                    <option value="1" selected='selected'> Posta Prioritaria ( 7 gg - 5 euro )</option>
                                    <option value="2"> Corriere ( 2gg - 10 euro)</option>
                                </select>
                            </li>
                            <li><label for="genere">Genere : </label>
                                <select name="genere">
                                    <option value="1" selected='selected'> Fantasy</option>
                                    <option value="2">Horror</option>
                                    <option value="3">Fantascienza</option>
                                    <option value="4">Drama</option>
                                    <option value="5">Avventura</option>
                                    <option value="6">Azione</option>
                                    <option value="7">Biografico</option>
                                    <option value="8">Commedia</option>
                                    <option value="9">Bambini</option>
                                </select>
                            </li>
                            <li>
                                <label for="descrizione">Descrizione : </label>
                                <input type="text" name="descrizione" maxlength="500" value="<%  out.println(rs.getString("descrizione")); %>" required>
                            </li>
                        </ul>

                        <input id="addItem" type="submit" value="Modifica Articolo">   
                    </form>
                </div>                
                <%
            }else if(categoria.equals("musica")){
                %>
                <div>
                    <form class="item" action="editIntoDB.jsp" method="post">

                            <input name="categoria" type="hidden" value="musica">
                            <input name="id" type="hidden" value="<%  out.println(rs.getString("id")); %>">
                        <ul>
                            <li>
                                <label for="name">Nome Album : </label>
                                <input type="text" name="name" maxlength="30" value="<%  out.println(rs.getString("titolo")); %>">
                            </li>
                            <li>
                                <label for="autore">Autore : </label>
                                <input type="text" name="autore" maxlength="50" value="<%  out.println(rs.getString("autore")); %>">
                            </li>
                            <li>
                                <label for="yearRelease">Anno uscita : </label>
                                <input type="number" name="yearRelease" min="1900" max="2025" value="<%  out.println(rs.getString("anno_uscita")); %>" required>
                            </li>
                            <li>
                                <label for="price">Prezzo : </label>
                                <input type="number" name="price" step="0.01" min="0" max="100" value="<%  out.println(rs.getString("prezzo")); %>" required>
                            </li>
                            <li>
                                <label for="numProd">Quantità disponibile : </label>
                                <input type="number" name="numProd" min="0" max="1000" value="<%  out.println(rs.getString("num_prod")); %>" required>
                            </li>
                            <li>
                                <label for="foto">Copertina ( usare bitly ) : </label>
                                <input type="text" name="foto" maxlength="30" value="<%  out.println(rs.getString("foto")); %>" required>
                            </li>
                            <li>
                                <label for="spedizione">Spedizione : </label>
                                <select name="spedizione">
                                    <option value="1" selected='selected'> Posta Prioritaria ( 7 gg - 5€ )</option>
                                    <option value="2"> Corriere ( 2gg - 10€ )</option>
                                </select>
                            </li>
                            <li>
                                <label for="descrizione">Descrizione : </label>
                                <input type="text" name="descrizione" maxlength="500" value="<%  out.println(rs.getString("descrizione")); %>" required>
                            </li>
                        </ul>
                        <input id="addItem" type="submit" value="Modifica Articolo">   
                    </form>
                </div>                
                
                
                <%
            }
        }
        //infine eseguo query di aggiornamento
    }catch(Exception ex){
           out.println("Errore durante modifica item: "+ex.toString()); 
    }
    

%>
</body>
</html>
