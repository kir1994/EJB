<%-- 
    Document   : login
    Created on : Dec 16, 2016, 12:55:01 AM
    Author     : Ki3iLL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dcn.ivanov.WorkplaceSessionBeanRemote"%>
<%@page import="javax.naming.*" %>
<%@ page errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Distributed workplace: login</title>
    </head>
    <body>
        <%
        InitialContext ic = new InitialContext();
        WorkplaceSessionBeanRemote ejbRef = (WorkplaceSessionBeanRemote)ic.lookup("dcn.ivanov.WorkplaceSessionBeanRemote");
        
        String login = (String)request.getParameter("login");
        String password = (String)request.getParameter("password");
        if (login != null && password != null) {
            String sess = ejbRef.authorize(login, password);
            session.setAttribute("SSID", sess);
            response.sendRedirect("main.jsp");
        }     
        if (request.getParameter("logout") != null) {
            String ssid = (String)session.getAttribute("SSID");
            ejbRef.closeSession(ssid);
            //session.invalidate();
        }
        %>
        <form action="index.jsp" method="POST">
        <p>Login: <input type="text" name="login" value="" /></p>
        <p>Password: <input type="password" name="password" value="" /></p>
        <input type="submit" value="Submit" />
        </form>
    </body>
</html>
