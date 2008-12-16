#Modelos

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

Dicho a _grosso modo_ los modelos son la representación programática
de los conceptos y datos que una aplicación usa.
En una aplicación de blog, estos serían cosas
tales como artículos, comentarios y usuarios.
En una aplicación de tienda,
serían productos, clientes, carritos de compra, ventas, etc.
Merb fue diseñado para dar a los desarrolladores tanta libertad como fuera
posible describiendo sus modelos.
Los Modelos pueden ser cualquier cosa que un desarrollador pueda representar con
clases de Ruby.

Dicho esto la gran mayoría de aplicaciones
usarán algún tipo de [ORM][] (Object Relational Mapper)
para hacer sus datos persistentes entre peticiones.
La mayoría de las aplicaciones almacenarán sus datos en alguna forma de base de
datos.
La Stack por defecto de Merb usa [DataMapper][] para comunicarse
con una base de datos [SQLite][].
Esta es una excelente opción para desarrollar fácilmente proyectos nuevos.

Sin embargo una vez en producción
es generalmente recomendado que los desarrolladores cambien
a alguno de los motores base de datos más potentes,
tales como [PostgreSQL][] o [MySQL][].
Proyectos que vengan del mundo de Rails
pueden querer mantener sus modelos [ActiveRecord][];
Merb soporta esta elección también.

El resto de este capítulo se enfocará en el uso de DataMapper
para crear clases Modelo.

## Atributos

En un modelo de DataMapper, los atributos son definidos con el método ``property``
Este método toma el nombre del atributo, un tipo de datos,
y un hash de opciones.
A diferencia de ActiveRecord, un modelo de DataMapper no requiere separar
archivos de migración (sin embargo las migraciones son soportadas).

Aquí está un modelo de DataMapper standard bastante simple:

    class Articulo
      include DataMapper::Resource
      property :id,           Serial
      property :titulo,        String
      property :contenido,      Text
      property :publicado_el, DateTime
    end
{:lang=ruby html_use_syntax=true}

Mira la sección de [propiedades][] del sitio de DataMapper para más detalles.

## Validaciones

Puedes hacer validaciones de los modelos de dos maneras diferentes.
Puedes definirlas al mismo tiempo que la definición del atributo
o usar explicitamente un método ``validates_*``.
Los siguientes dos ejemplos son equivalentes:

    # Usando "auto-validaciones", definidas con la propiedad.
    class Persona
      include DataMapper::Resource
      property :id,   Serial
      property :nombre, String,  :nullable => false
      property :edad,  Integer, :length   => 1..150
    end

    # Usando los métodos "validates_*".
    class Persona
      include DataMapper::Resource
      property :id,   Serial
      property :nombre, String
      property :edad,  Integer

      validates_present :nombre
      validates_length  :edad, :within => 1..150
    end
{:lang=ruby html_use_syntax=true}

Para más information, mira la página de [validaciones][] de DataMapper.

## Asociaciones

DataMapper tiene una manera muy versátil de definir asociaciones entre tus
modelos.
Todo tipo de asociaciones son soportadas, incluidos Uno-A-Muchos,
Muchos-A-Muchos, etc.
Las asociaciones son configuradas usando los métodos ``has`` y ``belongs_to``.

Digamos por ejemplo que estás escribiendp una aplicación de blog.
Esta aplicación tendrá los modelos Articulo y Comentario.
Aquí vemos como definimos la asociación:

    class Articulo
      include DataMapper::Resource
      # Estableciendo las propiedades.
      has n, :comentarios
    end

    class Comentario
      include DataMapper::Resource
      # Estableciendo las propiedades.
      belongs_to :articulo
    end
{:lang=ruby html_use_syntax=true}

Esto te brinda métodos para trabajar con las asociaciones.

    articulo = Articulo.first
    articulo.comentarios  # Devuelve todos los comentarios asociados.
    comentario = Comentario.first
    comentario.articulo   # Devuelve el Articulo padre.
{:lang=ruby html_use_syntax=true}

Si miras el modelo Articulo,
notarás la "mítica, mágica ``n``".
Este método es un atajo de ``Infinito``
y es usado para proveer la asociación "tiene muchos" (has many).

Configurar una asociación "tiene uno" (has one) es
tan simple como pasar el entero ``1`` (uno) al método ``has``.

For ejemplo:

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
estas asociaciones provéen algunos métodos de ayuda (helper):

    persona = Persona.first
    persona.taza_de_cafe  # Devuelve la taza de la persona.
    taza = TazaDeCafe.first
    taza.persona  # Devuelve el dueño de la  taza.
{:lang=ruby html_use_syntax=true}

Para ejemplos más complicados, tales como ``has many through`` (tiene muchos a
travez), refiérete a la página de DataMapper sobre [asociaciones][].

## Callbacks

Los Callbacks te permiten "conectarte" a varios métodos,
para proveer funcionalidad adicional
o (por ejemplo) asegurar que una propiedad tiene cierto formato.
DataMapper soporta callbacks usando un enfoque [orientado a aspecto][]
e incluye (entre otros) los métodos ``before`` y ``after``.

Digamos que tienes un modelo Comentario.
Quieres asegurar que la propiedad ``pagina_inicio`` comienza con "http://",
sin tener que exigir que la persona la provea explícitamente.
Esta es una manera de lograrlo:

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

Como puedes ver, el método ``before`` toma (como símbolos)
el nombre del método al que te estás "conectando"
y el nombre del método que hará el trabajo.
puedes también pasar un bloque:

    before :save do
      # ... el baile del mono.
    end
{:lang=ruby html_use_syntax=true}

puedes definir callbacks para cualquier método, incluidos métodos de clase.
Para más detalles, refiérete a la página de DataMapper sobre [hooks][].


<!-- Links -->
[ActiveRecord]:    http://en.wikipedia.org/wiki/ActiveRecord_%28Rails%29
[orientado a aspecto]: http://en.wikipedia.org/wiki/Aspect_oriented
[asociaciones]:    http://datamapper.org/doku.php?id=docs:associations
[DataMapper]:      http://datamapper.org/doku.php
[hooks]:           http://datamapper.org/doku.php?id=docs:hooks
[MySQL]:           http://en.wikipedia.org/wiki/MySQL
[ORM]:             http://en.wikipedia.org/wiki/Object-relational_mapping
[PostgreSQL]:      http://en.wikipedia.org/wiki/PostgreSQL
[propiedades]:      http://datamapper.org/doku.php?id=docs:properties
[SQLite]:          http://www.sqlite.org/
[validaciones]:     http://datamapper.org/doku.php?id=docs:validations
