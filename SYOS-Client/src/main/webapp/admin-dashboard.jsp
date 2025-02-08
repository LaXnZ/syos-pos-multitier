<%--
  Created by IntelliJ IDEA.
  User: sumuditha
  Date: 2025-02-07
  Time: 23:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession sessionObj = request.getSession(false);
    String role = (sessionObj != null) ? (String) sessionObj.getAttribute("role") : null;
    String name = (sessionObj != null) ? (String) sessionObj.getAttribute("user") : "Guest";

    if (role == null) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/styles/styles.css">

    <script>
        function checkTokenExpiration() {
            const tokenExpiration = sessionStorage.getItem("tokenExpiration");
            if (tokenExpiration && new Date().getTime() > tokenExpiration) {
                sessionStorage.clear();
                window.location.href = "login.jsp";
            }
        }
        setInterval(checkTokenExpiration, 60000); // Check every minute
    </script>
</head>
<body>
<div class="container">
    <header>
        <h2>Welcome, <%= name %> </h2>
        <p>Role: <%= role %></p>
        <a href="logout.jsp">Logout</a>
    </header>

    <nav>
        <ul>
            <li><a href="manage-items.jsp">Manage Items</a></li>
            <li><a href="manage-customers.jsp">Manage Customers</a></li>
            <li><a href="manage-stock.jsp">Manage Stock</a></li>
            <li><a href="manage-reports.jsp">Generate Reports</a></li>
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </nav>
</div>
</body>
</html>

