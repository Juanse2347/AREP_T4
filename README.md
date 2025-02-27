# Taller de de modularización con virtualización e Introducción a Docker

El taller consiste en crear una aplicación web pequeña usando SPRING. Una vez tengamos esta aplicación procederemos a construir un container para docker para la aplicación y los desplegaremos y configuraremos en nuestra máquina local. Luego, crearemos un repositorio en DockerHub y subiremos la imagen al repositorio. Finalmente, crearemos una máquina virtual de en AWS, instalaremos Docker , y desplegaremos el contenedor que acabamos de crear.


## 📌 Características

```bash
Aplicación Web en Java con Spring Boot
```

La aplicación utiliza el marco de trabajo Spring Boot para construir una sencilla API REST que responde con un saludo personalizado.

```bash
Contenerización con Docker
```

Se crea una imagen de Docker para encapsular la aplicación Java, lo que permite ejecutar la aplicación en cualquier máquina que soporte Docker.
  
```bash
Despliegue en AWS
```

Una vez que la aplicación está contenida en Docker, se sube a DockerHub y luego se despliega en una máquina virtual de AWS, permitiendo la ejecución remota.

```bash
Ejecución Local y Remota
```
Se ejecuta localmente en contenedores Docker y también puede ser desplegada en una máquina virtual en AWS.


## 🛠️ Requisitos
- Java 11 o superior
- Git
- Maven
- Docker
- AWS EC2


## 🚀 Instalación y Ejecución
### 1️⃣ Clonar el repositorio
```bash
git clone https://github.com/Juanse2347/AREP_T4
cd AREP_T4
```

### 2️⃣ Compilar el proyecto con Maven
```bash
mvn clean install
```

![Image](https://github.com/user-attachments/assets/9a3392f2-fd28-4615-bfa2-ea5b9fdf9c00)


### 3️⃣ Ejecutar el servidor

```bash
java -cp"./classes:./dependency/* co.edu.eci.arep.HttpServer co.edu.eci.arep.GreetingController
```

![Image](https://github.com/user-attachments/assets/b91ad929-476d-4574-b792-751c9c93b2c9)


### 4️⃣ Probar con un navegador o `curl`
```bash
curl http://localhost:30000/
```


### 🔍 Crear la Imagen Docker

Creamos un archivo denominado Dockerfile con el siguiente contenido:

```bash
Dockerfile
```

![Image](https://github.com/user-attachments/assets/328d3d09-3a41-4294-9547-b5ec5723817f)

# Construir la Imagen de Docker

```bash
docker build --tag dockersparkprimer .
```

![Image](https://github.com/user-attachments/assets/bcc1a45f-9223-41a8-8d63-1f0697763409)


# Ejecutar los Contenedores Docker Localmente

```bash
docker run -d -p 34000:30000 name container1 dockersparkprimer
docker run -d -p 34001:30000 name container2 dockersparkprimer
docker run -d -p 34002:30000 name container3 dockersparkprimer
```

![Image](https://github.com/user-attachments/assets/2701569b-5036-4761-9ebb-3647163a8977)



## 🔍 Pruebas de extremo a extremo ##

Pruebas del navegador 

Probamos que nuestro servicio este funcionando correctamente

```bash
http://localhost:30000/
```




## 🔍 Pruebas de Estilo de Codificacion ##

Con el siguiente comando realizamos las pruebas de estilo de codificación son aquellas que verifican que el código sigue las convenciones y buenas prácticas del equipo o la comunidad

```bash
mvn checkstyle:check
```

![Image](https://github.com/user-attachments/assets/6c5a4c16-9c71-463d-9629-59f5c976213a)

## 🔍 Probando el REST ##

Vamos a comprobar los endpoints de nuestra API

```bash
curl -X GET http://localhost:30000/App/rests/greeting?name=Sebas
```

Esperamos lo siguiente:

![Image](https://github.com/user-attachments/assets/b8ba46e0-740b-4d87-9d95-c7be7d270987)


Prueba el endpoint que devuelve PI

```bash
curl -X GET "http://localhost:30000/App/pi"
```

Esperamos lo siguiente:

![Image](https://github.com/user-attachments/assets/19025246-5536-489e-8780-92d8b1bfa35b)


## 🔍 Pruebas automatizadas ##

Este proyecto incluye pruebas automatizadas para garantizar su correcto funcionamiento. Ejecuta los tests con:

```bash
cd src
javac -cp .:/path/to/junit-4.12.jar co/edu/eci/arep/MicroServerTest.java
```

## :office: Desplieqgue ##

Vamos a ejecutar el servidor como un proceso en segundo plano o configurar un servicio systemd, de la siguiente manera:

```bash
java -cp target/classes co.edu.eci.arep.HttpServer co.edu.eci.arep.GreetingController
```

## :cd: Construido con ## 

 - Java - Lenguaje principal utilizado
 - Maven - Para la gestión de dependencias y automatización
 - JUnit - Para pruebas automatizadas

## :busts_in_silhouette: Contribuciones ##

Lea [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) para obtener detalles sobre nuestro código de conducta y el proceso para enviarnos solicitudes de extracción.

## :school_satchel: Control de Versiones ##

Usamos [SemVer](http://semver.org/) para controlar las versiones.

## :bust_in_silhouette: Autor ##

* **Juan Sebastian Sanchez** - *Trabajo Inicial* - [Juanse2347](https://github.com/Juanse2347)


## 📄 Licencia
Este proyecto está bajo la licencia [LICENSE](LICENSE). ¡Siéntete libre de contribuir! 😊


## :wave: Expresiones de Gratitud ##

- Inspiracion
- Compromiso

