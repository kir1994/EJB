<%-- 
    Document   : addTask
    Created on : Dec 16, 2016, 12:52:00 AM
    Author     : Ki3iLL
--%>

<%@page import="dcn.ivanov.WorkplaceSessionBeanRemote"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create new task</title>
    </head>
    <body>
        <script src="cookie.js"></script>
        <%!
        WorkplaceSessionBeanRemote ejbRef;
        %>
        <%
        InitialContext ic = new InitialContext();
        ejbRef = (WorkplaceSessionBeanRemote)ic.lookup("dcn.ivanov.WorkplaceSessionBeanRemote");
        String ssid = (String)session.getAttribute("SSID");        
        Object obj = ejbRef.getAccount(ssid);
        if (obj == null) {
            throw new Exception("Not authorized");
        }
        String descr = request.getParameter("description");
        String s = "";
        if (descr != null) {
            ejbRef.createTask(descr);
            s = "Task successfully added";
        }
        %>
        <form action="addTask.jsp" method="POST">
        <p><textarea name="description">Insert task description here</textarea> </p>
        <input type="submit" value="Submit" />
        </form>
        <p><%= s %></p>
        <form action="main.jsp" method="POST">
        <input type="submit" value="Return" />
        </form>
    </body>
</html>
