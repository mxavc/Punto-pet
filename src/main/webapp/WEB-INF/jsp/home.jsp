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
    <style>
        .dashboard-container {
            max-width: 600px;
            margin: 60px auto;
            background: #ffffff;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            text-align: center;
        }
        .welcome-title { color: #2c3e50; font-size: 1.8rem; margin-bottom: 10px; }
        .button-group { margin: 30px 0; }

        /* Botón estilizado para redirigir al formulario */
        .btn-nav {
            display: inline-block;
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            color: white;
            padding: 14px 28px;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 600;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .btn-nav:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
        }
        .btn-logout { color: #95a5a6; text-decoration: none; font-size: 0.9rem; }
        .btn-logout:hover { color: #e74c3c; }
    </style>
</head>
<body style="background-color: #f0f2f5;">
    <div class="dashboard-container">
        <h1 class="welcome-title">¡Bienvenido a Punto-pet! 🐾</h1>
        <p style="color: #7f8c8d;">Hola <strong>${usuarioLogueado}</strong>, gestiona los encuentros de tus mascotas.</p>

        <div class="button-group">
            <a href="/mascotas/registro" class="btn-nav">➕ Registrar nueva Mascota</a>
            <a href="/mascotas/mis-mascotas" class="btn-nav" style="background: #2ecc71;">📋 Ver Mis Mascotas</a>
        </div>

        <div style="margin-top: 20px;">
            <a href="/logout" class="btn-logout">Cerrar Sesión</a>
        </div>
    </div>
</body>
</html>
