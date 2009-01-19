# Controladores

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

> Un controlador es el enlace entre un usuario y el sistema.
> Este provee al usuario de una entrada arreglando que las vistas relevantes
> se presenten ellas mismas en los lugares apropiados de la pantalla.
> Ademas provee medios para la salida al usuario presentándole menús u otros
> medios para introducir comandos y datos.
> El controlador recibe tal salida al usuario, la traduce en mensajes
> apropiados y los redirecciona a una o más vistas.
> - [Trygve Reenskaug][]{: .quote-author}, autor del patrón de diseño
> Modelo-Vista-Controlador[^mvc-essay]
{: cite=http://heim.ifi.uio.no/~trygver/1979/mvc-2/1979-12-MVC.pdf .lead-quote}

En el paradigma [MVC][], los controladores representan la capa de pegamento
que conecta la lógica de negocio (definida dentro de un modelo) con las vistas.

Concretamente, el controlador es responsable del realizar la interconexión entre 
una acción del usuario con una respuesta definida en la aplicación.

En Merb, técnicamente hablando,
los controladores son clases que heredan su funcionalidad de la clase ``Merb::Controller``.
En una aplicación stack de Merb, una clase controlador llamada ``Application`` es creada.
Todos los controladores generados heredan de la clase recientemente mencionada;
por ende, todos ellos comparten los mismos atributos que la misma.

La lógica del [Enrutador][] de Merb examina los detalles de la petición entrante,
comparándolos contra las reglas especificadas en el archivo ``router.rb``.
Asumiendo que una correspondencia sea encontrada,
el enrutador entonces envía la petición al controlador y a la acción apropiadas.

En este capítulo, veremos cómo generar y organizar los controladores.
También discutiremos cómo escribir **acciones**,
que son los métodos de un controlador los cuales serán llamados 
a la hora de manejar peticiones entrantes.
Finalmente, veremos cómo extender las funcionalidades de un controlador.

## Generando controladores

Usted puede generar dos tipos de controladores:
un controlador standard y un controlador [RESTful][].

### Un controlador standard

    $ merb-gen controller pajaros
      [ADDED]  app/controllers/pajaros.rb
      [ADDED]  app/views/pajaros/index.html.erb
      [ADDED]  spec/requests/pajaros_spec.rb
      [ADDED]  app/helpers/pajaros_helper.rb
{:lang=shell html_use_syntax=true}

El comando anterior genera varios archivos.
El archivo controlador (``pajaros.rb``) contendrá métodos para cada acción,
así como otros métodos que el controlador necesita.
El archivo plantilla de vista (``index.html.erb``) puede ser usado para generar HTML,
usando un  procesador de ``erb`` (Ruby embebido).
Los archivos restantes (``pajaros_spec.rb``, ``pajaros_helper.rb``)
deben ser usados para contener las especificaciones de las pruebas así como los métodos de ayuda.

Si usted observa a simple vista el controlador generado:

    class Pajaros < Application
      def index
        render
      end
    end
{:lang=ruby html_use_syntax=true}

El generador agregó una nueva clase denominada ``Pajaros``,
que hereda su funcionalidad básica de la clase ``Application``.
Esta nueva clase contiene un método llamado ``index``.
En el contexto de un controlador,
a este tipo de métodos se los suele denominar 
**acciones del controlador** o simplemente **acciones**.

La clase ``Application`` (una subclase de ``Merb::Controller``)
es de la cual usualmente heredan los controladores.
Por esta razón, es conveniente utilizarla para compartir código entre controladores.
(_usar con precaución_)

+-- {: .notes}
Si usted se da cuenta que ha cometido un error generando su controlador,
usted puede borrarlo agregando la opción ``-d`` al
final del comando que ha ejecutado:

      $ merb-gen controller pajaros -d
        [DELETED]  app/controllers/pajaros.rb
        [DELETED]  app/views/pajaros/index.html.erb
        [DELETED]  spec/requests/pajaros_spec.rb
        [DELETED]  app/helpers/pajaros_helper.rb
  {:lang=shell html_use_syntax=true}
=--

### Un controlador REStful

    $ merb-gen resource_controller gatos
      [ADDED]  spec/requests/gatos_spec.rb
      [ADDED]  app/controllers/gatos.rb
      [ADDED]  app/views/gatos/index.html.erb
      [ADDED]  app/views/gatos/show.html.erb
      [ADDED]  app/views/gatos/edit.html.erb
      [ADDED]  app/views/gatos/new.html.erb
      [ADDED]  app/helpers/gatos_helper.rb
{:lang=shell html_use_syntax=true}

Si usted abre el archivo controlador recientemente generado (``app/controllers/gatos.rb``),
usted notará que el generador creó un nueva clase llamada ``Gatos``.
Como era de esperarse, la clase hereda su funcionalidad de la clase ``Application``.
Sin embargo, esta vez, en lugar de una acción ``index`` vacía,
se encontrara con siete acciones ya predefinidas.

Si usted observa a simple vista el archivo generado:

    class Gatos < Application
      # provides :xml, :yaml, :js

      def index
        @gatos = Gato.all
        display @gatos
      end

      def show(id)
        @gato = Gato.get(id)
        raise NotFound unless @gato
        display @gato
      end

      def new
        only_provides :html
        @gato = Gato.new
        display @gato
      end

      def edit(id)
        only_provides :html
        @gato = Gato.get(id)
        raise NotFound unless @gato
        display @gato
      end

      def create(gato)
        @gato = Gato.new(gato)
        if @gato.save
          redirect resource(@gato), :message => {:notice => "Gato fue creado exitosamente."}
        else
          message[:error] = "Gato no pudo ser creado."
          render :new
        end
      end

      def update(id, gato)
        @gato = Gato.get(id)
        raise NotFound unless @gato
        if @gato.update_attributes(gato)
           redirect resource(@gato)
        else
          display @gato, :edit
        end
      end

      def destroy(id)
        @gato = Gato.get(id)
        raise NotFound unless @gato
        if @gato.destroy
          redirect resource(:gatos)
        else
          raise InternalServerError
        end
      end
    end # Gatos
{:lang=ruby html_use_syntax=true}

Como regla general,
usted **no** debería utilizar código generado que no entienda.
Afortunadamente, el código detallado previamente es muy simple de comprender
y ahora procederemos a repasarlo en detalle.

Pero antes de revisarlo, es importante hablar sobre [REST][].

## REST

[REST][] es el acrónimo que significa "Transferencia de Estado Representacional".
Fue por primera vez introducido en el año 2000 por [Roy Fielding][][^rest\_intro].
REST se refiere a un estilo de arquitectura de software que delinea cómo los
[recursos][] son definidos y accedidos.
Por consecuencia, los [recursos][] son los componentes claves de REST.

**¿Qué es un recurso, dentro del contexto de REST?**

Un recurso es una fuente de información específica,
referenciada por una [URI][] (identificador global de recursos).
En términos prácticos, se trata de cierta información que puede 
ser accedida a través de una dirección específica.
REST usa el protocolo HTTP para comunicar datos entre los diferentes actores.
Es generalmente utilizado para servicios web,
porque sus principios son aplicados coherentemente a los recursos web.

**Aquí se presenta cómo es realizada la interconexión de recursos web REST:**

**URI:** 		http://site.com/gatos o http://site.com/gatos/1-felix
(identificador global/dirección)
**Formato:**  	tipo o extensión MIME (HTML, JSON, XML, YAML, CSV, PDF, ...)
**Acción:**   	interconexión de los métodos HTTP (POST, GET, PUT, y DELETE) con los métodos de un recurso

Si un recurso es definido, Merb usa la ``URI`` y el método HTTP
para seleccionar un controlador y una acción.

[MVC]: /getting-started/mvc
[redirect]: http://merbivore.com/documentation/1.0/doc/rdoc/merb-core-1.0/index.html?a=M000529&name=redirect
[recursos]: http://en.wikipedia.org/wiki/Representational_State_Transfer#REST.27s_central_principle:_resources
[REST]: http://en.wikipedia.org/wiki/Representational_State_Transfer
[RESTful]: http://en.wikipedia.org/wiki/Representational_State_Transfer#RESTful_Web_services
[Enrutador]: /getting-started/router
[Roy Fielding]: http://en.wikipedia.org/wiki/Roy_Fielding]
[Trygve Reenskaug]: http://en.wikipedia.org/wiki/Trygve_Reenskaug
[View]: /getting-started/view
[URI]: ...

[^rest\_intro]: Capitulo 5 de la disertación de Fielding sobre la ["Transferencia de Estados Representacionales (REST)"](http://www.ics.uci.edu/~fielding/pubs/dissertation/rest_arch_style.htm)
[^mvc-essay]: http://heim.ifi.uio.no/~trygver/1979/mvc-2/1979-12-MVC.pdf

*[HTTP]: Hypertext Transfer Protocol
*[REST]: REpresentational State Transfer
*[URI]: Universal Resource Identifier
