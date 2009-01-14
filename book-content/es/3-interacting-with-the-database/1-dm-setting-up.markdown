# Configurando DataMapper

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

## Configurando las opciones de la base de datos
La configuración de la base de datos reside 
en el archivo ``config/database.yml``. 

Si usted desea utilizar [SQLite3][] para todo tipo de uso,
(ya sea para desarrollo, pruebas y producción) 
entonces usted no debe modificar el archivo mencionado.
Pase a la siguiente sección. 

### Todo MySQL
En el caso que usted desee utilizar [MySQL][] para todo uso
entonces debe localizar el siguiente código: 

    development: &defaults
      # Estas son las configuraciones para el repositorio :default
      adapter:  sqlite3
      database: ejemplo_desarrollo.db
{:lang=ruby html_use_syntax=true}

y modificar su contenido de la siguiente manera

    development: &defaults
      adapter: mysql
      database: ejemplo_desarrollo
      username: usuario
      password: contrasenia
      host: localhost
{:lang=ruby html_use_syntax=true}

A decir verdad, todas las opciones a excepción del adaptador y del host
pueden ser definidas de la manera que usted crea mas conveniente.
el único requisito es que la base de datos MySQL 
debe reconocer al usuario que desea conectarse. 

### MySQL en ambiente de producción
En el caso de que usted desee utilizar MySQL 
en un ambiente de producción solamente, 
entonces usted debe modificar la sección "production"
del archivo de configuración de la base de datos 
de la siguiente manera:

    production:
      <<:       *defaults
      database: produccion.db
{:lang=ruby html_use_syntax=true}

a

    production:
      adapter: mysql
      database: ejemplo_desarrollo
      username: usuario
      password: contraseña
      host: localhost
{:lang=ruby html_use_syntax=true}

#### NOTA
Ambos motores de base de datos mencionados previamente 
se diferencian entre si debido a pequeñas diferencias.
MySQL puede obtener errores al utilizar cierto tipos de datos 
que SQLite3 no tiene. 
Entonces es recomendable realizar pruebas a fin de asegurarse 
que MySQL responde correctamente a todos los datos que usted
utilice en su aplicación antes de configurar la base de datos 
en un ambiente de producción.

TODO Describir el proceso para configurar otros motores de base de datos en Merb.

[SQLite3]: ...
[MySQL]: ...
