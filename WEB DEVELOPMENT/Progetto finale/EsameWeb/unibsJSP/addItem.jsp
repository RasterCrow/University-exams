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
<h1 align='center'><span class="Stile1">Aggiungi un articolo</span></h1><br />
<%@ page import="java.sql.*" import="javax.sql.*" import="java.io.*" import="java.util.*" import="java.lang.*" import="java.security.MessageDigest" %>	<!--Importazioni dei Package senza il quale attraverso le JSP non potremo eseguire comandi SQL.-->

<!-- form per selezionare categoria dell'item
Non sono riuscito ad aggiungerlo via ajax, quindi ho dovuto risolvere con form e get -->

<form action = "addItem.jsp" method = "get">
<select name="categoria">
                <option value="Dvd" selected='selected'>Dvd</option>
                <option value="Libro"> Libro </option>
                <option value="Musica"> Musica </option>
</select>
<input id="addItem" type="submit" value="Seleziona categoria">    
</form>

<%
    if(request.getParameter("categoria")==null){
        %> <jsp:include page = "itemDvd.html" flush = "true" /> <%
    }else{
        String categoria = request.getParameter("categoria");
        if(categoria.equals("Dvd")){
            %> <jsp:include page = "itemDvd.html" flush = "true" /> <%
        }else if (categoria.equals("Libro")){
            %> <jsp:include page = "itemLibro.html" flush = "true" /> <%
        }else if(categoria.equals("Musica")){
            %> <jsp:include page = "itemMusica.html" flush = "true" /> <%
        }
    }
%>
</body>
</html>
