<%--
  Created by IntelliJ IDEA.
  User: sumuditha
  Date: 2025-02-07
  Time: 23:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - SYOS</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/styles/styles.css">
    <script>
        async function loginUser(event) {
            event.preventDefault(); // Prevent form submission

            const email = document.getElementById("email").value;
            const password = document.getElementById("password").value;

            const response = await fetch("http://localhost:8080/SYOS-Server/api/auth/login", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ email, password })
            });

            const result = await response.json();
            if (response.ok) {
                sessionStorage.setItem("token", result.token);  // Store JWT token
                sessionStorage.setItem("role", result.role);    // Store user role

                if (result.role === "ADMIN") {
                    window.location.href = "admin-dashboard.jsp";
                } else {
                    window.location.href = "customer-dashboard.jsp";
                }
            } else {
                document.getElementById("error-message").innerText = result.error;
            }
        }
    </script>
</head>
<body>
<div class="container">
    <h2>Login</h2>
    <form onsubmit="loginUser(event)">
        <label>Email:</label>
        <input type="email" id="email" required>

        <label>Password:</label>
        <input type="password" id="password" required>

        <button type="submit">Login</button>
        <p id="error-message" style="color: red;"></p>
    </form>
    <p>Don't have an account? <a href="register.jsp">Register here</a></p>
</div>
</body>
</html>



