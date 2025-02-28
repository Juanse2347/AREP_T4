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




## 🚀 AWS

# Creamos una instancia en AWS EC2.


![Image](https://github.com/user-attachments/assets/a102160f-35c0-45f0-ad8f-e9fc7839722f)


Vamos a instalar Docker en nuestra instancia

```bash
sudo yum update -y
sudo yum install docker
```

![Image](https://github.com/user-attachments/assets/f924b2cd-1f0f-411c-9f01-cbc67184b835)


Ahora iniciamos el servidor Socket

```bash
sudo service docker start
```

Configuramos el usuario en el grupo de docker para no tener que ingresar “sudo” cada vez que invoca un comando

```bash
sudo usermod -a -G docker ec2-user
```

![Image](https://github.com/user-attachments/assets/27a860aa-c2f0-4120-b11e-f77bd96f2c99)


A partir de la imagen creada en Dockerhub cree una instancia de un contenedor docker independiente de la consola (opción “-d”) y con el puerto 6000 enlazado a un puerto físico de su máquina (opción -p):

```bash
docker run -d -p 42000:6000 --name firstdockerimageaws usuariodedocker/nombredelrepo
```

![Image](https://github.com/user-attachments/assets/5f8fdc17-d3d2-46a7-abd1-3c240b89cd7c)


![Image](https://github.com/user-attachments/assets/d811801a-545b-4f8b-9074-6fe878628129)


Ahora abrimos  los puertos de entrada del security group de la máxima virtual para acceder al servicio


Ahora con:

```bash
http://ec2-34-227-105-59.compute-1.amazonaws.com:42000/index.html
```


![Image](https://github.com/user-attachments/assets/d644fdb6-743a-4246-ab1c-3ab00e15684b)


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


## :office: Desplieqgue ##

Vamos a ejecutar el servidor como un proceso en segundo plano o configurar un servicio systemd, de la siguiente manera:

```bash
java -cp"./classes:./dependency/* co.edu.eci.arep.HttpServer co.edu.eci.arep.GreetingController
```

## :cd: Construido con ## 

 - Java - Lenguaje principal utilizado
 - Maven - Para la gestión de dependencias y automatización
 - Docker - Plataforma de código abierto que permite crear, ejecutar, administrar y actualizar contenedores


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

