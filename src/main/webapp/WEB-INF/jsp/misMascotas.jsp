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
<html>
<head>
    <title>Mascotas Registradas</title>
</head>
<body>
<div class="header-container">
    <h1 class="main-title">Mis Mascotas Registradas 🐾</h1>
</div>

    <div style="max-width: 900px; margin: 0 auto; display: flex; gap: 20px; flex-wrap: wrap; padding: 20px;">
        <c:forEach var="mascota" items="${mascotas}">
            <div class="card" style="background: white; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); width: 260px; padding: 20px; text-align: center;">
                <h3>${mascota.nombre}</h3>
                <p style="color: #7f8c8d; margin: 5px 0;">${mascota.raza}</p>
                <p style="font-size: 0.9rem; font-weight: bold; color: #3498db;">${mascota.edadCalculada}</p>

                <div style="margin-top: 15px;">
                    <a href="/mascotas/detalle/${mascota.id}" style="background: #3498db; color: white; padding: 8px 16px; text-decoration: none; border-radius: 6px; font-size: 0.9rem; font-weight: bold;">Ver Perfil Completo</a>
                </div>
            </div>
        </c:forEach>
    </div>
</body>
</html>
