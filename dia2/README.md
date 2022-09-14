# DIA 2

El dia de hoy aprenderemos más a fondo lo que son los providers (no confundir con provisioners), los distintos tipos y sus clasificaciones, así como convenciones de organización de los archivos de configuración de Terraform, uso de variables y algunos ejemplos de provisionar distintos recursos en AWS tales como S3, Dynamo DB, etc.

# Indice
1. [Providers](https://github.com/jcroyoaun/cerouno-terraform-course/edit/2207-devops/dia2/#providers)
2. [Ejercicio 2.1 - Trabajando con multiples providers](https://github.com/jcroyoaun/cerouno-terraform-course/blob/2207-devops/dia2/README.md#ejercicio-21---trabajando-con-multiples-providers)
3. [Ejercicio 2.2 - Multiples archivos en el directorio de configuración](https://github.com/jcroyoaun/cerouno-terraform-course/blob/2207-devops/dia2/README.md#ejercicio-22---multiples-archivos-en-el-directorio-de-configuraci%C3%B3n)
4. [Ejercicio 2.3 - Identificando el tipo de Provider](https://github.com/jcroyoaun/cerouno-terraform-course/blob/2207-devops/dia2/README.md#ejercicio-23---identificando-el-tipo-de-provider)
5. [Variables en Terraform](https://github.com/jcroyoaun/cerouno-terraform-course/blob/2207-devops/dia2/README.md#variables-en-terraform)
6. [Ejercicio 2.4 - Primeras input variables](https://github.com/jcroyoaun/cerouno-terraform-course/blob/2207-devops/dia2/README.md#ejercicio-24---primeras-input-variables)
7. [Ejercicio 2.5 - Output variables en archivos separados](https://github.com/jcroyoaun/cerouno-terraform-course/blob/2207-devops/dia2/README.md#ejercicio-25---output-variables-en-archivos-separados)
8. [Ejercicio 2.6 - Usando otros tipos de variables]()
9. [Ejercicio 2.7 - ](https://github.com/jcroyoaun/cerouno-terraform-course/tree/2207-devops/dia2#ejercicio-27--) 


## Providers
Durante los ejercicios del día1, manipulamos recursos usando los recursos "local_file" del [provider local](https://registry.terraform.io/providers/hashicorp/local/latest/docs) así como "aws_iam_user" y "aws_instance" del [provider aws](https://registry.terraform.io/providers/hashicorp/aws/latest/docs). Con esto en mente podemos definir que un Provider es un plugin que puede ser utilizado por Terraform para comunicarse con una API de un servicio externo. En el caso de AWS, por ejemplo, entendemos que existen plugins que le permiten a Terraform interactuar por medio de APIs expuestas con los recursos de AWS. 

Existen distintas clasificaciones de Providers, algunos Local y AWS son de grado "Oficial", lo que significa que los plugins para comunicarse con los recursos son desarrollados y mantenidos por HashiCorp. Los siguientes en la lista son "Partners" que significa que son desarrollados y mantenidos por third parties que pasaron por un proceso de Partnership con HashiCorp. 

https://www.terraform.io/registry/providers

### Ejercicio 2.1 - Trabajando con multiples providers
El comando init descarga los plugins, apliquemos unicamente init al ejercicio2.1 para observar el output.

```
# Accedemos al directorio del ejercicio
cd ejercicio2.1

# Usamos unicamente terraform init
terraform init
```

### Ejercicio 2.2 - Multiples archivos en el directorio de configuración
En este ejercicio vamos a aprender acerca de los archivos de configuracion en Terraform y como decide Terraform el flujo de provisionamiento de recursos.
```
# Accedemos al directorio del ejercicio
cd ejercicio2.2

# Usamos el Core Workflow de Terraform
terraform init

terraform plan
```

Hagamos una pequeña pausa para pensar, cual será el output después de correr Terraform apply

```
# Corremos terraform apply
terraform apply
```

### Ejercicio 2.3 - Identificando el tipo de Provider
Hasta el momento hemos aprendido que cuando corremos Terraform init, se instalan los plugins de un proveedor que nos permite comunicarnos con las APIs expuestas del proveedor para manipular y configurar sus distintos recursos. Hemos usado solo "Official Providers" como Local, Azure y AWS. En este pequeño ejercicio vamos a observar el output de terraform init para averiguar que tipo de proveedor es el declarado en el archivo de Configuración, nos vamos a apoyar en la documentación oficial para averiguar el tipo https://registry.terraform.io/browse/providers

```
# Accedemos al directorio del ejercicio
cd ejercicio2.3

# Usamos el Core Workflow de Terraform
terraform init

```


## Variables en Terraform.
Hasta el momento hemos usado variables "hardcoded" lo cual limita la reusabilidad. A partir de esta sección haremos la inclusión de variables en nuestros ejemplos y veremos los distintos tipos que existen y su comportamiento.

Comenzaremos con una introducción 
Input Variables serve as parameters for a Terraform module, so users can customize behavior without editing the source.

Output Values are like return values for a Terraform module.

Local Values are a convenience feature for assigning a short name to an expression.


Comencemos con un ejercicio de variables usando el recurso aws_iam_user. Si se siguieron los ejercicios del dia1, este ejercicio nos servirá para aprender comandos fuera del flujo normal de Terraform así como una breve introducción al state file que veremos con mayor detalle en delante.

terraform variables
-> variable.tf
-> variables.tfvar
-> export env vars
-> -var precedence

### Ejercicio 2.4 - Primeras input variables

```
# Accedemos al directorio del ejercicio
cd ejercicio2.4
```
En este ejercicio, vamos a utilizar el bloque de variables para declarar valores dentro del argumento "default" de estas para posteriormente expandir dichas variables en el bloque de resource.

```
# Usamos el Core Workflow de Terraform hasta plan...
terraform init

terraform plan
```

En este punto, podemos ver que el plan es agregar un recurso nuevo, sin embargo, si estamos siguiendo el ejercicio con la intención correcta, deberíamos asumir que algo anda mal, puesto que ya creamos el usuario en nuestra cuenta de AWS el día de ayer. 

```
# Prosigamos con terraform apply
terraform apply
```
Terraform nos muestra un output con un mensaje de error de tipo
```
EntityAlreadyExists
```

Esto es por que ya tenemos un usuario con esas mismas especificaciones creado como recurso en nuestra cuenta de AWS, pero...

* Por qué no nos mostró un error durante terraform plan?
* Hay algo que se pueda hacer al respecto?

terraform import...

### Ejercicio 2.5 - Output variables en archivos separados
Volveremos a realizar el ejercicio de  aws_iam_user con variables pero ahora tendremos las variables organizadas más de acuerdo a los estándares recomendados.
```
# Accedemos al directorio del ejercicio
cd ejercicio2.5

# Resolvemos el ejercicio de las variables
# Usamos el Core Workflow de Terraform
terraform init

terraform plan

terraform apply
```



#### Anatomía del bloque variable 
```
variable "variable_name" {
  default = "valor" # mandatorio
  type = string #no es mandatorio cuando hay sintaxis que implicitamente revela el tipo
  description = "descripcion de la variable" #opcional
}
```


### Ejercicio 2.6 - Ejemplo de Tipos de Variable
En este ejercicio, veremos un ejemplo de utilización de variables usando una lista. Primero con asignación de tipo implicita y luego explicitamente de varias maneras.

Nota: Veamos que usamos el proveedor de tipo Random por primera vez.


### Ejercicio 2.7 - 
Aquí aprenderemos del orden de precedencia de las variables en Terraform y los diferentes tipos de variables que existen.

1. Env Variables
```
export TF_VAR_filename
```

2. terraform.tfvars

3. *.auto.tfvars (orden alfabetico)

4. -var o -var-file (command line flags)


En este ejercicio 2.7 correremos el core workflow tal cual como tenemos nuestras declaraciones y luego jugaremos un poco con los distintos tipos de declaraciones para entender la diferencia entre tfvars, .tf, etc...


### Ejercicio 2.8 - Resource attributes
Aquí aplicaremos el término resource attribute para que dos bloques puedan intercambiar información o intercambiar variables


```
# Accedemos al directorio del ejercicio
cd ejercicio2.8
```

Corremos el ejercicio para ver la inclusion de variables de otro recurso usadas por el proveedor Local.

Nota: explorar depends_on = [ random_pet.my-pet ]

## Terraform state
El archivo state es un archivo que contiene información referente a la infraestructura tal como la conocemos. Terraform crea/actualiza este archivo después de un terraform apply para reconciliar la infraestructura tal cual como existe.

### Remote state file
Por temas de seguridad y predictibilidad, en un entorno de trabajo real, con varios colaboradores, querremos mantener el state file de manera remota. Aprenderemos más de state files en un lab en el futuro.


### Ejercicio 2.9 - Importando infraestructura ya existente.
```
# Accedemos al directorio del ejercicio
cd ejercicio2.9

# Usamos el Core Workflow de Terraform
terraform init

terraform plan

terraform apply
```

Resolvemos el error con :

```
terraform import
```

### Ejercicio 2.10 - Count en terraform
```
# Accedemos al directorio del ejercicio
cd ejercicio2.10
```

Aqui aprenderemos la funcion de count en terraform utilizando distintas tecnicas que nos ayudaran en infraestructura escalable.



### Cerrando con esta iteración de State 
Es importante saber que el state file guarda contraseñas y que en una implementación en un proyecto escalable, esto puede ocasionar problemas de seguridad que analizaremos más delante.


## Dependencias en Terraform


### Explicitas
Reservado para lAB
### Implicitas
Reservado para lAB

## Other considerations .. (for each, datasources, mutable vs immutable infra)


## Más labs 

AWS labs (s3 bucket, dynamo DB)



NOTAS EXTRA : we have to run terraform init each time we add a new provider to the file

tipos de top level blocks
https://www.udemy.com/course/hashicorp-certified-terraform-associate-on-azure-cloud/learn/lecture/27144470#overview

