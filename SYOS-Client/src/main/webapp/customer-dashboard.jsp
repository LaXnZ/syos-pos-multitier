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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/styles/customer-dashboard.css">

    <script>
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
<div class="customer-container">
    <header class="customer-navbar">
        <div class="customer-navbar-content">
            <h2>Welcome, <span id="customer-name"></span></h2>
            <p>Role: <span id="customer-role"></span></p>
        </div>
        <button class="logout-btn" onclick="logout()">Logout</button>
    </header>

    <nav>
        <ul>
            <li><a href="shop.jsp">Shop</a></li>
            <li><a href="cart.jsp">View Cart</a></li>
            <li><a href="checkout.jsp">Checkout</a></li>
        </ul>
    </nav>
</div>

<script>
    document.getElementById("customer-name").textContent = sessionStorage.getItem("name") || "Customer";
    document.getElementById("customer-role").textContent = sessionStorage.getItem("role") || "CUSTOMER";
</script>

</body>
</html>


