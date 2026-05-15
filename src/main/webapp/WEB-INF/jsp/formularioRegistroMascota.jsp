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

        <div class="form-section">
            <h3>Informacion del Duenio</h3>
            <label>Nombre del Duenioo:</label>
            <form:input path="nombreDueno" id="nombreDueno" placeholder="Nombre y Apellido" />
            <form:errors path="nombreDueno" cssClass="error-message" />
            <span id="nombreDuenoError" class="realtime-error" style="display:none;">El nombre del duenio solo debe contener letras.</span>
            <label>Telefono de Contacto:</label>
            <form:input path="telefonoDueno" placeholder="0999999999" />
            <form:errors path="telefonoDueno" cssClass="error-message" />
        </div>

        <!-- Archivos -->
        <label>Certificado Pedigree (PDF):</label>
        <input type="file" name="fileCertificado" accept=".pdf" />

        <label>Fotos (1-5):</label>
        <input type="file" name="filesFotos" multiple accept="image/*" />

        <button type="submit">Finalizar Registro</button>
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
            opt.innerHTML = "Seleccione especie";
            razaSelect.appendChild(opt);
        }
    }

    function validarSoloLetras(inputEl, errorEl) {
        const valor = inputEl.value || "";
        const soloLetras = /^[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+$/.test(valor) || valor.length === 0;
        errorEl.style.display = soloLetras ? "none" : "block";
    }

    const nombreInput = document.getElementById("nombre");
    const nombreError = document.getElementById("nombreError");
    const nombreDuenoInput = document.getElementById("nombreDueno");
    const nombreDuenoError = document.getElementById("nombreDuenoError");

    if (nombreInput && nombreError) {
        nombreInput.addEventListener("input", () => validarSoloLetras(nombreInput, nombreError));
    }

    if (nombreDuenoInput && nombreDuenoError) {
        nombreDuenoInput.addEventListener("input", () => validarSoloLetras(nombreDuenoInput, nombreDuenoError));
    }
</script>
</body>
</html>