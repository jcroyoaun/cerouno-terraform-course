# DIA 2

El dia de hoy aprenderemos más a fondo lo que son los providers, los distintos tipos y sus clasificaciones, así como convenciones de organización de los archivos de configuración de Terraform, uso de variables y algunos ejemplos de provisionar distintos recursos en AWS tales como S3, Dynamo DB, etc.

# Indice
1. [Providers](https://github.com/jcroyoaun/cerouno-terraform-course/edit/2207-devops/dia2/#providers)
using different providers

## Providers
Durante los ejercicios del día1, manipulamos recursos usando los recursos "local_file" del [provider local](https://registry.terraform.io/providers/hashicorp/local/latest/docs) así como "aws_iam_user" y "aws_instance" del [provider aws](https://registry.terraform.io/providers/hashicorp/aws/latest/docs). Con esto en mente podemos definir que un Provider es un plugin que puede ser utilizado por Terraform para comunicarse con una API de un servicio externo. En el caso de AWS, por ejemplo, entendemos que existen plugins que le permiten a Terraform interactuar por medio de APIs expuestas con los recursos de AWS. 

Existen distintas clasificaciones de Providers, algunos Local y AWS son de grado "Oficial", lo que significa que los plugins para comunicarse con los recursos son desarrollados y mantenidos por HashiCorp. Los siguientes en la lista son "Partners" que significa que son desarrollados y mantenidos por third parties que pasaron por un proceso de Partnership con HashiCorp. 

https://www.terraform.io/registry/providers

## Ejercicio 2.1 - Trabajando con multiples providers
El comando init descarga los plugins, apliquemos unicamente init al ejercicio2.1 para observar el output.

```
# Accedemos al directorio del ejercicio
cd ejercicio2.1

# Usamos unicamente terraform init
terraform init
```

## Ejercicio 2.2 - Multiples archivos en el directorio de configuración
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

## Variables en Terraform.

utput variables


## Dependencias en Terraform

### Explicitas

### Implicitas



we have to run terraform init each time we add a new provider to the file

terraform variables
-> variable.tf
-> variables.tfvar
-> export env vars
-> -var precedence

terraform dependencies
-> explicit
-> implicit

o

## Terraform state

## Other considerations .. (for each, datasources, mutable vs immutable infra)


## Más labs 

AWS labs (s3 bucket, dynamo DB)


