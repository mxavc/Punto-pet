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
<body style="display: flex; justify-content: center; align-items: center; min-height: 100vh;">
<div class="form-container glass-panel" style="width: 100%; margin: 0; box-sizing: border-box;">
    <h2 class="main-title" style="font-size: 2.5rem; margin-bottom: 30px;">Punto-pet 🐾</h2>

    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>

    <form action="/login" method="POST">
        <div class="form-section" style="border: none; padding: 0;">
            <label>Usuario</label>
            <input type="text" name="username" required placeholder="Ej: demouser" />

            <label>Contraseña</label>
            <input type="password" name="password" required placeholder="Ej: demopass" />
        </div>
        <button type="submit">Ingresar a la Plataforma</button>
    </form>
</div>
</body>
</html>
