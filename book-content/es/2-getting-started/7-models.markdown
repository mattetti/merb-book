# Modelos

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

Como ha sido argumentado, los modelos son la representación programática
de los conceptos y los datos que una aplicación utiliza.
En una aplicación de blog, estos modelos serían representaciones 
de artículos, comentarios y usuarios.
En una aplicación de una tienda electrónica,
los modelos representarían productos, clientes, carritos de compra, ventas, etc.
Merb fue diseñado para dar a los desarrolladores tanta libertad como fuese posible 
a la hora de describir sus modelos para una cierta aplicación.
Los modelos representaran cualquier cosa que un desarrollador pueda definir con clases de Ruby.

Habiendo dicho esto, la gran mayoría de las aplicaciones
usarán algún tipo de [ORM][] (Interconexionador Relacional de Objetos)
para permitir que sus datos sean persistentes entre peticiones.
La mayoría de las aplicaciones almacenarán sus datos en alguna forma de base de datos.
El Stack por defecto de Merb utiliza [DataMapper][] para comunicarse
con una base de datos [SQLite][].
Esta es una excelente opción para desarrollar fácilmente nuevos proyectos.

Una vez en producción, sin embargo,
es generalmente recomendado que los desarrolladores utilicen
alguno de los motores base de datos más potentes,
tales como [PostgreSQL][] o [MySQL][].
Para aquellos proyectos que provienen del mundo Rails
que deseen mantener sus modelos predefinidos en [ActiveRecord][];
Merb también soporta esta librería para conectar a su base de datos.

El resto de este capítulo se enfocará en el uso de [DataMapper][]
para crear las clases modelo que su aplicación usará.

## Atributos

En un modelo de [DataMapper][], los atributos son definidos a través del método ``property``.
Este método toma el nombre de un atributo, su tipo de datos,
y una colección de opciones.
A diferencia de [ActiveRecord][], este tipo de modelo no requiere separar las migraciones 
en archivos separados (aunque las migraciones sean soportadas por Merb).
A continuación se presentara un modelo standard [DataMapper][]:

    class Articulo
      include DataMapper::Resource
      property :id, Serial
      property :titulo, String
      property :contenido, Text
      property :fecha_publicacion, DateTime
    end
{:lang=ruby html_use_syntax=true}

Mira la sección de [propiedades][] del sitio de DataMapper para más detalles.

## Validaciones

Usted puede puede validar sus modelos en dos maneras posibles.
Ya sea definiendo las validaciones al mismo tiempo que la definición de un atributo 
o utilizando explícitamente el método ``validates_*``.
Los siguientes dos ejemplos son equivalentes:

    # Utilizando "auto-validaciones", definidas con la propiedad.
    class Persona
      include DataMapper::Resource
      property :id, Serial
      property :nombre, String, :nullable => false
      property :edad, Integer, :length => 1..150
    end

    # Usando los métodos "validates_*".
    class Persona
      include DataMapper::Resource
      property :id, Serial
      property :nombre, String
      property :edad, Integer

      validates_present :nombre
      validates_length :edad, :within => 1..150
    end
{:lang=ruby html_use_syntax=true}

Para más información, referirse a la página de [validaciones][] de DataMapper.

## Asociaciones

[DataMapper][] tiene una manera muy versátil de definir asociaciones entre sus modelos.
Todo tipo de asociaciones son soportadas, incluidas Uno-A-Muchos, Muchos-A-Muchos, etc.
Las asociaciones son configuradas usando los métodos ``has`` y ``belongs_to``.

En el caso, por ejemplo, que usted esta escribiendo una aplicación de blog.
Esta aplicación utilizará los modelos Articulo y Comentario.
A continuación le presentaremos como definir una asociación:

    class Articulo
      include DataMapper::Resource
      # Definiendo las propiedades.
      has n, :comentarios
    end

    class Comentario
      include DataMapper::Resource
      # Definiendo las propiedades.
      belongs_to :articulo
    end
{:lang=ruby html_use_syntax=true}

[DataMapper][], ademas, proporciona métodos para trabajar con las asociaciones.

    articulo = Articulo.first
    articulo.comentarios  # Devuelve todos los comentarios asociados.
    comentario = Comentario.first
    comentario.articulo   # Devuelve el Articulo padre.
{:lang=ruby html_use_syntax=true}

Si usted observa el modelo Articulo previamente definido,
notará la "mítica y mágica ``n``".
Este método es un atajo de ``Infinito``
y es utilizado para proveer la asociación "tiene muchos" (has many).

Configurar una asociación "tiene uno" (has one) es
tan simple como pasar el entero ``1`` (uno) al método ``has``.

Por ejemplo:

    class Persona
      include DataMapper::Resource
      # estableciendo propiedades
      has 1, :taza_de_cafe
    end

    class TazaDeCafe
      include DataMapper::Resource
      # estableciendo propiedades
      belongs_to :persona
    end
{:lang=ruby html_use_syntax=true}

Como la asociación ``has many`` en Rails,
estas asociaciones proveen algunos métodos de ayuda:

    persona = Persona.first
    persona.taza_de_cafe  # Devuelve la taza de la persona.
    taza = TazaDeCafe.first
    taza.persona  # Devuelve el dueño de la taza.
{:lang=ruby html_use_syntax=true}

Para observar ejemplos más complicados, tales como ``has many through`` (tiene muchos a través), 
usted debe referirse a la página de DataMapper sobre [asociaciones][].

## Callbacks

Los Callbacks le permiten "engancharse" a varios métodos,
para proveer funcionalidad adicional
o (por ejemplo) asegurar que una propiedad esta definida con un cierto formato.
[DataMapper][] soporta callbacks usando un enfoque [orientado a aspecto][]
e incluye (entre otros) los métodos ``before`` y ``after``.

En el caso de que usted tenga un modelo Comentario, por ejemplo.
Usted quiere asegurarse que la propiedad ``pagina_inicio`` comience con "http://",
sin tener que exigir que un usuario la provea explícitamente.
A continuación se le muestra una manera de implementar este requisito:

    class Comentario
      include DataMapper::Resource
      property :pagina_inicio, String

      before :save, :sanitize_pagina_inicio

      private

      def sanitize_pagina_inicio
        # Si pagina_inicio ya comienza con "http://", simplemente retorna.
        return if pagina_inicio =~ /^http[s]?:\/\/\w/
        self.pagina_inicio = 'http://' + pagina_inicio
      end
    end
{:lang=ruby html_use_syntax=true}

Como puede observar, el método ``before`` toma (traducidos como símbolos)
el nombre del método al que usted se está "enganchando"
y el nombre del método que hará el trabajo.
Usted también puede proporcionar un bloque:

    before :save do
      # ... el baile del mono.
    end
{:lang=ruby html_use_syntax=true}

Usted puede definir callbacks para cualquier método, incluidos los métodos de una clase.
Para más detalles, por favor referirse a la página de DataMapper sobre [enganches][].

[ORM]: http://en.wikipedia.org/wiki/Object-relational_mapping
[ActiveRecord]: http://en.wikipedia.org/wiki/ActiveRecord_%28Rails%29
[DataMapper]: http://datamapper.org/doku.php
[MySQL]: http://en.wikipedia.org/wiki/MySQL
[PostgreSQL]: http://en.wikipedia.org/wiki/PostgreSQL
[SQLite]: http://www.sqlite.org/
[propiedades]: http://datamapper.org/doku.php?id=docs:properties
[validaciones]: http://datamapper.org/doku.php?id=docs:validations
[orientado a aspecto]: http://en.wikipedia.org/wiki/Aspect_oriented
[asociaciones]: http://datamapper.org/doku.php?id=docs:associations
[enganches]: http://datamapper.org/doku.php?id=docs:hooks
