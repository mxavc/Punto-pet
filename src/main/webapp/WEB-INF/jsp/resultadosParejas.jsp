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

  <div style="max-width: 900px; margin: 0 auto; display: flex; gap: 20px; flex-wrap: wrap; padding: 20px;">
    <c:choose>
      <c:when test="${not empty resultados}">
        <c:forEach var="pareja" items="${resultados}">
          <div class="card" style="background: white; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); width: 260px; padding: 20px; text-align: center;">
            <h3 style="margin-bottom: 5px;">${pareja.nombre}</h3>
            <span style="background: #e1f5fe; color: #0288d1; padding: 3px 8px; border-radius: 20px; font-size: 0.8rem; font-weight: bold;">
                ${pareja.raza}
            </span>
            <p style="color: #555; margin-top: 10px;">Sexo: <strong>${pareja.sexo}</strong></p>
            <p style="font-size: 0.9rem; color: #7f8c8d;">Edad: ${pareja.edadCalculada}</p>

            <div style="margin-top: 15px;">
              <a href="/mascotas/detalle/${pareja.id}" style="background: #3498db; color: white; padding: 8px 16px; text-decoration: none; border-radius: 6px; font-size: 0.9rem; font-weight: bold; display: block;">Ver Documentación</a>
            </div>
          </div>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <div style="width: 100%; text-align: center; padding: 40px; background: white; border-radius: 12px;">
          <p style="color: #7f8c8d; font-size: 1.1rem;">No se encontraron parejas disponibles en el sistema que cumplan con este criterio de filtrado por el momento. 🐾</p>
          <a href="/home" class="button" style="text-decoration: none; display: inline-block; padding: 10px 20px; background: #3498db; color: white; border-radius: 6px; margin-top: 15px;">Volver al Inicio</a>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</body>
</html>
