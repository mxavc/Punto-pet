<%--
  Created by IntelliJ IDEA.
  User: max_i
  Date: 20/5/2026
  Time: 19:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Punto-pet | Iniciar Sesión</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
<div class="form-container" style="max-width: 400px; margin-top: 100px;">
    <h2 style="text-align: center;">Punto-pet 🐾</h2>

    <c:if test="${not empty error}">
        <div class="error-message" style="text-align: center; margin-bottom:15px;">${error}</div>
    </c:if>

    <form action="/login" method="POST">
        <label>Usuario:</label>
        <input type="text" name="username" required placeholder="Ej: demouser" />

        <label>Contraseña:</label>
        <input type="password" name="password" required placeholder="Ej: demopass" />

        <button type="submit">Ingresar</button>
    </form>
</div>
</body>
</html>
