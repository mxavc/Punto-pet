<%--
  Created by IntelliJ IDEA.
  User: max_i
  Date: 21/5/2026
  Time: 15:37
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Punto-pet | Candidatos Disponibles</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
  <div class="header-container">
    <h1 class="main-title">Parejas Compatibles Encontradas 🎯</h1>
  </div>

  <div style="max-width: 1000px; margin: 0 auto; display: flex; gap: 30px; flex-wrap: wrap; padding: 20px; justify-content: center;">
    <c:choose>
      <c:when test="${not empty resultados}">
        <c:forEach var="pareja" items="${resultados}">
          <div class="card" style="width: 280px; text-align: center;">
            <h3 class="text-gradient" style="margin-bottom: 15px; font-size: 1.8rem;">${pareja.nombre}</h3>
            <span style="background: rgba(32, 227, 178, 0.15); color: var(--secondary); padding: 5px 12px; border-radius: 20px; font-size: 0.9rem; font-weight: bold; border: 1px solid rgba(32, 227, 178, 0.3);">
                ${pareja.raza}
            </span>
            <p style="color: #FFF; margin-top: 20px; font-size: 1.1rem;">Sexo: <strong style="color: var(--primary);">${pareja.sexo}</strong></p>
            <p style="font-size: 1rem; color: var(--text-muted); margin-bottom: 25px;">Edad: ${pareja.edadCalculada}</p>

            <div>
              <a href="/mascotas/detalle/${pareja.id}" class="btn-nav" style="padding: 12px 20px; font-size: 0.9rem; display: block;">Ver Documentación</a>
            </div>
          </div>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <div class="glass-panel" style="width: 100%; text-align: center; padding: 50px; border-radius: 24px; max-width: 600px; margin: 40px auto;">
          <p style="color: var(--text-muted); font-size: 1.2rem; margin-bottom: 30px;">No se encontraron parejas disponibles en el sistema que cumplan con este criterio de filtrado por el momento. 🐾</p>
          <a href="/home" class="btn-nav" style="display: inline-block; width: auto; padding: 15px 30px;">Volver al Inicio</a>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
    <div style="text-align: center; margin-top: 30px; margin-bottom: 50px;">
        <a href="/home" style="color: var(--secondary); text-decoration: none; font-size: 1.1rem; font-weight: 600; text-transform: uppercase; letter-spacing: 1px;">◀ Volver al Panel Principal</a>
    </div>
</body>
</html>
