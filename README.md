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



## 🔍 Crear la Imagen Docker 

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

Iniciamos los Contenedores Docker (3 instancias):

```bash
docker run -d -p 34000:30000 name container1 dockersparkprimer
docker run -d -p 34001:30000 name container2 dockersparkprimer
docker run -d -p 34002:30000 name container3 dockersparkprimer
```

![Image](https://github.com/user-attachments/assets/2701569b-5036-4761-9ebb-3647163a8977)


Ahora abrimos Docker Desktop dashboard y encontramos algo asi:


![Image](https://github.com/user-attachments/assets/08661bbf-8be3-43e2-8dc3-80f87ca43fbf)


Probamos que los conetendores estan funcionando correctamente

```bash
https://localhost:34000/index.html
```

![image](https://github.com/user-attachments/assets/031cb1d4-855a-4f89-a9dc-81577946afd2)


# Verificamos que los servicios fueron creados 

Usamos el siguiente comando:

```bash
docker ps
```

![Image](https://github.com/user-attachments/assets/50067f20-e98e-4434-9327-054f4f49c04b)


# Creamos un archivo llamado docker-compose para generar automáticamente una configuración docker

Creamos un archivo en la raiz que llamaremos "docker-compose.yml" y agregamos la siguiente informacion:

```bash
version: '2'


services:
    web:
        build:
            context: .
            dockerfile: Dockerfile
        container_name: web
        ports:
            - "8087:6000"
    db:
        image: mongo:3.6.1
        container_name: db
        volumes:
            - mongodb:/data/db
            - mongodb_config:/data/configdb
        ports:
            - 27017:27017
        command: mongod
        
volumes:
    mongodb:
    mongodb_config:
```


![Image](https://github.com/user-attachments/assets/2f7de5ec-afcd-48e6-ae5b-297a615668f9)


#  Ejecutamos el docker compose

Ejecutamos el siguiente comando:

```bash
docker-compose up -d
```

![Image](https://github.com/user-attachments/assets/e4c44c75-60d5-43ac-83b4-e26873fbcc35)


## 🔍 Subiendo la imagen a Docker Hub

Ahora en nuestro motor de docker local creamos una referencia a la imagen con el nombre del repositorio a donde deseamos subirla

```bash
docker tag dockersparkprimer sebas2374/labarep4
```

![Image](https://github.com/user-attachments/assets/9b2602b1-09d1-4913-8424-b7ea6352530a)


Ahora nos autenticamos en dockerhub 

```bash
docker login
```

![Image](https://github.com/user-attachments/assets/2accf3d6-488f-41a4-8445-7d856b20c178)


Para finzalizar empujamos la imagen al repositorio en DockerHub, con el siguente comando

```bash
docker push sebas2374/labarep4:latest
```


![Image](https://github.com/user-attachments/assets/9304e1a1-ca99-479d-88ec-db35b1597034)


Y para finalizar en la solapa de Tags de su repositorio en Dockerhub debería ver algo así:



![Image](https://github.com/user-attachments/assets/5b07bcb8-a90b-492a-b41f-883c4a17af37)



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

