# DIA 1

En el dia 1 comenzaremos con un breve demo de Infraestructura como Código (IaC por sus siglas en ingles "Infrastructure as Code") usando Terraform. Aprenderemos qué es IaC, para qué se usa, que problemas resuelve y finalmente estudiaremos el flujo básico de Terraform para adentrarnos en el uso 
correcto de la herramienta en un entorno productivo.

# Indice
1. [Prerequisitos](https://github.com/jcroyoaun/cerouno-terraform-course/edit/2207-devops/dia1/README.md#prerequisitos-)
2. [Ejercicio 1.1 - Instalar Terraform](https://github.com/jcroyoaun/cerouno-terraform-course/tree/2207-devops/dia1#ejercicio-11---instalar-terraform)
3. [Ejercicio 1.2 - Ejercicio 1.2 - IAM - Configurar AWS_ACCESS_KEY y AWS_SECRET_ACCESS_KEY](https://github.com/jcroyoaun/cerouno-terraform-course/tree/2207-devops/dia1#ejercicio-12---iam---configurar-aws_access_key-y-aws_secret_access_key)
4. [Ejercicio 1.3 - Ejercicio 1.3 - Clonar Repositorio](https://github.com/jcroyoaun/cerouno-terraform-course/tree/2207-devops/dia1#ejercicio-13---clonar-repositorio)
5. [Ejercicio 1.4 - Crear un recurso en AWS usando Terraform](https://github.com/jcroyoaun/cerouno-terraform-course/edit/2207-devops/dia1/README.md#ejercicio-14---crear-un-recurso-en-aws-usando-terraform)
6. [Ejercicio 1.5 - HCL Syntaxt / local_provider](https://github.com/jcroyoaun/cerouno-terraform-course/tree/2207-devops/dia1#ejercicio-15---hcl-syntax--ejemplo-con-local_provider)


## Prerequisitos :
* Tener cuenta de AWS (free tier)
* Tener AWS CLI instalado
* Tener Visual Studio Code instalado

## Pre requisito 1 - Cuenta de AWS
https://aws.amazon.com/es/premiumsupport/knowledge-center/create-and-activate-aws-account/

## Pre requisito 2 - AWS CLI instalado
https://docs.aws.amazon.com/es_es/cli/latest/userguide/getting-started-install.html

## Pre requisito 3 - Visual Studio Code
* Descarga : https://code.visualstudio.com/
* Configurar la terminal de Visual Studio Code (si eres usuario de Windows y prefieres una terminal con BASH, ve https://www.youtube.com/watch?v=Yn-ANAtDQ_0 para aprender a configurarlo) 
* Instalar Extension "Hashicorp Terraform"

---------------------------------------------
## Ejercicio 1.1 - Instalar terraform
https://www.terraform.io/downloads

## Ejercicio 1.2 - IAM - Configurar AWS_ACCESS_KEY y AWS_SECRET_ACCESS_KEY
IAM o Administración de identidades es un mecanismo de AWS que nos permitirá manejar nuestros recursos desde la terminal o línea de comandos desde nuestra computadora. Ligar una llave de acceso y un una contraseña a nuestra configuración dará paso a que podamos utilizar Terraform para manejar recursos de AWS.

### Para generar las llaves
* Nos vamos a : http://aws.amazon.com/
* En la esquina superior derecha se encuentra la opción "My Account"
* * Pasamos el cursor por "My Account" y vamos a "Account Settings"
* * * Buscamos nuestro nombre en la esquina superior derecha
* * * Presionamos nuestro nombre con un click y vamos al sub-menu "Security Credentials"
* * * * sub-menu: Security Credentials
* * * * Expandimos la opción "Access Keys"
* * * * Presionamos "Create New Access Key"
* * * * * NOTA : podemos descargar el archivo con las credenciales o copiar/pegar de las que nos aparecen en pantalla. Asegurense de guardarlas en un lugar accessible pues una vez que las perdemos, tendremos que generar otras nuevas.

### Para configurar las llaves
* En nuestra terminal tecleamos
aws configure

Nos van a salir 4 prompts :
* AWS Access Key ID -> aqui escribimos la llave de acceso
* AWS Secret Access Key -> aqui escribimos la llave secreta
* Default region name -> podemos dar el nombre de una region por default, seleccionemos la que nos plazca.
* Default output format -> yo prefiero JSON
* * https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-output-format.html

## Ejercicio 1.3 - Clonar Repositorio
Clonamos este repositorio localmente para trabajar en los laboratorios apuntando a nuestras cuentas propias de AWS free-tier

```
# Clonamos repositorio
git clone https://github.com/jcroyoaun/cerouno-terraform-course.git

# Accedemos directorio de el proyecto 
cd cerouno-terraform-course

# OPCIONAL : para abrir el proyecto en visual studio code, podemos usar el siguiente atajo si es que tenemos la terminal apropiadamente configurada
code .
```

## Ejercicio 1.4 - Crear un recurso en AWS usando Terraform
Seguimos el Terraform Core Workflow tal como Esta Descrito en la documentación https://www.terraform.io/intro/core-workflow :

```
# Accedemos al directorio de dia1 ejercicio 1.4
cd dia1/ejercicio1.4

# Revisamos si hay cambios pertinentes que hacer a main.tf dependiendo de las necesidades de la clase

# Utilizamos el core workflow de init/plan/apply

# Inicializamos Terraform
terraform init

# Corremos el Plan y observamos el output
terraform plan

# Si el Plan es correcto, hacemos Terraform Apply
terraform apply
```


## Ejercicio 1.5 - HCL Syntax / ejemplo con local_provider 
En este ejercicio vamos a utilizar un local provider para crear un archivo local en nuestra computadora.

La estructura basica que vamos a analizar va a ser esta :
```
<block> <parameters> {
    key1 = value1 #arguments
    key2 = value2 #arguments
}
```
Para correr el ejercicio :
```
# Hacemos cd al directorio del ejercicio1.5
cd ejercicio1.5

# Utilizamos el core workflow de init/plan/apply
terraform init

terraform plan

terraform apply

# BONUS : podemos usar terraform show para ver el resultado de la ejecución, incluyendo la ruta donde se creó el archivo y el "state". Más respecto al state en un futuro.
terraform show
```

### ejercicio1.5.1 - analizando la sintaxis 
Analicemos la sintaxis de el bloque de terraform que acabamos de ejecutar en el ejercicio1.5

```
resource "local_file" "pollo" {
	filename = "./pollos.txt"
	content = "Me encantan los pollos!!"
}
```

* resource - indica el tipo de bloque, es uno de los muchos tipos de bloque que hay, pero resource es mandatorio (debe haber al menos uno)
* "local_file" - el nombre del provider (local, en este caso, https://registry.terraform.io/browse/providers)
* * local = provider (https://registry.terraform.io/providers/hashicorp/local/latest/docs)
* * file = resource (https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
* * "pollos" - el nombre logico con el que vamos a identificar el recurso.
* Dentro de los brackets {} tenemos los argumentos escritos en formato key / value pair.

