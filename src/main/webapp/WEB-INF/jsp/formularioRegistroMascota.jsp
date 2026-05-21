<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Punto-pet | Registro</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
<div class="header-container">
    <h1 class="main-title">Registrar Mascota</h1>
</div>

<div class="form-container">
    <c:if test="${not empty mensajeExito}">
        <div class="success-message">${mensajeExito}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>
    <form:form action="/mascotas/guardar" modelAttribute="mascota" method="POST" enctype="multipart/form-data">
        
        <div class="form-section">
            <h3>Informacion de la Mascota</h3>
            <label>Nombre de la Mascota:</label>
            <form:input path="nombre" id="nombre" placeholder="Ej: Sparky" />
            <form:errors path="nombre" cssClass="error-message" />
            <span id="nombreError" class="realtime-error" style="display:none;">El nombre solo debe contener letras.</span>

            <label>Especie:</label>
            <form:select path="especie" id="especie" onchange="cargarRazas()">
                <form:option value="" label="-- Seleccione --" />
                <form:option value="perro" label="Perro" />
                <form:option value="gato" label="Gato" />
            </form:select>

            <label>Raza:</label>
            <form:select path="raza" id="raza">
                <form:option value="" label="Seleccione primero la especie" />
            </form:select>

            <label>Sexo:</label>
            <div class="radio-group">
                <form:radiobutton path="sexo" value="Macho" label=" Macho" />
                <form:radiobutton path="sexo" value="Hembra" label=" Hembra" />
            </div>
            
            <label>Fecha de Nacimiento:</label>
            <form:input path="fechaNacimiento" type="date" />

            <label>Peso (kg):</label>
            <form:input path="peso" type="number" step="0.1" />
            <form:errors path="peso" cssClass="error-message" />

            <label>Altura (cm):</label>
            <form:input path="altura" type="number" step="0.1" />
            <form:errors path="altura" cssClass="error-message" />
        </div>

        <!-- Archivos -->
        <label>Certificado Pedigree (PDF):</label>
        <input type="file" name="fileCertificado" accept=".pdf" />

        <label>Fotos (1-5):</label>
        <input type="file" name="filesFotos" multiple accept="image/*" />

        <button type="submit">Finalizar Registro</button>
        <div style="text-align: center; margin-top: 20px;">
            <a href="/home" style="color: #7f8c8d; text-decoration: none; font-size: 0.9rem;">◀ Volver al Panel Principal</a>
        </div>
    </form:form>


</div>

<script>
    const razas = {
        perro: ["Bulldog", "Terrier", "Golden Retriever", "Pastor Alemán", "Chihuahua", "Mestizo (Ecuador)", "Pitbull"],
        gato: ["Persa", "Siamés", "Maine Coon", "Angora", "Mestizo", "Bengala"]
    };

    function cargarRazas() {
        const especie = document.getElementById("especie").value;
        const razaSelect = document.getElementById("raza");
        razaSelect.innerHTML = "";

        if (especie && razas[especie]) {
            razas[especie].forEach(r => {
                let opt = document.createElement("option");
                opt.value = r;
                opt.innerHTML = r;
                razaSelect.appendChild(opt);
            });
        } else {
            let opt = document.createElement("option");
            opt.value = "";
            opt.innerHTML = "Seleccione primero la especie";
            razaSelect.appendChild(opt);
        }
    }

    // Validación interactiva en tiempo real para campos de texto (Solo Letras)
    const regexLetras = /^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$/;

    document.getElementById("nombre").addEventListener("input", function() {
        const errorSpan = document.getElementById("nombreError");
        if (this.value && !regexLetras.test(this.value)) {
            errorSpan.style.display = "block";
            errorSpan.style.color = "#e74c3c";
        } else {
            errorSpan.style.display = "none";
        }
    });

    document.getElementById("nombreDueno").addEventListener("input", function() {
        const errorSpan = document.getElementById("nombreDuenoError");
        if (this.value && !regexLetras.test(this.value)) {
            errorSpan.style.display = "block";
            errorSpan.style.color = "#e74c3c";
        } else {
            errorSpan.style.display = "none";
        }
    });
</script>
</body>
</html>