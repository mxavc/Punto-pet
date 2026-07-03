<%--
  Created by IntelliJ IDEA.
  User: max_i
  Date: 21/5/2026
  Time: 13:30
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Punto-pet | Perfil de ${mascota.nombre}</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <style>
        .profile-container { max-width: 850px; margin: 50px auto; padding: 50px; }
        .gallery { display: flex; gap: 20px; flex-wrap: wrap; margin-top: 20px; }
        .gallery-img { width: 150px; height: 150px; object-fit: cover; border-radius: 15px; border: 2px solid var(--secondary); box-shadow: 0 5px 15px rgba(0,0,0,0.3); transition: transform 0.3s; }
        .gallery-img:hover { transform: scale(1.05); }
        .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 25px; margin-bottom: 40px; }
        .info-item { background: rgba(0,0,0,0.2); padding: 20px; border-radius: 15px; border: 1px solid rgba(255,255,255,0.1); }
        .info-item strong { color: var(--secondary); display: block; margin-bottom: 8px; font-size: 1.1rem; }
    </style>
</head>
<body>
    <div class="profile-container glass-panel">
        <h1 class="text-gradient" style="margin-bottom: 10px; font-size: 2.5rem;">Perfil de ${mascota.nombre} 🐾</h1>
        <p style="color: var(--text-muted); margin-top: 0; margin-bottom: 35px; font-size: 1.2rem;">Especie: <span style="color:white;">${mascota.especie}</span> | Raza: <span style="color:white;">${mascota.raza}</span></p>

        <!-- Mensajes de respuesta de la actualización -->
        <c:if test="${not empty mensajeExito}">
            <div class="success-message">${mensajeExito}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <!-- 1. BLOQUE DE INFORMACIÓN (Consulta CA01.11) -->
        <div class="info-grid">
            <div class="info-item"><strong>Edad en el Sistema</strong> ${mascota.edadCalculada}</div>
            <div class="info-item"><strong>Sexo</strong> ${mascota.sexo}</div>
            <div class="info-item"><strong>Peso Actual</strong> ${mascota.peso} kg</div>
            <div class="info-item"><strong>Altura Actual</strong> ${mascota.altura} cm</div>
        </div>

        <!-- Galería de Fotos del Historial -->
        <h3 style="color: var(--primary); font-size: 1.5rem;">Galería de Fotos Asociadas</h3>
        <div class="gallery">
            <c:forEach var="fotoBytes" items="${mascota.fotos}">
                <!-- Importación nativa para codificar el binario a Base64 interactivo en JSP -->
                <%
                    byte[] bytes = (byte[]) pageContext.getAttribute("fotoBytes");
                    String base64 = java.util.Base64.getEncoder().encodeToString(bytes);
                    pageContext.setAttribute("base64Foto", base64);
                %>
                <img src="data:image/jpeg;base64,${base64Foto}" class="gallery-img" alt="Foto mascota"/>
            </c:forEach>
        </div>

        <!-- Estado del Certificado Pedigree -->
        <h3 style="margin-top: 40px; color: var(--primary); font-size: 1.5rem;">Documentación Oficial</h3>
        <c:choose>
            <c:when test="${not empty mascota.certificadoPdf}">
                <div style="background: rgba(32, 227, 178, 0.1); padding: 20px; border-radius: 15px; border: 1px solid var(--secondary); display: flex; justify-content: space-between; align-items: center;">
                    <span style="color: var(--secondary); font-weight: 600; font-size: 1.1rem;">📄 Certificado de Pedigree Cargado (PDF)</span>
                    <span style="font-size: 0.9rem; color: #FFF; background: var(--success); padding: 5px 10px; border-radius: 8px;">✓ Válido</span>
                </div>
            </c:when>
            <c:otherwise>
                <p style="color: var(--danger); font-style: italic; background: rgba(255, 75, 75, 0.1); padding: 15px; border-radius: 10px; border: 1px solid var(--danger);">Esta mascota no cuenta con un certificado pedigree registrado.</p>
            </c:otherwise>
        </c:choose>

        <hr style="border: 0; border-top: 1px solid rgba(255,255,255,0.1); margin: 50px 0;">

        <c:choose>
            <c:when test="${usuarioActual eq mascota.duenoId}">
                <!-- 2. FORMULARIO DE ACTUALIZACIÓN (Opciones de actualización) -->
                <h2 style="color: #FFF; font-weight: 300;">Actualizar Información Médica y Archivos 🔄</h2>
                <form action="/mascotas/actualizar/${mascota.id}" method="POST" enctype="multipart/form-data" style="margin-top: 30px;">

                    <label>Modificar Peso (kg)</label>
                    <input type="number" name="peso" step="0.1" value="${mascota.peso}" required min="1"/>

                    <label>Modificar Altura (cm)</label>
                    <input type="number" name="altura" step="0.1" value="${mascota.altura}" required min="1"/>

                    <label>Agregar más fotos al Historial (Opcional)</label>
                    <input type="file" name="filesFotos" multiple accept="image/*" />

                    <label>Reemplazar/Subir Certificado Pedigree (PDF - Máx 5MB)</label>
                    <input type="file" name="fileCertificado" accept=".pdf" />

                    <button type="submit" style="margin-top: 25px;">Guardar Cambios de Perfil</button>
                </form>

                <div style="text-align: center; margin-top: 40px; padding-top: 30px; border-top: 1px solid rgba(255, 75, 75, 0.3);">
                    <!-- Block / Unblock logic -->
                    <c:choose>
                        <c:when test="${mascota.bloqueadaEnBusquedas}">
                            <form action="/mascotas/desbloquear/${mascota.id}" method="POST" style="display:inline-block; margin-right: 15px;">
                                <button type="submit" style="background: linear-gradient(135deg, #00B4D8, #20E3B2); padding: 14px 35px; font-size: 1.1rem; box-shadow: 0 10px 20px rgba(32, 227, 178, 0.3);">🔓 Desbloquear en búsquedas</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <form action="/mascotas/bloquear/${mascota.id}" method="POST" style="display:inline-block; margin-right: 15px;">
                                <button type="submit" style="background: linear-gradient(135deg, #F9C80E, #FF9F1C); padding: 14px 35px; font-size: 1.1rem; box-shadow: 0 10px 20px rgba(255, 159, 28, 0.3);">🔒 Bloquear en búsquedas</button>
                            </form>
                        </c:otherwise>
                    </c:choose>

                    <button type="button" onclick="mostrarModalEliminar()" style="background: linear-gradient(135deg, #FF4B4B, #c0392b); padding: 14px 35px; font-size: 1.1rem; max-width: 300px; box-shadow: 0 10px 20px rgba(255, 75, 75, 0.3);">🗑️ Eliminar perfil</button>
                </div>
            </c:when>
            <c:otherwise>
                <!-- ACCIONES PARA OTRAS MASCOTAS (RESULTADOS DE BÚSQUEDA) -->
                <div style="text-align: center; margin-top: 40px;">
                    <button type="button" onclick="mostrarModalDueno()" style="background: linear-gradient(135deg, #00B4D8, #20E3B2); padding: 14px 35px; font-size: 1.1rem; max-width: 400px; margin: 0 auto; box-shadow: 0 10px 20px rgba(32, 227, 178, 0.3);">👤 Visualizar perfil del dueño</button>
                </div>
            </c:otherwise>
        </c:choose>

        <div style="text-align: center; margin-top: 40px;">
            <a href="/mascotas/mis-mascotas" style="color: var(--secondary); text-decoration: none; font-size: 1.1rem; font-weight: 600; text-transform: uppercase; letter-spacing: 1px;">◀ Volver al Listado de Mascotas</a>
        </div>
    </div>

    <!-- Modal de confirmación de eliminación -->
    <c:if test="${usuarioActual eq mascota.duenoId}">
    <div id="deleteModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.8); z-index:1000; justify-content:center; align-items:center; backdrop-filter: blur(5px);">
        <div class="glass-panel" style="padding: 40px; text-align: center; max-width: 450px; border-color: rgba(255, 75, 75, 0.4);">
            <h2 style="color: #FFF; margin-bottom: 20px;">¿Está seguro de eliminar este perfil?</h2>
            <p style="color: var(--text-muted); margin-bottom: 35px; font-size: 1.1rem;">Esta acción es irreversible y borrará permanentemente la mascota del sistema.</p>
            <div style="display: flex; gap: 20px; justify-content: center;">
                <form action="/mascotas/eliminar/${mascota.id}" method="POST" style="margin: 0; width: 100%;">
                    <button type="submit" style="background: linear-gradient(135deg, #FF4B4B, #c0392b); padding: 14px 10px; margin:0; width: 100%;">Sí</button>
                </form>
                <button type="button" onclick="ocultarModalEliminar()" style="background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2); padding: 14px 10px; margin:0; color: white;">No</button>
            </div>
        </div>
    </div>
    <script>
        function mostrarModalEliminar() { document.getElementById('deleteModal').style.display = 'flex'; }
        function ocultarModalEliminar() { document.getElementById('deleteModal').style.display = 'none'; }
    </script>
    </c:if>

    <!-- Modal del Perfil del Dueño -->
    <c:if test="${usuarioActual ne mascota.duenoId}">
        <jsp:include page="perfilDueno.jsp" />
    </c:if>
</body>
</html>
