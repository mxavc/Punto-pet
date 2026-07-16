<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="es">

        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Punto-pet | Registro</title>
            <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
        </head>

        <body>
            <div class="header-container">
                <h1 class="main-title">Registrar Mascota</h1>
            </div>

            <div class="form-container glass-panel">
                <c:if test="${not empty mensajeExito}">
                    <div class="success-message">${mensajeExito}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="error-message">${error}</div>
                </c:if>
                <form:form action="/mascotas/guardar" modelAttribute="mascota" method="POST"
                    enctype="multipart/form-data">

                    <div class="form-section">
                        <h3 class="text-gradient">Informacion de la Mascota</h3>
                        <label for="nombre">Nombre de la Mascota</label>
                        <form:input path="nombre" id="nombre" placeholder="Ej: Sparky" />
                        <form:errors path="nombre" cssClass="error-message" />
                        <span id="nombreError" class="realtime-error" style="display:none;">El nombre solo debe contener
                            letras.</span>

                        <label for="especie">Especie</label>
                        <form:select path="especie" id="especie" onchange="cargarRazas()">
                            <form:option value="" label="-- Seleccione --" />
                            <form:option value="perro" label="Perro" />
                            <form:option value="gato" label="Gato" />
                        </form:select>

                        <label for="raza">Raza</label>
                        <form:select path="raza" id="raza">
                            <form:option value="" label="Seleccione primero la especie" />
                        </form:select>

                        <span style="color: var(--text-muted); font-weight: bold; display: block; margin-bottom: 8px;">Sexo</span>
                        <div class="radio-group">
                            <label for="sexoMacho">
                                <form:radiobutton path="sexo" id="sexoMacho" value="Macho" /> Macho
                            </label>
                            <label for="sexoHembra">
                                <form:radiobutton path="sexo" id="sexoHembra" value="Hembra" /> Hembra
                            </label>
                        </div>

                        <label for="fechaNacimiento">Fecha de Nacimiento</label>
                        <form:input path="fechaNacimiento" id="fechaNacimiento" type="date" style="color-scheme: dark;" />

                        <label for="peso">Peso (kg)</label>
                        <form:input path="peso" id="peso" type="number" step="0.1" />
                        <form:errors path="peso" cssClass="error-message" />

                        <label for="altura">Altura (cm)</label>
                        <form:input path="altura" id="altura" type="number" step="0.1" />
                        <form:errors path="altura" cssClass="error-message" />
                    </div>

                    <!-- Archivos -->
                    <div class="form-section">
                        <h3 class="text-gradient">Archivos Adicionales</h3>
                        <label for="fileCertificado">Certificado Pedigree (PDF)</label>
                        <input type="file" id="fileCertificado" name="fileCertificado" accept=".pdf" />

                        <label for="filesFotos">Fotos (1-5)</label>
                        <input type="file" id="filesFotos" name="filesFotos" multiple accept="image/*" />
                    </div>

                    <button type="submit" style="margin-top: 20px;">Finalizar Registro</button>
                    <div style="text-align: center; margin-top: 30px;">
                        <a href="${pageContext.request.contextPath}/home"
                            style="color: var(--secondary); text-decoration: none; font-size: 1rem; font-weight: 600; text-transform: uppercase; letter-spacing: 1px;">Volver
                            al Panel Principal</a>
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

                document.getElementById("nombre").addEventListener("input", function () {
                    const errorSpan = document.getElementById("nombreError");
                    if (this.value && !regexLetras.test(this.value)) {
                        errorSpan.style.display = "block";
                        errorSpan.style.color = "#e74c3c";
                    } else {
                        errorSpan.style.display = "none";
                    }
                });

                // nombreDueno non-existent element check removed
            </script>
        </body>

        </html>