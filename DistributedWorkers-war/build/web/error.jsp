<%-- 
    Document   : error
    Created on : Dec 16, 2016, 12:52:09 AM
    Author     : Ki3iLL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ouch.. something went wrong</title>
        
    </head>
    <body>
        <h1>There was an error</h1>
        <p style="color: red">${pageContext.errorData.throwable.message}</p>
        <p><a href="index.jsp">Return</a></p>
    </body>
</html>