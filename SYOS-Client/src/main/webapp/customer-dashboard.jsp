<%--
  Created by IntelliJ IDEA.
  User: sumuditha
  Date: 2025-02-07
  Time: 23:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Dashboard</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/styles/styles.css">

    <script>
        // Redirect if no role is found in session storage
        if (!sessionStorage.getItem("role") || sessionStorage.getItem("role") !== "CUSTOMER") {
            window.location.href = "login.jsp";
        }

        function logout() {
            sessionStorage.clear();
            window.location.href = "login.jsp";
        }
    </script>
</head>
<body>
<div class="container">
    <header>
        <h2>Welcome, <script>document.write(sessionStorage.getItem("name"));</script></h2>
        <p>Role: <script>document.write(sessionStorage.getItem("role"));</script></p>
        <button onclick="logout()">Logout</button>
    </header>
    <nav>
        <ul>
            <li><a href="shop.jsp">Shop</a></li>
            <li><a href="cart.jsp">View Cart</a></li>
            <li><a href="checkout.jsp">Checkout</a></li>
        </ul>
    </nav>
</div>
</body>
</html>


