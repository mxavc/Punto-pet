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
        .profile-container { max-width: 750px; margin: 30px auto; background: white; padding: 40px; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); }
        .gallery { display: flex; gap: 15px; flex-wrap: wrap; margin-top: 15px; }
        .gallery-img { width: 120px; height: 120px; object-fit: cover; border-radius: 10px; border: 2px solid #edeff2; }
        .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 30px; }
        .info-item { background: #f8f9fa; padding: 15px; border-radius: 10px; }
        .info-item strong { color: #34495e; display: block; margin-bottom: 5px; }
        .alert-success { background: #d4edda; color: #155724; padding: 15px; border-radius: 10px; margin-bottom: 20px; text-align: center; }
        .alert-danger { background: #f8d7da; color: #721c24; padding: 15px; border-radius: 10px; margin-bottom: 20px; text-align: center; }
    </style>
</head>
<body>
    <div class="profile-container">
        <h1 style="color: #2c3e50; margin-bottom: 5px;">Perfil de ${mascota.nombre} 🐾</h1>
        <p style="color: #95a5a6; margin-top: 0; margin-bottom: 25px;">Especie: ${mascota.especie} | Raza: ${mascota.raza}</p>

        <!-- Mensajes de respuesta de la actualización -->
        <c:if test="${not empty mensajeExito}">
            <div class="alert-success">${mensajeExito}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert-danger">${error}</div>
        </c:if>

        <!-- 1. BLOQUE DE INFORMACIÓN (Consulta CA01.11) -->
        <div class="info-grid">
            <div class="info-item"><strong>Edad en el Sistema:</strong> ${mascota.edadCalculada}</div>
            <div class="info-item"><strong>Sexo:</strong> ${mascota.sexo}</div>
            <div class="info-item"><strong>Peso Actual:</strong> ${mascota.peso} kg</div>
            <div class="info-item"><strong>Altura Actual:</strong> ${mascota.altura} cm</div>
        </div>

        <!-- Galería de Fotos del Historial -->
        <h3>Galería de Fotos Asociadas</h3>
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
        <h3 style="margin-top: 30px;">Documentación Oficial</h3>
        <c:choose>
            <c:when test="${not empty mascota.certificadoPdf}">
                <div style="background: #e8f4fd; padding: 15px; border-radius: 10px; display: flex; justify-content: space-between; align-items: center;">
                    <span style="color: #2b6cb0; font-weight: 600;">📄 Certificado de Pedigree Cargado (PDF)</span>
                    <span style="font-size: 0.85rem; color: #718096;">✓ Formato Válido</span>
                </div>
            </c:when>
            <c:otherwise>
                <p style="color: #e74c3c; font-style: italic;">Esta mascota no cuenta con un certificado pedigree registrado.</p>
            </c:otherwise>
        </c:choose>

        <hr style="border: 0; border-top: 1px solid #eee; margin: 40px 0;">

        <!-- 2. FORMULARIO DE ACTUALIZACIÓN (Opciones de actualización) -->
        <h2 style="color: #2c3e50;">Actualizar Información Médica y Archivos 🔄</h2>
        <form action="/mascotas/actualizar/${mascota.id}" method="POST" enctype="multipart/form-data" style="margin-top: 20px;">

            <label>Modificar Peso (kg):</label>
            <input type="number" name="peso" step="0.1" value="${mascota.peso}" required min="1"/>

            <label>Modificar Altura (cm):</label>
            <input type="number" name="altura" step="0.1" value="${mascota.altura}" required min="1"/>

            <label>Agregar más fotos al Historial (Opcional):</label>
            <input type="file" name="filesFotos" multiple accept="image/*" />

            <label>Reemplazar/Subir Certificado Pedigree (PDF - Máx 5MB):</label>
            <input type="file" name="fileCertificado" accept=".pdf" />

            <button type="submit" style="margin-top: 15px;">Guardar Cambios de Perfil</button>
        </form>

        <div style="text-align: center; margin-top: 30px;">
            <a href="/mascotas/mis-mascotas" style="color: #3498db; text-decoration: none; font-weight: bold;">◀ Volver al Listado de Mascotas</a>
        </div>
    </div>
</body>
</html>
