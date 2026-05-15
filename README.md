# Punto-pet
Software que facilita el encuentro entre mascotas mediante perfiles para facilitar reproducción supervisada y controlada
Punto-pet es una aplicación web desarrollada bajo el marco de trabajo ágil Scrum. Su objetivo principal (Épica EP01) es permitir a los usuarios crear perfiles detallados de sus mascotas para gestionar encuentros y cruces con mascotas de la misma raza.
Este proyecto está construido con Java Spring Boot (MVC), páginas dinámicas JSP y utiliza PostgreSQL (mediante Docker) como motor de base de datos relacional para garantizar la integridad de los datos.
Guía de Ejecución Paso a Paso
Paso 1: Levantar la Base de Datos (PostgreSQL)
Para evitar conflictos con puertos comunes ocupados localmente, la base de datos se ejecuta en un contenedor Docker con mapeo a puertos personalizados.
Abre una terminal y posiciónate en la carpeta raíz del proyecto (donde se encuentra el archivo docker-compose.yml).
Ejecuta el siguiente comando para descargar la imagen y levantar el contenedor en segundo plano:
docker-compose up -d
Ejecutar la Aplicación Spring Boot
Una vez que la base de datos está activa, puedes levantar la aplicación backend.

Opción A: Desde el IDE (Recomendado para revisión de código)
Abre el proyecto en tu IDE
Navega por el árbol de directorios hasta encontrar el archivo principal de ejecución. La ruta exacta es:
src/main/java/com/puntopet/punto_pet/PuntoPetApplication.java
Haz clic derecho sobre el archivo PuntoPetApplication.java y selecciona "Run" (o el ícono de "Play").
Acceder a la Aplicación
La aplicación cuenta con un enrutamiento inteligente configurado para facilitar la navegación desde el primer momento.

Abre tu navegador web de preferencia (Chrome, Firefox, Edge).

Ingresa a la siguiente URL raíz:
http://localhost:8080/

Comportamiento esperado: El sistema interceptará esta petición a la raíz y realizará una redirección automática (redirect:/mascotas/registro) enviándote directamente al formulario principal.

URL final: Terminarás visualizando el formulario de la primera Historia de Usuario (HU01) en:
http://localhost:8080/mascotas/registro