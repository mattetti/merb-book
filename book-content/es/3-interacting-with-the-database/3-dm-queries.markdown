# Consultas a la base de datos

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

En esta sección se explicará en detalles cada una de las acciones 
que su aplicación puede utilizar para manipular datos guardados en 
su base de datos de elección.

Para más información, por favor referirse a la página [acciones en DataMapper][].

## Crear
A fin de crear una nueva entrada en su base de datos, 
se recomendable seguir la siguiente secuencia:

### Instancia nueva
Primero, usted debe crear una nueva instancia de su modelo.

    nombre_modelo = NombreModelo.new
{:lang=ruby html_use_syntax=true}

### Definir sus atributos
Luego, usted debe definir los atributos 
referentes a la instancia creada en una colección:

    nombre_modelo.attributes = {:atributo_1 => valor_1, :atributo_2 => valor_2}
{:lang=ruby html_use_syntax=true}

Alternativamente, usted puede definirlos uno a uno si así lo desea:

    nombre_modelo.atributo_1 = valor_1
    nombre_modelo.atributo_2 = valor_2
{:lang=ruby html_use_syntax=true}

### Salvar la instancia
Ahora, usted debe guardarla de la siguiente manera:

     nombre_modelo.save
{:lang=ruby html_use_syntax=true}

### Resultado de la validación
El interprete retornará el valor ``true`` en el caso que la instancia 
haya sido guardada correctamente en la base de datos, 
luego de haber pasado todas las validaciones de datos definidas,

    nombre_modelo.save
	# => true
{:lang=ruby html_use_syntax=true}

En el caso en el cual una o mas validaciones no hayan sido exitosas, 
El interprete retornará el valor ``false`` . 

    nombre_modelo.save
	# => false
{:lang=ruby html_use_syntax=true}

#### Errores
Ante el caso de falla, el siguiente método le brindará una lista
que contendrá los mensaje de error relacionados a cada falla encontrada.

    nombre_modelo.errors
{:lang=ruby html_use_syntax=true}

## Leer

Para más información, por favor referirse a la página [buscadores en DataMapper][].

A fin de obtener entradas desde su base de datos, 
se recomendable que tenga en cuenta las diferentes maneras que 
[DataMapper][] provee a fin de realizar esta tarea:

### Obtener una sola entrada
#### A través de la llave primaria
Usted puede recuperar una entrada desde la base de datos 
utilizando un valor que la define.

Ya sea un valor identificador de tipo Serial:

    NombreModelo.get(1)
{:lang=ruby html_use_syntax=true}

O una cadena de caracteres:

    NombreModelo.get("foobar")
{:lang=ruby html_use_syntax=true}

Al existir otras posibilidades para las llaves primarias, 
es recomendable que se refiera a la pagina [buscadores en DataMapper][]
con el fin de obtener mas información al respecto.

#### A través de uno o mas atributos
Usted puede obtener la primera ocurrencia de una entrada 
que se encuentra en la base de datos al seguir el siguiente criterio:

    NombreModelo.first(:atributo_1 => valor_1, :atributo_2 => valor_2)
{:lang=ruby html_use_syntax=true}

O simplemente usted puede utilizar un solo atributo:

    NombreModelo.first(:atributo => valor)
{:lang=ruby html_use_syntax=true}

A la hora de definir las condiciones de búsqueda, 
usted puede hacer uso de los condicionales existentes tales como:

    NombreModelo.first(:atributo.gt => valor)
{:lang=ruby html_use_syntax=true}

En el caso en particular, usted obtendrá la primera ocurrencia de 
``nombre_modelo`` que cumpla con la condición ``nombre_modelo.atributo > valor``. 

Usted puede encontrar la lista completa de condiciones 
en la pagina [condiciones para los buscadores en DataMapper][].

### Obtener varias entradas
Para obtener varias entradas desde la base de datos, usted debe aplicar la 
misma lógica de la seguida para obtener una sola entrada de la base de datos.
Usted debe implementar lo siguiente:  

    NombreModelo.all(argumentos)
{:lang=ruby html_use_syntax=true}

en lugar de lo siguiente:

    NombreModelo.first(argumentos)
{:lang=ruby html_use_syntax=true}

Por ejemplo, 

    NombreModelo.all(price.gt => 5)
{:lang=ruby html_use_syntax=true}

obtendrá todas las entradas existente en la tabla ``NombreModelo``
cuyo precios sean mayor a 5, de la misma manera que 

    NombreModelo.first(price.gt => 5)
{:lang=ruby html_use_syntax=true}

obtendrá la primera entrada de la base de datos cuyo precio es mayor a 5.

## Actualizar
Para modificar la información existente en una entrada en la base de datos, 
usted debe seguir con atención las siguientes opciones.

### Modificar los atributos, para luego actualizar la entrada
#### Modificar los atributos
Para realizar los cambios a una instancia.

    nombre_modelo.atributo = foo
{:lang=ruby html_use_syntax=true}

#### Actualizar la entrada
Luego, usted debe actualizarla en la base de datos.

    nombre_modelo.update
{:lang=ruby html_use_syntax=true}

Esta acción actúa de la misma manera que la acción ``nombre_modelo_.save`` explicada previamente. 
En el caso en que la actualización de la información y su respectiva validación
hayan sido exitosas, el interprete retornará el valor ``true``. 
En el caso de encontrar uno o mas errores durante este proceso, 
entonces el interprete retornará el valor ``false`` 
y hará disponible todos los mensajes de error generadores a través de 

     nombre_modelo.errors
{:lang=ruby html_use_syntax=true}

### Modificar los atributos y actualizar la instancia en un solo paso
En el caso de tener una colección de atributos, 
usted puede modificarlos y actualizarlos en un solo paso a través de 

    nombre_modelo.update_attributes(coleccion)
{:lang=ruby html_use_syntax=true}

Esta acción actúa como las acciones ``save`` y ``update`` explicadas previamente.

### Suciedad
Usted puede verificar si una instancia esta "sucia", 
o mejor dicho tiene uno o mas atributos modificados, a través de 

    nombre_modelo.dirty?
{:lang=ruby html_use_syntax=true}

El interprete retornara el valor ``true`` en el caso que la instancia haya sido modificada.
Pero si su instancia no fue modificada, el interprete retornara el valor ``false``.

Debido a que este método es inteligente, esto es sumamente útil a la hora de verificar 
si su instancia ha sido realmente modificada o no.

En el siguiente ejemplo, se obtendrá de la base de datos 
la primera ocurrencia de ``NombreModelo`` cuyo ``atributo_1`` contenga el valor 3.

     foo = NombreModelo.first(:atributo_1 => 3)
     foo.atributo_1 = 3
     puts foo.dirty? # => false
{:lang=ruby html_use_syntax=true}

Es importante remarcar que, cuando se le asigna al atributo de la instancia el mismo valor,
este método entiende que en este caso particular no haya habido modificación alguna. 

## Destruir
Esta acción es sumamente sencilla, y hay solamente una manera de realizarla.

     foo = NombreModelo.get(42)
     foo.destroy
{:lang=ruby html_use_syntax=true}

El interprete retornará el valor ``true`` en el caso de suprimir exitosamente 
la entrada determinada de la base de datos. 
En el caso de fallas, este retornará el valor ``false``.

[acciones en DataMapper]: http://datamapper.org/doku.php?id=docs:crud
[buscadores en DataMapper]: http://datamapper.org/doku.php?id=docs:finders
[condiciones para los buscadores en DataMapper]: http://datamapper.org/doku.php?id=docs:finders#conditions