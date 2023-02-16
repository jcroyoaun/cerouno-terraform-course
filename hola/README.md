## Ejercicio de Variables en Terraform.

En los ejercicios del dia 2 :

ejercicio2.7

podemos explorar algunos temas de el uso y orden de precedencia de variables de terraform.

#### Lo que tenemos: 
En la version actual, el archivo se genera con el valor asignado a la variable "content".

#### Lo que queremos lograr:
El resultado final de este ejercicio, seria poder crear un archivo .txt con contenido random generado por el modulo random de terraform.

Durante el ejercicio estudiaremos el orden de precedencia de variables en terraform.



### Preambulo
por ejemplo, podemos observar que en el archivo del ejercicio2.7 de nombre variables.tf tenemos variables declaradas sin asignacion :

```
cat variables.tf 
variable "filename" {
  
}

variable "content" {
  
}

variable "prefix" {

}

variable "separator" {

}

variable "length" {
 
}
```

### Parte 1)
Como primer ejercicio, llenemos el contenido de variables.tf

```
variable "filename" {
  default="filename.txt"
}
variable "separator" {
 default="-"
}

variable "content" {
 default="some content"
}

variable "length" {
 default=2
}

variable "prefix" {
 default="Mr."
}
```
Y luego exploremos el resultado usando el terraform core workflow.


Podemos ver que se corrio el modulo correctamente.

Una lectura suplementaria para entender lo que ocurre se encuentra en la documentacion del modulo random https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet

Terraform sugiere usar este modulo de crear nombres "de mascotas" para ejemplificar temas de Infraestructura Mutable e Inmutable usando nombres random para nuestros servidores que, por su naturaleza random, cambian en cada ejecucion.

#### Resultado:

1. Se genera un archivo filename.txt con contenido "some content".

2. Analizando el output del terraform apply, podemos ver que la creacion del recurso "random-pet" funciono perfectamente, sin embargo, no estamos haciendo nada con este contenido excepto mostrarlo en pantalla:

```
random_pet.my-pet: Creating...
random_pet.my-pet: Creation complete after 0s [id=Mr.-capital-monarch] <----- aqui podemos ver el output de random.
local_file.mascota: Creating...
local_file.mascota: Creation complete after 0s [id=94e66df8cd09d410c62d9e0dc59d3a884e458e05]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```


### Parte 2) 
Ahora, vamos a lograr que el valor que genera el resource random, se escriba en el filename.txt. Para esto, hay que modificar el archivo main.tf 

de
```
resource "local_file" "mascota" {
    filename = var.filename
    content = var.content
}

resource "random_pet" "my-pet" {
    prefix = var.prefix
    separator = var.separator
    length = var.length
}
```

a

```
resource "local_file" "mascota" {
    filename = var.filename
    content = "My favorite pet is ${resource.random_pet.my-pet.id}"
}

resource "random_pet" "my-pet" {
    prefix = var.prefix
    separator = var.separator
    length = var.length
}
```

Observemos que ahora, estamos asignando el valor de content con una interpolacion usando la sintaxis:

${}

junto con una sintaxis propia de HCL que nos permite acceder al valor producido por un bloque resource, en este caso siendo "random_pet" utilizando su nombre logico, en este caso "my-pet"
```
"My favorite pet is ${resource.random_pet.my-pet.id}"
```

Una vez ejecutando
```
terraform apply
```

Podemos ver como ahora se guarda en el contenido del archivo un nombre random generado por los parametros que previamente establecimos en el archivo de variables.tf

```
cat filename.txt 
Mr.-capital-monarch
```


Bonus: 
Para este punto, podemos borrar la variable content de "variables.tf", asi es como debe quedar:

```
cat variables.tf 
variable "filename" {
  default="filename.txt"
}
variable "separator" {
 default="-"
}

variable "length" {
 default=2
}

variable "prefix" {
 default="Mr."
}

```

### Parte 3)
Ahora exploraremos lo que es un data source en terraform. Un datasource es solamente un resource block convertido en Solo Lectura.

Estudio de datasources:
Durante el curso de cerouno de terraform, hemos visto como hay resource blocks que nos permiten modificar infraestructura de manera declarativa, esto quiere decir, escribimos un archivo .tf que contenga la infraestructura como quisieramos que quedara, y esta va y se crea de manera idempotente.

Aqui un ejemplo de como, usando local provider, creamos un archivo .txt que tiene contenido:
```
resource "local_file" "hola" {
    filename = "archivo_hola.txt"
    content = "Hola mundo!"
}
```

Si colocamos este script en un archivo llamado main.tf en un directorio aislado, al ejecutarlo con el core workflow
```
terraform init
terraform plan
terraform apply
```

Esto resulta en un archivo llamado

```
cat archivo_hola.txt
Hola mundo!
```

Ahora, si convertimos este resource block en un datasource, veremos como Se Convierte En Un Bloque de solo lectura, o sease que, genera informacion que no modifica los recursos en El Mundo Real, sino que lee de ellos y se convierte en un medio para transmitir la informacion de manera programatica:

```
data "local_file" "hola" {
    filename = "archivo_hola.txt"
    content = "Hola mundo!"
}
```
Notese que la palabra resource de este bloque se intercambio por data, lo cual efectivamente lo convierte en un datasource

Al hacer un 
```
terraform apply
```

Vemos como el resultado es:
```
 terraform apply     
╷
│ Error: Invalid Configuration for Read-Only Attribute
│ 
│   with data.local_file.hola,
│   on main.tf line 3, in data "local_file" "hola":
│    3:     content = "Hola mundo!"
│ 
│ Cannot set value for this attribute as the provider has marked it as read-only. Remove the
│ configuration line setting the value.
│ 
│ Refer to the provider documentation or contact the provider developers for additional information
│ about configurable and read-only attributes that are supported.
╵
```

Esto ocurre por que el argumento "content" del bloque de resource, sirve para escribir informacion al archivo, y al estar convirtiendolo en un datasource, es ahora solo lectura, el cual, efectivamente se encargaria de leer un archivo, pero no de escribir en el (o modificarlo de ninguna manera)

Para arreglar esto:

```
data "local_file" "hola" {
    filename = "archivo_hola.txt"
}
```

hacemos un 
```
terraform apply
```

Mucho ojo, hasta aqui, hemos convertido el resource block en un datasource, pero al haber cambiado el recurso, nuestro archivo_hola.txt ha sido destruido tambien.

Para recrear el archivo, y luego corramos de nuevo

```
terraform apply
```

En este punto, tenemos un datasource creado, para comprobar que efectivamente funciona, modifiquemos una vez mas el main.tf para incluir una output varibale que nos muestre el contenido de el datasource:

```
data "local_file" "hola" {
  filename = "archivo_hola.txt"
}

output "hola_content" {
  value = data.local_file.hola
}
```
Aqui estamos usando un output variable y le asignamos el valor de data, por datasource, local_file siendo el modulo usado por el datasource, y luego hola, que es el valor logico que dimos a este bloque.

```
data.local_file.hola
```

### Parte 3)
Volviendo al ejemplo inicial del ejercicio 2.7, me gustaria ahora que nuestro main se viera de este modo, 

main.tf
```
resource "local_file" "mascota" {
    filename = var.filename
    content = "${resource.random_pet.my-pet.id}"
}

resource "random_pet" "my-pet" {
    prefix = var.prefix
    separator = var.separator
    length = var.length
}
```

```
variable "filename" {
  default = "defaultfile.txt"
}
```

Recordemos que en este punto nuestro variables.tf se ve asi:
variables.tf
```
variable "filename" {
 default="filename.txt" 
}
variable "separator" {
 default="-"
}

variable "length" {
 default=2
}

variable "prefix" {
 default="Mr."
}
```

Hagamos uso de la bandera flag para sobre escribir la variable llamada filenamae, descrita en nuestro variables.tf

```
terraform apply -var filename=anotherfilename.txt
```

Con este comando, estamos indicando que el valor de la variable filename, debe ser sobreescrita y que pereferimos entonces la llamada anotherfilename.txt


A esto se le llamada una bandera de variable, o -var flag y se puede usar para sobre escribir las variables que creamos convenientes:

```
terraform apply -var filename=anotherfilename.txt -var length=3
```

NOTA: LAS VARIABLES DEFINIDAS EN variables.tf SE CONOCEN COMO "default variables", y tienen menor orden de precedencia que las variables de bandera.


### Parte 4)
Usando una variable de entorno:

En los sistemas operativos, podemos establecer variables de entorno que ayudan a nuestro sistema a comportarse de cierta manera. 

En linux, la sintaxis para declarar variables de entorno es con la palabra reservada export, y podemos hacerlo desde una sesion del shell de esta manera:

```
export HOLA="hola"
```
De esta manera, la variable HOLA ahora es expandible desde nuestro shell para revelar su valor:
```
echo $HOLA
hola
```

Es importante establecer que las variables de entorno declaradas de este modo, viven solamente dentro del shell en el que fueron declaradas. Para que estas persistan durante todas las sesiones hay que ponerlas en algun archivo que sea cargado/leido al iniciar una sesion, como el .bashrc por ejemplo.


En terraform, existen variables de entorno especiales que nos ayudan a tomar mayor orden de precedencia que las variables default, pero menos que las que pasamos como banderas en la linea de comandos. Para establecer una variable de entorno de terraform, debemos incluir el prefijo TF_VAR_ seguido por el nombre de la variable que queremos establecer, por ejemplo:

```
export TF_VARS_filename="ostrich.txt"
```

y luego corremos el core workflow

```
terraform init
terraform plan
terraform apply
```

Esto resulta en un archivo llamado ostrich.txt con el contenido generado por random:

```
cat ostrich.txt 
Mr.-capital-monarch
```

### Parte 5) Finalmente, veamos como utilizar Una Lista, generando un numero random que nos seleccione un prefijo de la variable prefix

Modificaremos el archivo variables.tf de manera que quede:

```
variable "filename" {
 default="filename.txt" 
}
variable "separator" {
 default="-"
}

variable "length" {
 default=2
}

variable "prefix" {
  default= ["Mr.", "Ms.", "Sir."]
}
```

Seguido de esto, nuestro archivo main.tf cambiaria a que accediesemos el valor de esta manera:

```
resource "random_pet" "my-pet" {
    prefix = var.prefix[0]
    separator = var.separator
    length = var.length
}
```
o
```
resource "random_pet" "my-pet" {
    prefix = var.prefix[1]
    separator = var.separator
    length = var.length
}
```
o
```
resource "random_pet" "my-pet" {
    prefix = var.prefix[2]
    separator = var.separator
    length = var.length
}
```
Dependiendo del valor que quisiesemos obtener, recordando que en las ciencias de la computacion, el primer valor de una lista se accede por medio del cero, y el valor mas grande (en este caso siendo una tupla de 3 elementos) se accederia con el numero 2.


### Parte 6)
Usando random :

Para evitarnos el tener que seleccionar manualmente el numero del elemento que queremos obtener como prefijo, utilizaremos del modulo random, un random integer en el cual podemos declarar un rango de numeros en el cual queremos que random nos otorgue un valor numerico entero:


```
resource "random_integer" "priority" {
  min = 1
  max = 3
}
```


Para adaptar este codigo a nuestro caso de uso, utilizaremos una funcion en terraform (leer mas de funciones en https://developer.hashicorp.com/terraform/language/functions) para obtener el valor maximo de nuestra tupla:

```
resource "random_integer" "priority" {
  min = 0
  max = length(var.prefix)
}
```

Esto, nos da un valor numerico random, del cual usaremos su contenido para seleccionar un valor en nuestro bloque de random_pet

```
resource "random_pet" "my-pet" {
    prefix = var.prefix[random_integer.priority.id]
    separator = var.separator
    length = var.length
}
```


El resultado final es:

main.tf
```
resource "local_file" "mascota" {
    filename = var.filename
    content = "My favorite pet is ${resource.random_pet.my-pet.id}"
}

resource "random_pet" "my-pet" {
    prefix = var.prefix[random_integer.priority.id]
    separator = var.separator
    length = var.length
}

resource "random_integer" "priority" {
  min = 0
  max = length(var.prefix)
}
```

variables.tf
```
variable "filename" {
 default="filename.txt" 
}
variable "separator" {
 default="-"
}

variable "length" {
 default=2
}

variable "prefix" {
  default= ["Mr", "Mrs", "Sir"]
}
```

De aqui, corremos

```
terraform apply -auto-approve
```

Y listo,

hemos explorado

Datasources
tuplas
funciones
precedencia de variables en terraform con default variables, flag variables y environment variables

