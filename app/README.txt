# README

## Instalación de la aplicación.

### Requerimientos de software:
Para la instalación de la aplicación es necesario el siguiente software:
  - Maven 3.6.0
  - Java 8
  - SQL Server 2017 (No se requiere una instancia local pero sí el usuario y la contraseña para alguna instancia)

### Configuración:
Para configurar la aplicación se tiene que copiar el archivo en /src/main/resources/application.example.properties como application.properties en el mismo directorio, y configurarlo con el nombre de la base de datos (si se usó el archivo ddl.sql de nosotros, ya viene por defecto el nombre), el usuario y la cotraseña del super usuario del SMBD.

### Ejecución de la aplicación:
Ejecutar el comando desde este mismo directorio (al mismo nivel que el archivo pom.xml):
  mvn clean spring-boot:run 

### Visualización del sitio web:
Por defecto se ejecuta en el puerto 8080, con lo cual se tiene que acceder a localhost:8080 para entrar a la página principal del sitio web.

## Descripción de la aplicación.

En la aplicación utilizamos el patrón MVC para poder crear una plataforma de facil acoplamiento entre sus componentes. Como se ve en la esetructura más adelante creamos repositorios para acceder a los datos en nuestra BD, controladores para proporcionar facilmente esta información y vistas para mostrarla en una interfaz gráfica. 

### Estructura de la aplicación:

app
  |
  |--src (contenido de el proyecto)
  |   |
  |   |--main
  |   |   |
  |   |   |--java
  |   |   |   |
  |   |   |   |--taqueroMucho
  |   |   |   |   |
  |   |   |   |   |--config (configuraion para conectar a la base de datos)
  |   |   |   |   |--model  (Clases para mapear los datos de la base de datos, tablas y columnas)
  |   |   |   |   |--resources (controladores para crear los End Points que se van a exponer en el servicio)
  |   |   |   |   |--repository (Clases para acceder a la base de datos)
  |   |   |   |   |--Application.java (Clase principal de la aplicacion)
  |   |   |   |
  |   |   |   |--resources
  |   |   |   |   |
  |   |   |   |   |--templates (templates con las vistas utilizadas en el sitio web)
  |   |   |   |   |--static (archivos estáticos utilizados en el sitio web y entry point index.html)
  |   |   |   |   |--application.properties (propiedades para realizar la conexión a la base de datos)
  |   |   |   |   |--application.queries.properties (queries para ejecutar a la base de datos)
  |
  |--pom.xml (definición de biliotecas que ocupará el proyecto)
  |--taqueroMucho.uml (archivo con el diagrama UML de las clases utilizadas en la aplicación)