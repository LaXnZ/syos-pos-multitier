<%--
  Created by IntelliJ IDEA.
  User: sumuditha
  Date: 2025-02-07
  Time: 23:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    session.invalidate();
    response.sendRedirect("login.jsp");
%>
<script>
    sessionStorage.clear();
</script>

