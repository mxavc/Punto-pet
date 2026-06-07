<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Modal del Perfil del Dueño -->
<div id="duenoModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.8); z-index:1000; justify-content:center; align-items:center; backdrop-filter: blur(5px);">
    <div class="glass-panel" style="padding: 40px; text-align: center; max-width: 450px; width: 90%; border-color: rgba(32, 227, 178, 0.4); max-height: 90vh; overflow-y: auto;">
        <c:choose>
            <c:when test="${not empty dueno}">
                
                <h2 style="color: #FFF; margin-bottom: 5px; font-size: 1.8rem;">${dueno.nombres} ${dueno.apellidos}</h2>
                <p style="color: var(--secondary); font-weight: bold; margin-bottom: 20px; font-size: 1.1rem;">📍 ${dueno.ciudad}, ${dueno.sector}</p>
                
                <div style="background: rgba(0,0,0,0.3); padding: 20px; border-radius: 15px; text-align: left; margin-bottom: 25px; border: 1px solid rgba(255,255,255,0.05);">
                    <p style="color: white; margin: 8px 0; font-size: 1.1rem;">📧 <strong>Correo:</strong> ${dueno.correo}</p>
                    <p style="color: white; margin: 8px 0; font-size: 1.1rem;">📞 <strong>Teléfono:</strong> ${dueno.codigoPais} ${dueno.telefono}</p>
                </div>

                <!-- Botón Contactar Usuario -->
                <button type="button" onclick="mostrarFormularioMensaje()" style="background: linear-gradient(135deg, #00B4D8, #20E3B2); padding: 12px 30px; margin-bottom: 20px; width: 100%; box-shadow: 0 5px 15px rgba(32, 227, 178, 0.3);">💬 Contactar Usuario</button>

                <!-- Formulario de Mensaje (Oculto por defecto) -->
                <div id="formularioMensaje" style="display:none; margin-bottom: 25px; text-align: left; background: rgba(0,0,0,0.2); padding: 15px; border-radius: 10px;">
                    <form action="/mensajes/enviar" method="POST" style="margin: 0;">
                        <input type="hidden" name="destinatarioId" value="${dueno.correo}" />
                        <input type="hidden" name="mascotaId" value="${mascota.id}" />
                        <label style="color: white; font-size: 0.9rem; display: block; margin-bottom: 8px;">Escribe tu mensaje:</label>
                        <textarea name="contenido" rows="4" style="width: 100%; box-sizing: border-box; border-radius: 10px; padding: 10px; background: rgba(0,0,0,0.4); color: white; border: 1px solid var(--secondary); margin-bottom: 15px; resize: vertical;" placeholder="Ej: ¡Hola! Me encantaría que nuestras mascotas se conozcan..."></textarea>
                        <button type="submit" style="background: var(--primary); padding: 10px 20px; width: 100%;">📤 Enviar Mensaje</button>
                    </form>
                </div>

            </c:when>
            <c:otherwise>
                <h2 style="color: var(--danger); margin-bottom: 20px;">Perfil no disponible</h2>
                <p style="color: var(--text-muted); margin-bottom: 30px;">El sistema no pudo localizar la información pública del dueño de esta mascota en este momento.</p>
            </c:otherwise>
        </c:choose>
        <button type="button" onclick="ocultarModalDueno()" style="background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2); padding: 12px 35px; margin:0; color: white; width: 100%;">Cerrar</button>
    </div>
</div>
<script>
    function mostrarModalDueno() { 
        document.getElementById('duenoModal').style.display = 'flex'; 
        let formMsg = document.getElementById('formularioMensaje');
        if(formMsg) formMsg.style.display = 'none'; // Resetear estado
    }
    function ocultarModalDueno() { 
        document.getElementById('duenoModal').style.display = 'none'; 
    }
    function mostrarFormularioMensaje() {
        document.getElementById('formularioMensaje').style.display = 'block';
    }
</script>
