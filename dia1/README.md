# DIA 1

En el dia 1 comenzaremos con un breve demo de Infraestructura como Código (IaC por sus siglas en ingles "Infrastructure as Code") usando Terraform. Aprenderemos qué es IaC, para qué se usa, que problemas resuelve y finalmente estudiaremos el flujo básico de Terraform para adentrarnos en el uso correcto de la herramienta en un entorno productivo.

## Prerequisitos :
* Tener cuenta de AWS (free tier)
* Tener AWS CLI instalado
* Tener Visual Studio Code instalado

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
