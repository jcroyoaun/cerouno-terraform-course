# DIA 4
Bienvenidos al último día de el Curso De Terraform de cerouno.

El día de hoy vamos a trabajar con dos implementaciones clásicas de Terraform en un ambiente de trabajo haciendo uso de lo aprendido en las clases pasadas.

* Guardar el statefile en S3 y usar DynamoDB para el locking.

Este documento contendrá los pasos y la explicación de por qué creamos cada recurso creado en AWS con Terraform, ya que las implementaciones en infraestructura compleja rara vez tienen un "one click solution" y es importante entender los funcionamientos intrínsecos de las plataformas que vamos a manejar.


## Remote State file con AWS S3, DynamoDB y Terraform
Como vimos el día de ayer, podemos trabajar con un Remote State File almacenado en S3 y utilizando DynamoDB para el mecanismo de "locking" (mismo que es necesario para trabajar con el State File de manera remota pues es necesario "lockear" el archivo mientras está corriendo nuestra implementación). Terraform utiliza el concepto de "Backends" con implementaciones de almacenamiento con distintos vendors, mencionábamos que para AWS, se configura S3 como el Backend.





## Ejercicio Provisioners
En este ejercicio veremos rapidamente la diferencia entre remote-exec y local-exec. 

remote-exec son comandos que corremos en el recurso que estamos provisionando. Generalmente se necesita una infraestructura que permita que nuestro recurso local (nuestra computadora) pueda hacer ssh por el puerto 22 al recurso que queremos provisionar, por lo cual hay que crear los vpc correctos, designar cdir




## Mas Teoria
* Terraform Taint -> se usa para marcar un recurso que fallo durante el provisionamiento
- > ejemplos de taint, cuando alguien modifica un recurso manualmente y queremos correr un provisionamiento que toca ese recurso, lo podemos marcar como tainted para que no le haga cambios en esa iteracion. Otra solucion seria usar terraform refresh.

```
terraform taint aws_instance.webserver
```


* Debugging en Terraform
Existen casos, como hemos visto en estas sesiones, donde el provisionamiento de recursos no sale como esperamos. Cuando tenemos un error, los logs mostrados en pantalla son bastante útiles para identificar qué problema está impidiendo la correcta ejecución de nuestro script, sin embargo es común encontrarnos con casos donde es necesario un nivel más profundo de loggeo para profundizar en qué puede estar ocurriendo.

En terraform existen dos maneras de manejar el Loggeo :
```
export TF_LOG=TRACE
```

NIVELES DE LOGGEO : 
1. INFO
2. WARNING
3. ERROR
4. DEBUG
5. TRACE

Para guardar el output del loggeo en algun lugar :
```
export TF_LOG_PATH=./terraform.log
```

unset TF_LOG_PATH

## Modulos en Terraform
El uso modulos sirven para organizar nuestro código de mejor manera. Nos permiten también tener definiciones específicas y reutilizar partes que sean repetibles.

Pensemos lo siguiente :
Durante los ejercicios que hemos estado trabajando, hemos ido progresando a tener archivos cada vez más complejos. A veces creamos multiples recursos en nuestro main.tf.

Con modulos, podríamos reutilizar los escenarios más comunes en implementaciones un tanto distinta. Por ejemplo, en el caso donde creamos el S3 bucket y DynamoDB dentro de una misma VPC. Si quisiesemos crear un ECR para deployar un contenedor de Docker en AWS, tendríamos que escribir otro script de Terraform, pero podemos reutilizar la parte de la creación de las VPCs para que la configuración de grupos y subredes sea igual. 

DRY ("Don't Repeat Yourself") 


## Terraform Enterprise y Terraform Cloud
Terraform Enterprise y Cloud son muy similares entre si, ambas son versiones de Terraform que son utilizadas en entornos de trabajo con muchas personas modificando los recursos de la infraestructura. La diferencia más significativa entre ellos es que uno corre en la nube y otro corre en la infraestructura privada de una organización.

Algunas de las capacidades notables que poseen, y que hacen atractivo el uso de estas iteraciones de Terraform son la aplicación de Policies para fortificar nuestra infraestructura.
Algunas politicas existentes pueden estimación de costos, Sentinel Policies para asegurarnos que el plan que queremos aplicar a nuestros recursos se adhiere a las políticas de la compañía (íntimamente ligado al tema de Service Governance muy actual en las empresas grandes) y el uso de Private Module Registry (modulos similares al ejemplo de vpc visto anteriormente) así como la integración de Version Control Systems cada vez que se hace un cambio.

service governance - significa la estipulación de lineamientos a los que se deben adherir los equipos cuando desarrollan servicio, infraestructura y demás. Esto incluye consideraciones de posibles auditorías, estandarización de lenguajes de programación, políticas de seguridad como protocolos de passwords, firewalls, parches de OS en los servidores, etc.