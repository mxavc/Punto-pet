<%--
  Created by IntelliJ IDEA.
  User: max_i
  Date: 20/5/2026
  Time: 19:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Punto-pet | Panel Principal</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css">
<body>
    <div class="header-container">
        <h1 class="main-title" style="font-size: 3rem; margin-bottom: 20px;">¡Bienvenido a Punto-pet! 🐾</h1>
        <p style="color: var(--text-muted); font-size: 1.2rem;">Hola <strong style="color: var(--secondary);">${usuarioLogeado}</strong>, prepárate para gestionar las conexiones de tus mascotas.</p>
    </div>

    <div class="form-container glass-panel" style="text-align: center; max-width: 800px; padding: 60px;">
        <h2 style="color: #FFF; font-weight: 300; margin-bottom: 40px;">¿Qué deseas hacer hoy?</h2>
        
        <div class="button-group" style="display: flex; flex-direction: column; gap: 20px; align-items: center;">
            <a href="/mascotas/registro" class="btn-nav" style="max-width: 400px; background: linear-gradient(135deg, #FF3366, #FF6B6B);">➕ Registrar nueva Mascota</a>
            <a href="/mascotas/mis-mascotas" class="btn-nav" style="max-width: 400px; background: linear-gradient(135deg, #20E3B2, #00B4D8);">📋 Ver Mis Mascotas</a>
            <a href="/parejas/buscar" class="btn-nav" style="max-width: 400px; background: linear-gradient(135deg, #9D4EDD, #C77DFF);">🔍 Buscar Parejas</a>
        </div>

        <div style="margin-top: 50px;">
            <a href="/logout" class="btn-logout" style="color: #FF4B4B; text-decoration: none; font-size: 1rem; font-weight: 600; padding: 10px 20px; border: 1px solid rgba(255, 75, 75, 0.3); border-radius: 20px; transition: all 0.3s;">Cerrar Sesión</a>
        </div>
    </div>
</body>
</html>
