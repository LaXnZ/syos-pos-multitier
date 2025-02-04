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
<html>
<head>
    <title>SYOS Client</title>
</head>
<body>
<h2>SYOS Client</h2>

<%
    try {
        URL url = new URL("http://localhost:8080/SYOS-Server/api/hello");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        int responseCode = conn.getResponseCode();
        if (responseCode == 200) {
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String serverResponse = reader.readLine();
            reader.close();

            response.getWriter().println("<p>✅ Server Response: " + serverResponse + "</p>");
        } else {
            response.getWriter().println("<p>❌ Server returned HTTP error: " + responseCode + "</p>");
        }
    } catch (Exception e) {
        response.getWriter().println("<p>❌ Error fetching data: " + e.getMessage() + "</p>");
    }
%>

</body>
</html>
