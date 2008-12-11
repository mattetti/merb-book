# Generar un aplicación

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

Merb viene con un generador (<tt>merb-gen</tt>) para crear aplicaciones Merb. El generador
puede generar diferentes tipos aplicaciones Merb, para ver todas las opciones del generador
usa

    $ merb-gen -h

Por ahora, limitémonos solamente a los tipos de aplicaciones Merb que se pueden generar.

## Tipos
Merb puede ser usado para desarrollar desde aplicaciones consistentes en un solo archivo,
muy pequeñas y rápidas hasta grandes y complejos web services.
Diferentes estructuras para la aplicación pueden generarse, dependiendo de las necesidades
del desarrollador.

Las diferentes estructuras para la aplicación que puedes generar son <tt>app</tt> para una
stack, <tt>core</tt> para un núcleo, <tt>flat</tt> para aplicaciones planas, y
<tt>very_flat</tt> para aplicaciones muy planas.

### App (stack)
El stack dogmático de Merb.
Esto genera una estructura de directorios completa para la aplicación con un conjunto
completo de archivos de configuración.
También adiciona un archivo <tt>config/dependancies.rb</tt> que incluye todo el
<tt>merb-more</tt> y <tt>DataMapper</tt>.

    $ merb-gen app my-application

Esta aplicación tiene todo lo necesario para comenzar a construir una aplicación web
completa; es la más similar a la estructura típica de Rails.
Mucho en este libro funcionará con la suposición de que has comenzado de esta manera.

Arranca esta aplicación ejecutando <tt>merb</tt> en el directorio raiz de la aplicación.
Esto iniciará Merb y lo pondrá a escuchar en el puerto por defecto 4000.
Para ver tu aplicación en acción, visita [http://localhost:4000/][].

### Core (núcleo)
Core generará una estructura de directorios completa para la aplicación con un conjunto
completo de archivos de configuración.
A diferencia de <tt>app</tt> -- la stack completa dogmática -- ninguna dependencia se
adicionará.

    $ merb-gen core my-apliccation

Arranca esta aplicación ejecutando <tt>merb</tt> en el directorio raiz de la aplicación.
Fíjate que, a diferencia de las otras tres aplicaciones generadas, en core no existe
contenido por defecto.
Visitando [http://localhost:4000/][] generará un error hasta que adiciones contenido y
ruteo.

### Flat (plana)
Una aplicación plana mantiene toda su lógica en un solo archivo, pero tiene archivos
separados para configuración y un directorio propio para las vistas.

    $ merb-gen flat my-application

Las aplicaciones planas son arrancadas, como cualquier otra aplicación merb generada,
ejecutando <tt>merb</tt> en el directorio raiz de la aplicación.
Por defecto, todos los métodos en la clase <tt>my-application</tt> serán tratados como
acciones con <tt>my-application</tt> como el controlador. e.g.:
[http://localhost:4000/my-application/foo][]

Esto invocará <tt>MyApplication#foo</tt> y mostrará la salida desde la plantilla
<tt>foo.html.*</tt>.

### Very Flat (muy plana)
A aplicación muy plana es similar a otros micro frameworks de Ruby, donde la aplicación
completa esta en un solo archivo.

    $ merb-gen very_flat my-applcation

Para arrancar una aplicación muy plana, inicia Merb con el siguiente comando (en el
directorio de tu aplicación):

    $ merb -I my-applcation.rb

Esto arrancará  Merb y lo pondrá a escuchar en el puerto por defecto (4000). Para ver tu
aplicación en accionn, visita [http://localhost:4000/][].

[http://localhost:4000/]:     http://localhost:4000/
[http://localhost:4000/my-application/foo]: http://localhost:4000/my-application/foo
