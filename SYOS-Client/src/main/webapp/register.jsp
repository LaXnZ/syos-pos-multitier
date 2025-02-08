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
    <title>Register - SYOS</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/styles/styles.css">
    <script>
        async function registerUser(event) {
            event.preventDefault(); // Prevent form submission

            const name = document.getElementById("name").value;
            const email = document.getElementById("email").value;
            const password = document.getElementById("password").value;

            const response = await fetch("http://localhost:8080/SYOS-Server/api/auth/register", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ name, email, password })
            });

            const result = await response.json();
            if (response.ok) {
                alert("✅ Registration successful! Redirecting to login.");
                window.location.href = "login.jsp";
            } else {
                document.getElementById("error-message").innerText = result.error;
            }
        }
    </script>
</head>
<body>
<div class="container">
    <h2>Register</h2>
    <form onsubmit="registerUser(event)">
        <label>Name:</label>
        <input type="text" id="name" required>

        <label>Email:</label>
        <input type="email" id="email" required>

        <label>Password:</label>
        <input type="password" id="password" required>

        <button type="submit">Register</button>
        <p id="error-message" style="color: red;"></p>
    </form>
    <p>Already have an account? <a href="login.jsp">Login here</a></p>
</div>
</body>
</html>



