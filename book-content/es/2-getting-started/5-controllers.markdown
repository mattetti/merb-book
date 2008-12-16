# Controladores

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

> Un controlador es el enlace entre un usuario y el sistema.
> Provée al usuario con datos propiciando que las vistas relevantes
> se presenten ellas mismas en los lugares apropiados de la pantalla.<!-- break -->
> Provée medios para ofrecer salida al usuario presentándole menús u otros
> medios de entrar comandos y datos.<!-- break -->
> El controlador recibe tal salida del usuario, la traduce en los mensajes
> apropiados y pasa estos mensajes a una o más de las vistas.<!-- break -->
> - [Trygve Reenskaug][]{: .quote-author}, autor del patrón de diseño
> Modelo-Vista-Controlador[^mvc-essay]
{: cite=http://heim.ifi.uio.no/~trygver/1979/mvc-2/1979-12-MVC.pdf .lead-quote}


En el paradigma [MVC][], los controladores representan la capa de pegamento
que conecta la lógica de negocio (Modelo) con las Vistas.

Concretamente el controlador es responsable del mapeo de una acción del
usuario-final con una respuesta de la aplicación.

En Merb, técnicamente hablando,
los controladores son clases que heredan de ``Merb::Controller``.
En una aplicación Merb-stack, una clase controlador llamada ``Application`` es
creada.
Todos los controladores generados heredan de ``Application``;
por ende todos comparten los mismos atributos que ``Application``.

La lógica del [Enrutador][] de Merb examina los detalles de la petición entrante,
comparándolos con reglas especificadas en el  archivo ``router.rb``.
Asumiendo que una correspondencia es encontrada,
el Enrutador entonces envía la petición al controlador y acción apropiadas.

En este capítulo, veremos cómo generar y organizar los controladores.
También discutiremos cómo se pueden escribir **acciones**,
que son los métodos del controlador que son llamados para que se encarguen de
las peticiones entrantes.
Finalmente veremos cómo extender las funcionalidades de un controlador.

## Generando controladores

Tú puedes  generar dos tipos de controladores:
un controlador standard y un controlador [RESTful][].

### Un controlador standard

    $ merb-gen controller birds
      [ADDED]  app/controllers/birds.rb
      [ADDED]  app/views/birds/index.html.erb
      [ADDED]  spec/requests/birds_spec.rb
      [ADDED]  app/helpers/birds_helper.rb
{:lang=shell html_use_syntax=true}

El comando anterior genera varios archivos.
El archivo controlador (``birds.rb``) contendrá métodos para cada acción,
así como otros métodos que el controlador necesita.
El archivo plantilla de vista (``index.html.erb``) puede ser usado para generar HTML,
usando un  procesador de ``erb`` (Ruby embebido).
Los demás archivos (``birds_spec.rb``, ``birds_helper.rb``)
deben ser usados para almacenar las especificaciones de las pruebas así como
métodos helper (ayudantes).

Echemos un vistazo rápido al controlador generado:

    class Birds < Application

      def index
        render
      end

    end
{:lang=ruby html_use_syntax=true}

El generator adicionó una nueva clase llamada ``Birds``,
que hereda de ``Application``.
La nueva clase tiene un método llamado ``index``.
En el contexto de un controlador,
a menudo nos referimos a estos métodos como **acciones del controlador** o
simplemente **acciones**.


``Application`` (una subclase de ``Merb::Controller``)
es la clase de la cual usualmente heredan los controladores.
Por ello es un lugar conveniente para compartir código entre controladores.<!-- break -->
(_usar con precaución_)


+-- {: .notes}
Si notas que cometiste un error generando tu controlador,
puedes borrar el controlador generado adicionando ``-d`` al
final del comando que recién enviaste:

      $ merb-gen controller birds -d
        [DELETED]  app/controllers/birds.rb
        [DELETED]  app/views/birds/index.html.erb
        [DELETED]  spec/requests/birds_spec.rb
        [DELETED]  app/helpers/birds_helper.rb
  {:lang=shell html_use_syntax=true}
=--

### Un controlador REStful

    $ merb-gen resource_controller cats
      [ADDED]  spec/requests/cats_spec.rb
      [ADDED]  app/controllers/cats.rb
      [ADDED]  app/views/cats/index.html.erb
      [ADDED]  app/views/cats/show.html.erb
      [ADDED]  app/views/cats/edit.html.erb
      [ADDED]  app/views/cats/new.html.erb
      [ADDED]  app/helpers/cats_helper.rb
{:lang=shell html_use_syntax=true}

Si abres el archivo controlador recién generado (``app/controllers/cats.rb``),
notarás que el generador creó un nueva clase llamada ``Cats``.
Como era de esperar la clase hereda de ``Application``.
Sin embargo, esta vez, en lugar de una  acción ``index`` vacía,
encontramos siete acciones completamente definidas.

Veamos el archivo generado:

    class Cats < Application
      # provides :xml, :yaml, :js

      def index
        @cats = Cat.all
        display @cats
      end

      def show(id)
        @cat = Cat.get(id)
        raise NotFound unless @cat
        display @cat
      end

      def new
        only_provides :html
        @cat = Cat.new
        display @cat
      end

      def edit(id)
        only_provides :html
        @cat = Cat.get(id)
        raise NotFound unless @cat
        display @cat
      end

      def create(cat)
        @cat = Cat.new(cat)
        if @cat.save
          redirect resource(@cat), :message => {:notice => "Cat fue creado satisfactoriamente"}
        else
          message[:error] = "Cat no pudo ser creado"
          render :new
        end
      end

      def update(id, cat)
        @cat = Cat.get(id)
        raise NotFound unless @cat
        if @cat.update_attributes(cat)
           redirect resource(@cat)
        else
          display @cat, :edit
        end
      end

      def destroy(id)
        @cat = Cat.get(id)
        raise NotFound unless @cat
        if @cat.destroy
          redirect resource(:cats)
        else
          raise InternalServerError
        end
      end

    end # Cats
{:lang=ruby html_use_syntax=true}


Wow, eso es mucho código.
Como regla general,
tú **no** debieras usar código generado que no entiendas.
Por suerte, el código anterior es muy fácil de entender
y nosotros lo repasaremos en detalle.

Pero antes de que revisemos el código, hablemos sobre [REST][].

## REST

[REST][] es un acrónimo para Transferencia de Estado Representacional
([Representational State Transfer][]).
Fue por primera vez introducido en el 2000 por [Roy Fielding][][^rest\_intro].
REST se refiere a un estilo de arquitectura de software que esboza cómo los
[recursos][] son definidos y accedidos.
De esta manera son los [recursos][] los componentes claves de REST.

**¿Qué es un recurso, en el contexto de REST?**

Un recurso es una fuente de información específica,
referenciada por una URI (identificador global).
En términos no técnicos, es cierta información que puedes acceder a travez de una
dirección específica.
REST usa el protocolo HTTP para comunicar datos entre los diferentes actores.
Es a menudo usado para servicios web,
porque sus principios aplican muy bien a recursos web.

**Aquí está cómo es que la gente usualmente mapea recursos web REST:**

**URI:**      http://site.com/cats o http://site.com/cats/1-felix
(identificador/dirección global)<!-- break -->

**Formato:**  Tipo o extensión MIME (HTML, JSON, XML, YAML, CSV, PDF, ...)<!-- break -->

**acción:**   mapea los métodos HTTP (POST, GET, PUT, y DELETE) a métodos de recursos

Si un recurso es definido, Merb usa la ``URI`` y el método HTTP
para seleccionar un controlador y una acción.


<!-- Links -->
[MVC]:              /getting-started/mvc
[redirect]: http://merbivore.com/documentation/1.0/doc/rdoc/merb-core-1.0/index.html?a=M000529&name=redirect
[Representational State Transfer]:         http://en.wikipedia.org/wiki/Representational_State_Transfer
[recursos]:  http://en.wikipedia.org/wiki/Representational_State_Transfer#REST.27s_central_principle:_resources
[REST]:             http://en.wikipedia.org/wiki/Representational_State_Transfer
[RESTful]:          http://en.wikipedia.org/wiki/Representational_State_Transfer#RESTful_Web_services
[Enrutador]:           /getting-started/router
[Roy Fielding]:     http://en.wikipedia.org/wiki/Roy_Fielding]
[Trygve Reenskaug]: http://en.wikipedia.org/wiki/Trygve_Reenskaug
[View]:             /getting-started/view

<!-- References -->
[^rest\_intro]: Chapter 5 of Fielding’s dissertation is ["Representational State Transfer (REST)"](http://www.ics.uci.edu/~fielding/pubs/dissertation/rest_arch_style.htm)
[^mvc-essay]:   http://heim.ifi.uio.no/~trygver/1979/mvc-2/1979-12-MVC.pdf

<!-- Abbreviations -->
*[HTTP]:    Hypertext Transfer Protocolo
*[REST]:    Representational state transfer
