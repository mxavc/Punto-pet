<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
            <html lang="es">

            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Punto-pet | Mis Mensajes</title>
                <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
            </head>

            <body>
                <div class="header-container">
                    <h1 class="main-title">Bandeja de Mensajes 💬</h1>
                </div>

                <c:if test="${not empty mensajeExito}">
                    <div class="success-message">${mensajeExito}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="error-message">${error}</div>
                </c:if>

                <div style="max-width: 900px; margin: 40px auto; padding: 20px;">
                    <c:choose>
                        <c:when test="${not empty mensajes}">
                            <div style="display: flex; flex-direction: column; gap: 20px;">
                                <c:forEach var="msg" items="${mensajes}">

                                    <c:set var="esRecibido" value="${msg.destinatarioId eq usuarioActual}" />

                                    <div class="glass-panel"
                                        style="padding: 25px; border-radius: 15px; border-left: 5px solid ${esRecibido ? '#20E3B2' : '#C77DFF'}; display: flex; flex-direction: column; gap: 15px;">

                                        <div
                                            style="display: flex; justify-content: space-between; border-bottom: 1px solid rgba(255,255,255,0.1); padding-bottom: 10px;">
                                            <div>
                                                <c:choose>
                                                    <c:when test="${esRecibido}">
                                                        <span
                                                            style="color: #20E3B2; font-weight: bold; text-transform: uppercase; font-size: 0.8rem; letter-spacing: 1px;">📥
                                                            Recibido</span>
                                                        <p style="color: #FFF; margin: 5px 0 0 0; font-size: 1.1rem;">
                                                            De: <strong>${msg.remitenteId}</strong></p>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span
                                                            style="color: #C77DFF; font-weight: bold; text-transform: uppercase; font-size: 0.8rem; letter-spacing: 1px;">📤
                                                            Enviado</span>
                                                        <p style="color: #FFF; margin: 5px 0 0 0; font-size: 1.1rem;">
                                                            Para: <strong>${msg.destinatarioId}</strong></p>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div
                                                style="text-align: right; color: var(--text-muted); font-size: 0.9rem;">
                                                ${msg.fechaEnviadoFormateada}
                                            </div>
                                        </div>

                                        <div
                                            style="color: #EEE; font-size: 1.05rem; line-height: 1.5; background: rgba(0,0,0,0.2); padding: 15px; border-radius: 10px;">
                                            "${msg.contenido}"
                                        </div>

                                        <c:if test="${esRecibido}">
                                            <div style="text-align: right; margin-top: 10px;">
                                                <button type="button" onclick="mostrarResponder(${msg.id})"
                                                    style="background: transparent; border: 1px solid var(--secondary); color: var(--secondary); padding: 8px 20px; font-size: 0.9rem;">↩️
                                                    Responder</button>
                                            </div>

                                            <div id="formResponder_${msg.id}"
                                                style="display: none; margin-top: 15px; background: rgba(0,0,0,0.3); padding: 15px; border-radius: 10px;">
                                                <form action="${pageContext.request.contextPath}/mensajes/responder"
                                                    method="POST" style="margin: 0;">
                                                    <input type="hidden" name="destinatarioId"
                                                        value="${msg.remitenteId}" />
                                                    <textarea name="contenido" rows="3"
                                                        style="width: 100%; border-radius: 8px; padding: 10px; background: rgba(0,0,0,0.5); color: white; border: 1px solid var(--secondary); margin-bottom: 10px; resize: vertical;"
                                                        placeholder="Escribe tu respuesta..." aria-label="Contenido de respuesta"></textarea>
                                                    <button type="submit"
                                                        style="background: var(--secondary); padding: 8px 20px;">Enviar
                                                        Respuesta</button>
                                                </form>
                                            </div>
                                        </c:if>

                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="glass-panel"
                                style="text-align: center; padding: 50px; border-radius: 20px; margin: 0 auto; max-width: 500px;">
                                <p style="color: var(--text-muted); font-size: 1.2rem; margin: 0;">No existen mensajes
                                    📭</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div style="text-align: center; margin-top: 30px; margin-bottom: 50px;">
                    <a href="${pageContext.request.contextPath}/home"
                        style="color: var(--secondary); text-decoration: none; font-size: 1.1rem; font-weight: 600; text-transform: uppercase; letter-spacing: 1px;">◀
                        Volver al Panel Principal</a>
                </div>

                <script>
                    function mostrarResponder(id) {
                        let form = document.getElementById('formResponder_' + id);
                        if (form.style.display === 'none' || form.style.display === '') {
                            form.style.display = 'block';
                        } else {
                            form.style.display = 'none';
                        }
                    }
                </script>
            </body>

            </html>