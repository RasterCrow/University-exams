<html>
<head>
<title>Aggiungi prodotto</title>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.1/jquery.validate.min.js"></script>
    <script src="form-validator.js"></script>
</head>
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
<h1 align='center'><span class="Stile1">Modifica un articolo</span></h1><br />
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

<!-- form per selezionare categoria dell'item
Non sono riuscito ad aggiungerlo via ajax, quindi ho dovuto risolvere con form e get -->

<form action = "editItem.jsp" method = "get">
<select name="categoria">
                <option value="dvd" selected='selected'>Dvd</option>
                <option value="libro"> Libro </option>
                <option value="musica"> Musica </option>
</select>
<input id="addItem" type="submit" value="Seleziona categoria">    
</form>

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
        String categoria="";
        if(request.getParameter("categoria")==null){
            categoria = "dvd";   
        }else{
            categoria = request.getParameter("categoria");
        
        }
        String querySelect ="SELECT * FROM "+ categoria +" order by id desc";
        //Recupero item
        try
        {
        Class.forName(driver).newInstance();
        connectionUrl=connectionString+url+port+"/"+dbname;	
		conn = DriverManager.getConnection(connectionUrl, userdb, pwd);
        Statement statement= conn.createStatement();
        //Eseguo la query 
        ResultSet rs= statement.executeQuery(querySelect);
        %>
        <ul id="ListaItemToEdit">
        <%
        //finche ho item, aggiungo alla lista
        while (rs.next()){
            %>
            <li>
                <a href="viewItemToEdit.jsp?id=<%  out.println(rs.getString("id")); %>&categoria=<% out.println(categoria);%>"> ID : <%  out.println(rs.getString("id")); %> </a> <br>Titolo : <% out.println(rs.getString("titolo")); %>
            </li>
            <%
        }
        }catch(Exception ex){
           out.println("Errore durante caricamento lista item: "+ex.toString()); 
        }
%>
</body>
</html>
