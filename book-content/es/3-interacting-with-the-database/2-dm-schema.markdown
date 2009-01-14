# Esquema de la base de datos

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

## Modelo

### Creación de un Modelo

	$ merb-gen model NombreModelo
{:lang=shell html_use_syntax=true}

### Abrir un Modelo

Usted podrá encontrar el modelo recientemente creado 
en la siguiente ubicación: ``MERB_ROOT/app/models/nombre_modelo.rb``. 

### Definir sus propiedades

En [DataMapper][], usted no requiere generar archivos de migración 
para la base de datos a fin de crear una tabla a la base de datos o
de agregar una columna a una tabla existente. 
Aunque, para tareas mas avanzadas, usted los puede utilizar.

A continuación se le presentara un modelo por defecto: 
    
	class Persona
      include DataMapper::Resource
      
      # Usted puede agregar las propiedades según sus requisitos.
      property :id, Serial
	  property :nombre, Tipo, :opcion_1 => valor, :opcion_2 => valor
      ... 
      
	end
{:lang=ruby html_use_syntax=true}

### Tipos de datos disponibles
DM-Core soporta los siguientes tipos de datos 'primitivos':

 * TrueClass, Boolean
 * String
 * Text
 * Float
 * Fixnum, Integer
 * BigDecimal
 * DateTime, Date, Time
 * Object
 * Discriminator (todo lo que necesite para Herencias Simples de Tablas)

Si usted incluye la librería DM-Types, 
los siguientes tipos de datos son soportados:

 * Csv
 * Enum
 * EpochTime
 * FilePath
 * Flag
 * IPAddress
 * URI
 * Yaml
 * Json
 * BCryptHash
 * Regex

Para mas información relacionada a estos tipos de datos, 
por favor referirse a la página [tipos de datos en DataMapper][].

Para mas especificaciones con respecto a las propiedades de un modelo,
por favor referirse a la pagina [definición de propiedades en DataMapper][]. 

### Migración a la base de datos

Obviamente, usted debe terminar de definir sus propiedades primero.
En resumen, usted debe ejecutar el siguiente comando:

	$ rake db:create 
{:lang=shell html_use_syntax=true}

y luego ejecutar el comando 

	$ rake db:automigrate
{:lang=shell html_use_syntax=true}

El resultado de la ejecución de estos dos comandos 
debe verse reflejado en la creación y/o actualización del esquema 
de su base de datos.
Para mas información, por favor referirse a la sección [migraciones][].

[DataMapper]: ...
[tipos de datos en DataMapper]: http://datamapper.org/doku.php?id=dm-more:dm-types
[definición de propiedades en DataMapper]: http://datamapper.org/doku.php?id=docs:properties
[migraciones]: /interacting-with-the-database/dm-migrations

