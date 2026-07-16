<%--
  Created by IntelliJ IDEA.
  User: max_i
  Date: 20/5/2026
  Time: 19:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="es">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Punto-pet | Panel Principal</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
<body>
    <div class="header-container">
        <h1 class="main-title" style="font-size: 3rem; margin-bottom: 20px;">¡Bienvenido a Punto-pet! 🐾</h1>
        <p style="color: var(--text-muted); font-size: 1.2rem;">Hola <strong style="color: var(--secondary);">${usuarioLogeado}</strong>, prepárate para gestionar las conexiones de tus mascotas.</p>
    </div>

    <div class="form-container glass-panel" style="text-align: center; max-width: 800px; padding: 60px;">
        <h2 style="color: #FFF; font-weight: 300; margin-bottom: 40px;">¿Qué deseas hacer hoy?</h2>
        
        <div class="button-group" style="display: flex; flex-direction: column; gap: 20px; align-items: center;">
            <a href="${pageContext.request.contextPath}/mascotas/registro" class="btn-nav" style="max-width: 400px; background: linear-gradient(135deg, #FF3366, #FF6B6B);">➕ Registrar nueva Mascota</a>
            <a href="${pageContext.request.contextPath}/mascotas/mis-mascotas" class="btn-nav" style="max-width: 400px; background: linear-gradient(135deg, #20E3B2, #00B4D8);">📋 Ver Mis Mascotas</a>
            <a href="${pageContext.request.contextPath}/parejas/buscar" class="btn-nav" style="max-width: 400px; background: linear-gradient(135deg, #9D4EDD, #C77DFF);">🔍 Buscar Parejas</a>
            <a href="${pageContext.request.contextPath}/mensajes/mis-mensajes" class="btn-nav" style="max-width: 400px; background: linear-gradient(135deg, #F9C80E, #FF9F1C);">✉️ Mis Mensajes</a>
        </div>

        <div style="margin-top: 40px; text-align: left;">
            <h3 style="color: #FFF; font-size: 1.5rem; margin-bottom: 20px; display: flex; align-items: center; gap: 10px;">
                🔔 Mis Notificaciones 
                <c:if test="${not empty notificaciones}">
                    <span style="background: #FF4B4B; color: white; padding: 2px 10px; border-radius: 20px; font-size: 0.9rem;">${notificaciones.size()} nuevas</span>
                </c:if>
            </h3>
            <div style="background: rgba(0,0,0,0.2); padding: 20px; border-radius: 15px; border: 1px solid rgba(255,255,255,0.05);">
                <c:choose>
                    <c:when test="${not empty notificaciones}">
                        <ul style="list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 15px;">
                            <c:forEach var="notif" items="${notificaciones}">
                                <li style="display: flex; justify-content: space-between; align-items: center; background: rgba(32, 227, 178, 0.1); padding: 15px; border-radius: 10px; border-left: 4px solid var(--secondary);">
                                    <div>
                                        <p style="color: #FFF; margin: 0 0 5px 0; font-size: 1.05rem;">${notif.mensaje}</p>
                                        <small style="color: var(--text-muted);">${notif.fechaFormateada}</small>
                                    </div>
                                    <form action="${pageContext.request.contextPath}/notificaciones/leer/${notif.id}" method="POST" style="margin: 0;">
                                        <button type="submit" style="background: transparent; border: 1px solid var(--secondary); color: var(--secondary); padding: 5px 15px; font-size: 0.9rem; border-radius: 8px;">✔ Marcar Leída</button>
                                    </form>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <p style="color: var(--text-muted); font-style: italic; margin: 0; text-align: center;">No tienes notificaciones</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div style="margin-top: 50px;">
            <a href="${pageContext.request.contextPath}/logout" class="btn-logout" style="color: #FF4B4B; text-decoration: none; font-size: 1rem; font-weight: 600; padding: 10px 20px; border: 1px solid rgba(255, 75, 75, 0.3); border-radius: 20px; transition: all 0.3s;">Cerrar Sesión</a>
        </div>
    </div>
</body>
</html>
