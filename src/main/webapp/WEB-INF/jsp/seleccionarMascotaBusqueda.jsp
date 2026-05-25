<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Punto-pet | Seleccionar Mascota</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
    <div class="header-container">
        <h1 class="main-title">¿Para quién buscas pareja? 🔍</h1>
    </div>

    <div class="form-container glass-panel" style="text-align: center;">
        <c:choose>
            <c:when test="${empty mascotas}">
                <h3 style="color: var(--danger); font-size: 1.5rem; margin-bottom: 20px;">No tienes mascotas registradas</h3>
                <p style="color: var(--text-muted); margin-bottom: 30px;">Debes registrar al menos una mascota antes de poder buscar parejas.</p>
                <a href="/mascotas/registro" class="btn-nav" style="background: linear-gradient(135deg, #FF3366, #FF6B6B);">➕ Registrar nueva Mascota</a>
            </c:when>
            <c:otherwise>
                <p style="color: var(--text-muted); margin-bottom: 30px; font-size: 1.1rem;">Tienes varias mascotas. Selecciona una para encontrarle pareja:</p>
                <div style="display: flex; flex-direction: column; gap: 20px;">
                    <c:forEach var="mascota" items="${mascotas}">
                        <a href="/parejas/filtros?mascotaId=${mascota.id}" class="btn-nav" style="background: rgba(32, 227, 178, 0.2); border: 1px solid var(--secondary); color: white; transition: all 0.3s;">
                            🐶 Seleccionar a <strong style="color: var(--secondary);">${mascota.nombre}</strong> (${mascota.raza})
                        </a>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

        <div style="margin-top: 40px;">
            <a href="/home" style="color: var(--danger); text-decoration: none; font-size: 1rem; font-weight: 600; text-transform: uppercase;">Cancelar</a>
        </div>
    </div>
</body>
</html>
