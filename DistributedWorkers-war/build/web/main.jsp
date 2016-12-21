<%-- 
    Document   : index
    Created on : Dec 15, 2016, 11:28:14 PM
    Author     : Ki3iLL
--%>

<%@page import="dcn.ivanov.Task"%>
<%@page import="java.util.List"%>
<%@page import="dcn.ivanov.Worker"%>
<%@page import="dcn.ivanov.WorkplaceSessionBeanRemote"%>
<%@page import="javax.naming.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Distributed workplace: main</title>
    </head>
    <body>
        <script src="cookie.js"></script>
        <%!
        WorkplaceSessionBeanRemote ejbRef;
        %>
        <%
        InitialContext ic = new InitialContext();
        ejbRef = (WorkplaceSessionBeanRemote)ic.lookup("dcn.ivanov.WorkplaceSessionBeanRemote");
        
        String login, password;
        login = (String)request.getParameter("login");
        password = (String)request.getParameter("password");
        
        if (login != null && password != null) {
            try {
                   ejbRef.authorize(login, password);
               } catch (Exception exc) {
                   throw new Exception("Login/password not found");
            }   
        }
        String ssid = (String)session.getAttribute("SSID");        
        Worker w = (Worker)ejbRef.getAccount(ssid);       
        int id;
        if (w.getRole() == Worker.WORKER) {
            id = w.getId();
        } else {
            String wid = request.getParameter("wid");
            if (wid == null)
                id = Task.FREE_TASK;
            else
                id = Integer.parseInt(wid);
        }
        if (request.getParameter("assignTask") != null) {
            String tid = request.getParameter("tid");
            String wid = request.getParameter("wid");
            String priority = request.getParameter("priority");
            ejbRef.assignTask(Integer.parseInt(tid), Integer.parseInt(wid), Integer.parseInt(priority));
        }
        if (request.getParameter("unassignTask") != null) {
            String tid = request.getParameter("unassignID");
            ejbRef.unassignTask(Integer.parseInt(tid));
        }
        if (request.getParameter("finishTask") != null) {
            String tid = request.getParameter("finishID");
            ejbRef.finishTask(Integer.parseInt(tid));
        }
        if (request.getParameter("deleteTask") != null) {
            String tid = request.getParameter("deleteID");
            ejbRef.removeTask(Integer.parseInt(tid));
        }
        out.println("<h1>Hello, " + (w.getRole() == Worker.MANAGER ? "manager" : "worker" ) + " " + w.getFirstname() + " " + w.getLastname() + "</h1>");
        if (w.getRole() == Worker.MANAGER) {
            out.println("<form action='main.jsp' method='POST'>");
            out.println("<select name='wid'>");
            out.println("<option value='-1'>Free tasks</option>");
            List workersList = ejbRef.getWorkers();
            for (Object o : workersList) {
                Worker worker = (Worker)o;
                if (worker.getRole() == Worker.WORKER)
                    out.println("<option value=" + worker.getId() + ">" + worker.getFirstname() + ' ' + worker.getLastname() + "</option>");
            }            
            out.println("</select>");
            out.println("<input type='submit' value='Choose'/>");
            out.println("</form>");                    
        }
        List tasks = ejbRef.getTasksByWorkerID(id);  
        for(Object o : tasks) {
            Task t = (Task)o;
            out.println("<p>" + t.getDescription() + ", priority: " + t.getPriority() + (t.getFinished() ? "; done" : ""));        
            if (w.getRole() == Worker.MANAGER && id == Task.FREE_TASK) {                  
                List workersList = ejbRef.getWorkers();
        %>  
        <form action="main.jsp" method="POST">
            <input type="hidden" name="assignTask" value="">
            <input type="hidden" name="tid" value=<%= t.getId()%>>
            <select name="wid">         
            <%  
                for (Object ow : workersList) {
                    Worker worker = (Worker)ow;
                    if (worker.getRole() == Worker.WORKER)
                        out.println("<option value=" + worker.getId() + ">" + worker.getFirstname() + ' ' + worker.getLastname() + "</option>");
                }
            %>  
            </select>
            <input type="number" name="priority" />
            <input type="submit" value="Assign" />
        </form>
        <form action="main.jsp" method="POST">
            <input type="hidden" name="deleteTask" value="">
            <input type="hidden" name="deleteID" value=<%= t.getId()%>>
            <input type="submit" value="Delete" />
        </form>
        <%
            } else if (w.getRole() == Worker.MANAGER && id != Task.FREE_TASK) {
                %>  
        <form action="main.jsp" method="POST">
            <input type="hidden" name="unassignTask" value="">
            <input type="hidden" name="unassignID" value=<%= t.getId()%>>
            <input type="submit" value="Unassign" />
        </form>
        <%
            }
        %>  
        <form action="main.jsp" method="POST">
            <input type="hidden" name="finishTask" value="">
            <input type="hidden" name="finishID" value=<%= t.getId()%>>
            <input type="submit" value="Finish" />
        </form>
        </p>
        <%
        }      
        %>      
        <form action="addTask.jsp" method="POST">
            <input type="hidden" name="wid" value=<%= w.getId() %>/>
            <input type="submit" value="addTask" />
        </form>
        <form action="index.jsp" method="POST">
            <input type="hidden" name="logout">
            <input type="submit" value="logout" />
        </form>
    </body>
</html>
