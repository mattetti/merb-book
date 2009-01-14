# Migraciones hacia la base de datos

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

## Creación y configuración de la base de datos
A fin de configurar por primera vez su base de datos, 
usted debe seguir el siguiente procedimiento
   
    $ rake db:create
    $ rake db:automigrate
{:lang=shell html_use_syntax=true}

## Modificación de su base de datos
Después de haber creado su base de datos, 
usted puede modificar su estructura 
agregando columnas a alguna de sus tablas 
o modificar atributos de algunas de sus columnas 
al realizar los cambios necesarios en el modelo respectivo 
y luego ejecutando el siguiente comando 

    $ rake db:autoupgrade
{:lang=shell html_use_syntax=true}

El comando mostrado anteriormente realizara 
una actualización no destructiva de la base de datos.

A fin de realizar una actualización destructiva, 
lo cual borrara todo el contenido existente en su base de datos,
usted debe ejecutar el siguiente comando

    $ rake db:automigrate
{:lang=shell html_use_syntax=true}

### Atención
Al realizar una actualización no destructiva de su base de datos, 
por favor tenga en cuenta que esto no significa que nada malo ocurrirá.
Es una buena política realizar copias de resguardo de su base de datos
antes de proceder a realizar este tipo de actualizaciones.

### Valores por defecto
En el caso que desee agregar una columna a su tabla, 
usted puede configurar el atributo ``:default`` 
en una determinado propiedad de su modelo.
Esto producirá que el valor inicial de la propiedad 
para cada una de las entradas existentes
sea el valor por defecto asignado durante la especificación de la propiedad.

En el caso que usted tenga la clase ``Persona``, 
la cual tiene un atributo identificatorio y 
dos entradas en su base de datos, y luego usted 
desea agregar la propiedad ``nombre`` con un valor por defecto

	class Persona
	  property :id, Serial
      property :nombre, String, :default => "Juan Perez"
	end
{:lang=ruby html_use_syntax=true}

al archivo del modelo ubicado en ``app/models/person.rb``.
Entonces ejecute el comando  

    $ rake db:autoupgrade
{:lang=shell html_use_syntax=true}

Usted podrá inspeccionar a través de la consola 
que las entradas existentes en la base de datos 
tienen sus nombres asignados automáticamente al valor por defecto 
designado en la definición del modelo.

     $ merb -i
     irb(main):001:0> Persona.all
     ~ SELECT "id", "nombre" FROM "personas" ORDER BY "id"
     => [#<Persona id=1 nombre="John Smith">, #<Persona id=2 nombre="John Smith">]
{:lang=shell html_use_syntax=true}

### DM-Migrations
Usted puede utilizar el plug-in ``dm-migrations`` 
a fin de realizar migraciones que puedan ayudarlo con tareas avanzadas.

Para más información, por favor referirse a la página [migraciones en DataMapper][].

TODO explicacion del plug-in "dm-migrations".

[migraciones en DataMapper]: http://datamapper.org/doku.php?id=docs:migrations