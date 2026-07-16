# Punto-pet
Software que facilita el encuentro entre mascotas mediante perfiles para facilitar reproducción supervisada y controlada
Punto-pet es una aplicación web desarrollada bajo el marco de trabajo ágil Scrum. Su objetivo principal (Épica EP01) es permitir a los usuarios crear perfiles detallados de sus mascotas para gestionar encuentros y cruces con mascotas de la misma raza.
Este proyecto está construido con Java Spring Boot (MVC), páginas dinámicas JSP y utiliza PostgreSQL (mediante Docker) como motor de base de datos relacional para garantizar la integridad de los datos.
Guía de Ejecución Paso a Paso
Paso 1: Levantar la Base de Datos (PostgreSQL)
Para evitar conflictos con puertos comunes ocupados localmente, la base de datos se ejecuta en un contenedor Docker con mapeo a puertos personalizados.
Abre una terminal y posiciónate en la carpeta raíz del proyecto (donde se encuentra el archivo docker-compose.yml).
1. Clonar el proyecto
2. Abrir el IDE IntellijIDEA y abrir el proyecto clonado
3. En la raiz del proyecto, ejecutar el siguiente comando para descargar e iniciar la base de datos: docker-compose up -d
4. Verificar que el contenedor esté corriendo correctamente con: docker ps
5. Buscar el archivo PuntoPetApplication.java en la ruta src/main/java/com/puntopet/punto_pet/PuntoPetApplication.java y ejecutar la aplicación desde el IDE
6. Abrir el navegador y acceder a http://localhost:8080/ para ser redirigido automáticamente al formulario de registro de mascotas en http://localhost:8080/mascotas/registro
7. Para detener la base de datos, puedes usar el comando: docker-compose down -v

Comportamiento esperado: El sistema interceptará esta petición a la raíz y realizará una redirección automática (redirect:/mascotas/registro) enviándote directamente al formulario principal.
El correo para ingresar es: demo@correo.com
El pass: Demo123!
