<%--
  Created by IntelliJ IDEA.
  User: sumuditha
  Date: 2025-02-04
  Time: 14:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*, java.net.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SYOS Client</title>
    <!-- Tailwind CSS (CDN) for better styling -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex justify-center items-center h-screen">

<div class="bg-white shadow-md rounded-lg p-6 max-w-md w-full">
    <h2 class="text-2xl font-bold text-gray-800 mb-4 text-center">🛒 SYOS Client</h2>

    <div id="server-response" class="p-4 rounded-lg text-center">
        <p class="text-gray-500">⌛ Fetching data from SYOS Server...</p>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            fetch("http://localhost:8080/SYOS-Server/api/hello")
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`Server returned HTTP error: ${response.status}`);
                    }
                    return response.json();
                })
                .then(data => {
                    document.getElementById("server-response").innerHTML =
                        `<p class="text-green-600 font-semibold text-lg">✅ Server Response: ${data.message}</p>`;
                })
                .catch(error => {
                    document.getElementById("server-response").innerHTML =
                        `<p class="text-red-500 font-semibold text-lg">❌ ${error.message}</p>`;
                });
        });
    </script>
</div>

</body>
</html>

