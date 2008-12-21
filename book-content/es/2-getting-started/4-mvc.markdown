#MVC

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

MVC es un acrónimo que quiere decir Modelo, Vista, Controlador.
Describe una estructura de aplicaciones web que es fácil de mantener y
a la que es fácil hacer pruebas porque
separa la lógica de negocio, lógica de servidor y la generación de contenido.
Esta es la estructura de una aplicación standard Merb que es generada por el
comando '``merb-gen app``'.
Es esta también la estructura usada por [Rails][], [CakePHP][], [Django][],
y muchas otras plataformas de desarrollo web.

Para desarrollar de manera efectiva en Merb
es importante que se comprenda tanto como funciona una estructura MVC,
como la manera más efectiva de trabajar con ella.
Este capítulo discutirá la plataforma someramente;
los siguientes tres capítulos examinarán cada parte en detalle.

Los [Modelos][] son el núcleo de la plataforma.
Ellos son responsables de la lógica de negocio de tu aplicación;
en Merb los Modelos son mayormente asociados con accesos a la base de datos
a través de un ORM tal como DataMapper o Active Record.
Algunas veces los Modelos son usados con un ORM,
simplemente como un envoltorio para una tabla en la base de datos.
No obstante es generalmente considerado una buena práctica tener  Modelos
'gordos'.
Esto significa que las clases Modelos es donde deberás mantener cosas
tales como relaciones de datos y métodos
para cada manipulación y recuperación no trivial de datos.

Las [Vistas][] son el ostentoso cascarón exterior de una aplicación.
Las Vistas son responsables de generar el contenido real (HTML, XML, JSON)
retornado por una petición.
Muy tipicamente, las Vistas son escritas en un formato de plantillas
tales como [Erb][] (Ruby embebido) o [Haml][].
Los desarrolladores sabios intentarán poner tan poco código como sea posible en
sus Vistas.

Los [Controladores][] se encargan de recibir una petición entrante
y convertirla en una respuesta.
Son responsables de interpretar la petición entrante,
obtener instancias de los Modelos necesarios,
y pasar esta información a la Vista.

En una aplicación Merb típica,
el código para cada una de estas partes se encuentra
en directorios del mismo nombre dentro del directorio '``app``'.
En los siguientes capítulos examinaremos como Merb implementa cada una de estas
partes.

Los usuarios principiantes se sienten muchas veces tentados a adicionar mucho
código en la capa de controladores,
pero esto conlleva a código frágil y difícil de probar.
En cambio se le recomienda a los desarrolladores
mantener sus controladores tan 'ligeros' como sea posible
poniendo el código que no está directamente relacionado con el ciclo
petición/respuesta (o la reunión de datos) en el Modelo.


<!-- Links -->
[CakePHP]:              http://www.cakephp.org/
[Controladores]:        /getting-started/controllers
[Django]:               http://www.djangoproject.com/
[Erb]:                  http://en.wikipedia.org/wiki/ERuby
[Haml]:                 http://haml.hamptoncatlin.com/
[Modelos]:              /getting-started/models
[Rails]:                http://rubyonrails.org
[Vistas]:               /getting-started/views
