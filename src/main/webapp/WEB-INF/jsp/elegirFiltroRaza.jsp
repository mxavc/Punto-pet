<%-- Created by IntelliJ IDEA. User: max_i Date: 21/5/2026 Time: 15:34 To change this template use File | Settings |
    File Templates. --%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <%@ page contentType="text/html;charset=UTF-8" language="java" %>
                <html>

                <head>
                    <title>Punto-pet | Opciones de Filtro</title>
                    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
                </head>

                <body>
                    <div class="form-container glass-panel" style="text-align: center; margin-top: 100px;">
                        <h2 class="text-gradient" style="font-size: 2rem; margin-bottom: 20px;">¿Qué tipo de pareja
                            buscas? 🧬</h2>
                        <p style="color: var(--text-muted); margin-bottom: 40px; font-size: 1.1rem;">Selecciona el
                            filtro de raza para prever los cachorros resultantes.</p>

                        <form action="${pageContext.request.contextPath}/parejas/resultados" method="GET">
                            <input type="hidden" name="mascotaId" value="${mascotaId}" />

                            <div style="margin-bottom: 30px; display: flex; flex-direction: column; gap: 20px;">
                                <button type="submit" name="tipoFiltro" value="MISMA_RAZA"
                                    style="background: linear-gradient(135deg, #20E3B2, #00B4D8);">
                                    🤝 Buscar de la Misma Raza
                                </button>

                                <button type="submit" name="tipoFiltro" value="OTRA_RAZA"
                                    style="background: linear-gradient(135deg, #FF9A9E, #FECFEF); color: #333;">
                                    🔀 Buscar de Diferente Raza
                                </button>
                            </div>
                        </form>
                        <a href="${pageContext.request.contextPath}/home"
                            style="color: var(--danger); text-decoration: none; font-size: 1rem; font-weight: 600; text-transform: uppercase;">Cancelar
                            búsqueda</a>
                    </div>
                </body>

                </html>