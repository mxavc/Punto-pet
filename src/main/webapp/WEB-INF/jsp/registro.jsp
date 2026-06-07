<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Punto-pet | Registro de Usuario</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body style="display: flex; justify-content: center; align-items: center; min-height: 100vh; padding: 40px 0;">
<div class="form-container glass-panel" style="width: 100%; max-width: 700px; margin: 0; box-sizing: border-box;">
    <h2 class="text-gradient" style="font-size: 2.2rem; margin-bottom: 30px; text-align: center;">Únete a Punto-pet 🐾</h2>

    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>

    <form action="/registro" method="POST">
        <div class="form-section" style="border: none; padding: 0; display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
            
            <div style="grid-column: span 1;">
                <label>Nombres</label>
                <input type="text" name="nombres" required placeholder="Tus nombres" />
            </div>

            <div style="grid-column: span 1;">
                <label>Apellidos</label>
                <input type="text" name="apellidos" required placeholder="Tus apellidos" />
            </div>

            <div style="grid-column: span 1;">
                <label>Teléfono</label>
                <div style="display: flex; gap: 10px;">
                    <select name="codigoPais" style="width: 100px;">
                        <option value="+593" selected>+593</option>
                        <option value="+57">+57</option>
                        <option value="+51">+51</option>
                        <option value="+1">+1</option>
                    </select>
                    <input type="text" name="telefono" required placeholder="Número" style="flex: 1;" />
                </div>
            </div>

            <div style="grid-column: span 1;">
                <label>Correo Electrónico</label>
                <input type="email" name="correo" required placeholder="correo@ejemplo.com" />
            </div>

            <div style="grid-column: span 1;">
                <label>Ciudad</label>
                <input type="text" name="ciudad" required placeholder="Tu ciudad" />
            </div>

            <div style="grid-column: span 1;">
                <label>Sector</label>
                <input type="text" name="sector" required placeholder="Tu sector" />
            </div>

            <div style="grid-column: span 2;">
                <label>Contraseña</label>
                <input type="password" name="password" required placeholder="Mayúsculas, minúsculas, números y un carácter especial" />
            </div>
            
        </div>
        
        <button type="submit" style="margin-top: 10px;">Registrar Cuenta</button>
    </form>
    
    <div style="text-align: center; margin-top: 30px;">
        <a href="/login" style="color: var(--secondary); text-decoration: none; font-size: 1rem; font-weight: 600;">◀ Volver al Login</a>
    </div>
</div>
</body>
</html>
