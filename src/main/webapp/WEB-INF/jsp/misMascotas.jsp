<%--
  Created by IntelliJ IDEA.
  User: max_i
  Date: 21/5/2026
  Time: 13:22
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mascotas Registradas</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="header-container">
    <h1 class="main-title">Mis Mascotas Registradas 🐾</h1>
</div>

<c:if test="${not empty mensajeExito}">
    <div class="success-message" style="max-width: 600px; margin: 0 auto 30px auto;">${mensajeExito}</div>
</c:if>

    <div style="max-width: 1000px; margin: 0 auto; display: flex; gap: 30px; flex-wrap: wrap; padding: 20px; justify-content: center;">
        <c:forEach var="mascota" items="${mascotas}">
            <div class="card" style="width: 280px; text-align: center;">
                <h3 class="text-gradient" style="font-size: 1.8rem; margin-bottom: 10px;">${mascota.nombre}</h3>
                <p style="color: var(--text-muted); margin: 5px 0; font-size: 1.1rem;">${mascota.raza}</p>
                <p style="font-size: 1rem; font-weight: bold; color: var(--secondary); margin-bottom: 25px;">${mascota.edadCalculada}</p>

                <div>
                    <a href="${pageContext.request.contextPath}/mascotas/detalle/${mascota.id}" class="btn-nav" style="padding: 12px 24px; font-size: 0.9rem;">Ver Perfil Completo</a>
                </div>
            </div>
        </c:forEach>
    </div>
    <div style="text-align: center; margin-top: 30px; margin-bottom: 50px;">
        <a href="${pageContext.request.contextPath}/home" style="color: var(--secondary); text-decoration: none; font-size: 1.1rem; font-weight: 600; text-transform: uppercase; letter-spacing: 1px;">◀ Volver al Panel Principal</a>
    </div>
</body>
</html>
