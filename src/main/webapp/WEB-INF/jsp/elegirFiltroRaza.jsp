<%--
  Created by IntelliJ IDEA.
  User: max_i
  Date: 21/5/2026
  Time: 15:34
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Punto-pet | Opciones de Filtro</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
    <div class="form-container" style="text-align: center;">
        <h2>¿Qué tipo de pareja buscas? 🧬</h2>
        <p style="color: #7f8c8d; margin-bottom: 30px;">Selecciona el filtro de raza para prever los cachorros resultantes.</p>

        <form action="/parejas/resultados" method="GET">
            <input type="hidden" name="mascotaId" value="${mascotaId}" />

            <div style="margin-bottom: 20px;">
                <button type="submit" name="tipoFiltro" value="MISMA_RAZA" style="background: #2ecc71; margin-bottom: 15px;">
                    🤝 Buscar de la Misma Raza
                </button>

                <button type="submit" name="tipoFiltro" value="OTRA_RAZA" style="background: #e67e22;">
                    🔀 Buscar de Diferente Raza
                </button>
            </div>
        </form>
        <a href="/home" style="color: #95a5a6; text-decoration: none; font-size: 0.9rem;">Cancelar búsqueda</a>
    </div>
</body>
</html>
