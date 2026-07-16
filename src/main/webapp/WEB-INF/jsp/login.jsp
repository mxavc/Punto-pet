<%--
  Created by IntelliJ IDEA.
  User: max_i
  Date: 20/5/2026
  Time: 19:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="es">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Punto-pet | Iniciar Sesión</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body style="display: flex; justify-content: center; align-items: center; min-height: 100vh;">
<div class="form-container glass-panel" style="width: 100%; margin: 0; box-sizing: border-box;">
    <h2 class="main-title" style="font-size: 2.5rem; margin-bottom: 30px;">Punto-pet 🐾</h2>

    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>

    <c:if test="${not empty mensajeExito}">
        <div class="success-message">${mensajeExito}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="POST">
        <div class="form-section" style="border: none; padding: 0;">
            <label for="username">Correo Electrónico</label>
            <input type="email" id="username" name="username" required placeholder="Ej: demo@correo.com" />

            <label for="password">Contraseña</label>
            <input type="password" id="password" name="password" required placeholder="Ej: demopass" />
        </div>
        <button type="submit">Ingresar a la Plataforma</button>
    </form>
    
    <div style="text-align: center; margin-top: 30px;">
        <span style="color: var(--text-muted); font-size: 1rem;"><u>¿No tienes una cuenta?</u></span><br>
        <a href="${pageContext.request.contextPath}/registro" class="btn-nav" style="display: inline-block; margin-top: 15px; padding: 12px 25px; background: linear-gradient(135deg, #20E3B2, #00B4D8); color: white;">Registrate!</a>
    </div>
</div>
</body>
</html>
