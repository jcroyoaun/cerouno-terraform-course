# DIA 2

El dia de hoy aprenderemos más a fondo lo que son los providers, los distintos tipos y sus clasificaciones, así como convenciones de organización de los archivos de configuración de Terraform, uso de variables y algunos ejemplos de provisionar distintos recursos en AWS tales como S3, Dynamo DB, etc.

# Indice
1. [Providers](https://github.com/jcroyoaun/cerouno-terraform-course/edit/2207-devops/dia2/#providers)
using different providers

## Providers
Durante los ejercicios del día1, manipulamos recursos usando los recursos "local_file" del [provider local](https://registry.terraform.io/providers/hashicorp/local/latest/docs) así como "aws_iam_user" y "aws_instance" del [provider aws](https://registry.terraform.io/providers/hashicorp/aws/latest/docs). Con esto en mente podemos definir que un Provider es un plugin que puede ser utilizado por Terraform para comunicarse con una API de un servicio externo. En el caso de AWS, por ejemplo, entendemos que existen plugins que le permiten a Terraform interactuar por medio de APIs expuestas con los recursos de AWS. 

Existen distintas clasificaciones de Providers, algunos Local y AWS son de grado "Oficial", lo que significa que los plugins para comunicarse con los recursos son desarrollados y mantenidos por HashiCorp. Los siguientes en la lista son "Partners" que significa que son desarrollados y mantenidos por third parties que pasaron por un proceso de Partnership con HashiCorp. 

https://www.terraform.io/registry/providers

Ejercicio 2.1 - Trabajando con 
El comando init, dentro del Core Workflow descarga los plugins 


we have to run terraform init each time we add a new provider to the file

terraform variables
-> variable.tf
-> variables.tfvar
-> export env vars
-> -var precedence

terraform dependencies
-> explicit
-> implicit

output variables

terraform state

Other considerations .. (for each, datasources, mutable vs immutable infra)


AWS labs (s3 bucket, dynamo DB)


