#MVC

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

MVC es un acrónimo que significa "Modelo, Vista, Controlador".
Describe una manera de estructurar una aplicación web 
que es fácil de probar y mantener
debido a que separa la lógica de negocio, lógica de servidor y la generación de contenido.
Esta es la estructura de una aplicación standard Merb 
que es generada por el comando '``merb-gen app``'.
Es también la estructura adoptada por [Rails][], [CakePHP][], [Django][],
y muchas otras plataformas de desarrollo web populares.

Para desarrollar en Merb de una manera efectiva,
es sumamente importante que uno entienda tanto el funcionamiento de una estructura MVC
como la manera más apropiada de trabajar con ella.
Este capítulo discutirá la plataforma en forma general;
los siguientes tres capítulos examinarán cada pieza en detalle.

Los [Modelos][] son el núcleo de la plataforma.
Ellos son los responsables de la lógica de negocio de su aplicación;
en Merb, son generalmente asociados con el acceso a la base de datos
a través de un ORM tal como DataMapper o Active Record.
Algunas veces los modelos son usados con un ORM,
simplemente como un envoltorio para una tabla en la base de datos.
No obstante es generalmente considerado una buena práctica tener modelos 'gordos'.
Esto significa que usted debería mantener aspectos 
tales como relaciones de datos y métodos
para cualquier pieza no trivial de recuperación y manipulación de datos 
dentro de las clases modelos.

Las [Vistas][] son el ostentoso cascarón exterior de su aplicación.
Son las responsables de generar el contenido real (HTML, XML, JSON)
retornado por una petición.
Generalmente, estas son escritas en un formato de plantillas
tales como [Erb][] (Ruby embebido) o [Haml][].
Aquellos desarrolladores lo suficientemente sabios intentarán incluir tan poco 
código como sea posible dentro sus vistas.

Los [Controladores][] se encargan de recibir una petición entrante
y de convertirla en una respuesta.
Son responsables de interpretar la petición entrante,
obtener instancias de los modelos necesarios,
y pasar esta información a través de la vista.

En una típica aplicación Merb,
el código para todas estas tres partes se encuentra
en directorios del mismo nombre dentro del directorio '``app``'.
En los siguientes capítulos, examinaremos como Merb implementa cada una de estas partes.

Los principiantes suelen estar tentados por agregar 
mucho código dentro de la capa de controladores,
que produce como consecuencia a un código frágil y difícil de probar.
En cambio, se recomienda a los desarrolladores
a mantener sus controladores tan 'ligeros' como sea posible
poniendo el código que no está directamente relacionado con el ciclo petición/respuesta 
(o la reunión de datos) dentro del modelo.

[CakePHP]: http://www.cakephp.org/
[Django]: http://www.djangoproject.com/
[Rails]: http://rubyonrails.org
[Erb]: http://en.wikipedia.org/wiki/ERuby
[Haml]: http://haml.hamptoncatlin.com/
[Controladores]: /getting-started/controllers
[Modelos]: /getting-started/models
[Vistas]: /getting-started/views

