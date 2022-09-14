# DIA 3

Durante la primera mitad del día 3 concluiremos las bases teóricas de HCL, aprenderemos comandos adicionales al core workflow y su funcionamiento, aprenderemos sintaxis para estructuras de control y las diferencias entre infraestructura mutable e inmutable, para luego desarrollar el aprendizaje de los días 1 y 2 de una manera práctica aprendiendo a manipular a manipular más recursos de AWS como IAM policies, buckets en AWS S3 para manejo de state file remoto y otros skills que resultan absolutamente críticos para desarrollarnos en un puesto de DevOps con Terraform.

# Indice


# Ejercicio 3.1 - Saliendo del Core Workflow v2.
Este sencillo ejercicio nos va a ayudar a reafirmar la desviación de el flujo convencional reafirmando el uso de import. Discutiremos las diferencias con terraform refresh, así como una breve introducción a output variables, tema que será de gran importancia para el provisionamiento de infraestructura en un entorno complejo.

```
# Accedemos al directorio del ejercicio
cd ejercicio3.1

# Usamos el Core Workflow de Terraform
terraform init

terraform plan

terraform apply

```
Resolvemos el error con :
terraform import

Observamos el valor del Output Variable que tenemos configurado. Es importante establecer que, las Output Variables son de gran ayuda cuando tenemos creación de recursos que aun requiere intervención manual de un operador para pasar de una etapa del provisionamiento a otro. Vamos a suponer primero que vamos a utilizar AWS ECR para desplegar aplicaciones de un contenedor de Docker. Probablemente primero tengamos que crear una VPC para el ECS, luego querremos desplegar la URL generada de nuestro ECS, la cual usaremos posteriormente para empujar una imagen.

## Infraestructura Mutable vs Inmutable
En esta sección discutiremos brevemente el tema de Infraestructura Mutable e Inmutable y como este tema está intimamente ligado a los "LifeCycle Rules" de Terraform

## LifeCycle rules

```
lifecycle {
    ignore_changes = [
        tags
    ]
}
```

## Datasources
data block.
Se suelen usar cuando necesitamos utilizar el valor de un recurso que no está gestionado por Terraform. 

```
# Accedemos al directorio del ejercicio
cd ejercicio3.4

# Inspeccionamos el archivo
```

https://stackoverflow.com/questions/47721602/how-are-data-sources-used-in-terraform

## Meta Arguments
Hasta este punto, hemos creado recursos unicos utilizando Terraform. Un ejemplo más adecuado al trabajo diario, sería crear multiples elementos de un mismo recurso. Los Meta arguments se pueden usar dentro de cualquier bloque "Resource" para cambiar su comportamiento. Hemos visto algunos hasta ahora, tales como lifecycle (depends on, ignore changes, etc).

### Count
Para crear varias instancias de un mismo recurso, usamos count

### Ejercicio 3.5 - Count
Count es un Meta-Argument que nos permite definir un numero entero para repetir el numero de veces que se ejecutará un bloque resource.

#### Ejercicio 3.2 - Count en terraform
 Existen distintas maneras de trabajar con Count para añadir diversos elementos de la sintaxis HCL tal como podemos ver en el ejercicio 3.5

Instrucciones :
Ejecutaremos el Core Workflow de terraform en este bloque y analizaremos el output de terraform plan y apply para luego comparar con for each y sus diferencias intrinsecas.


### Ejercicio 3.6 - For each
La opcion count crea los recursos como una lista y for each como un mapa.

For each solo puede iterar un map o un set, pero hay maneras de hacer casting o conversiones de estos tal como vemos en el ejercicio 3.6.

## Manejo de versiones de Providers
Como hemos discutido en dia1 y dia2, existen ciertos casos donde es importante tener cautela con la version de los plugins del Provider que vamos a descargar en nuestro workspace. 

Hemos visto algunos ejercicios donde declaramos el bloque Terraform con la intención de dar una breve introducción a este.

El bloque terraform se utiliza para realizar configuraciones relacionados a Terraform. En este ejemplo, utilizamos otro bloque dentro de terraform llamado required_providers y aqui dentro podemos tener tantos argumentos como providers de acuerdo a los que necesitamos usar.

```
terraform
  required_providers {
      local = {
          source = "hashicorp/local"
          version = "1.4.0"
      }
  }
```
Nota : una pregunta de examen es aprender a leer notaciones de las versiones de terraform : 

```
version ~> "1.2"
```
Significa 1.2 o mayor hasta el 1.9 (el simbolo busca de acuerdo a la version mayor).



## Bakend remotos con S3 (REMOTE STATE FILE)
Hasta ahora, hemos utilizado el bloque de terraform unicamente para el manejo de versiones, a partir de aqui, aprenderemos a almacenar el state file de manera remota usando AWS S3.

Nota :
Para otros proveedores existen otros Providers para este tipo de almacenamiento, tales como AzureRM, GCS, Local

# Accedemos al directorio del ejercicio
cd ejercicio2.10
Aqui aprenderemos la funcion de count en terraform utilizando distintas tecnicas que nos ayudaran en infraestructura escalable.

Cerrando con esta iteración de State
Es importante saber que el state file guarda contraseñas y que en una implementación en un proyecto escalable, esto puede ocasionar problemas de seguridad que analizaremos más delante.

Dependencias en Terraform
Explicitas
Reservado para lAB

Implicitas
Reservado para lAB

Other considerations .. (for each, datasources, mutable vs immutable infra)
Más labs
AWS labs (s3 bucket, dynamo DB)

NOTAS EXTRA : we have to run terraform init each time we add a new provider to the file

tipos de top level blocks https://www.udemy.com/course/hashicorp-certified-terraform-associate-on-azure-cloud/learn/lecture/27144470#overview