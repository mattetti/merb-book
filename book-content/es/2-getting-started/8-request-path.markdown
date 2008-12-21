# Camino de una petición

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

Todas las aplicaciones web actúan en respuesta a una petición HTTP por un
cliente.
Cada acción termina con una respuesta desde el servidor HTTP.
En este capítulo, seguiremos el flujo del programa
desde la petición del cliente hasta la respuesta.

## Desde el Cliente hasta nuestra Puerta

Los funcionamientos internos de la Internet están más alla el alcance of este
libro.
Sin embargo es útil recordar
que existe un cliente (eg, un navegador web) ahí afuera
y que la petición que genera pasa a travez de un número
de entidades (eg, proxies, caches, firewalls) para alcanzar nuestros servidores.
Cualquiera de estas entidades puede examinar la petición, modificarla,
y posiblemente almacenar lo que devolvamos.
Si todo va bien, esto será transparente al usuario
y de ninguna importancia para el servidor.

Existen situaciones sin embargo (particularmente con sitios dinámicos),
donde estas actividades necesitarán ser tomadas en cuenta.
Existen también maneras para sacar ventaja de la infraestructura de la Internet
para reducir la carga en el servidor.
Esto puede ahorranos tanto ancho de banda como costos en equipamiento.

## Proxy Inverso (opcional)

La primera parada para una petición en una aplicación
es usualmente un proxy inverso (reverse proxy) tales como [NginX][] o el
[mod\_proxy][] de [Apache][]
Dependiendo de la configuración, estos proxies pueden servir archivos estáticos
(eg, imágenes, hojas de estilo CSS, código JavaScript, videos).
Muchas veces, incluso permitiremos al proxy servir páginas cacheadas
sin siquiera interactuar con nuestra aplicación.

[Phusion Passenger][] no es un proxy inverso, _per se_.
Sin embargo, en aras del nuestro argumento pretendamos que sí lo es.
(Especificamente, que recibirá la petición a travez de Apache
y que enviará una petición [Rack][] al servidor de la aplicación.)

## Servidor Web

Si la petición no ha sido ya retornada por el reverse proxy,
o si no está siendo usado ninguno,
la petición será reenviada a un **servidor web**.
[Mongrel][], [Thin][], [Ebb][], y un número de programas menos conocidos
se encargan de este rol.

Una vez la respuesta es recibida por el servidor web,
esta será parseada y enviada al [Rack][] a travez de un manipulador (handler).


## Rack y Merb

Merb recibe la petición como un entorno [Rack][].
Un entorno Rack envuelve todo las cabeceras de estilo CGI para la petición.
Debido a que Merb usa Rack como una capa de abstracción,
cambiar servidores web es realmente fácil.
Puede que oigas a gente referirse a estos servidores web como adaptadores.

Antes de que Merb despache la petición a travez de la stack,
uno puede adicionar "middlewares Rack".
Los middlewares Rack pueden procesar la petición antes de que sea enviada a
travez Merb.
Alternativamente, estos pueden "envolver" la petición,
permitiendo que código arbitrario sea ejecutado lo mismo antes que después de
que la petición viaje a travez de la stack.
Los middlewares Rack pueden ser herramientas muy poderosas, permitiéndote
mantener logs a la medida, cacheo, hacer análisis de rendimiento, etc.

Nosotros no cubriremos extensivamente el uso de Rack aquí,
pero puedes encontrar la configuración Rack de Merb en el archivo
``config/rack.rb`` (en la aplicación de stack completa).

## Enrutador (Router)

Una vez la petición ha sido pasada a la stack,
esta le pregunta al enrutador adonde ir.
La petición entonces se envía sí misma al controlador.

El trabajo del Enrutador es asignar parámetros extraidos de la petición
y decirle a la petición adonde ir.
En la mayoría de los casos, el enrutador mapea una petición a un  método
(acción) de un controlador
y también asigna parámetros extraidos de la petición.

Entre bastidores la framework Merb ha hecho ya cierto trabajo para tí.
En el momento que una petición alcanza el controlador, Merb se ha encargado de:

* Extraer la ruta URI de la petición.
* Parsear cualesquiera datos Post o Query enviados por el cliente,
  metiendolos en el hash ``params``.
* Configurar el acceso a las cookies de la petición y a la sesión actual.

El desarrollador puede usar cualquiera de esta información para enrutar la
petición.
Por favor mira el capítulo sobre enrutamiento (???) para más información.

## Acción del Controlador

La petición ha sido despachada a un método de un controlador.
Por ejemplo: el/la método/acción ``show`` del  controlador ``Articulos``.
La acción puede mostrar una vista o simplemente retornar una cadena.
El valor retornado desde el método será usado para construir una respuesta Rack.
Una respuesta Rack es simplemente una tupla sencilla que contiene
 ``[estado, cabeceras, cuerpo]``.

## Hacia afuera

Finalmente Merb envía una respuesta Rack bien construida de regreso al servidor
web.
El servidor web a su vez conforma una respuesta HTTP que es enviada por el
cable.
El cliente recibe la respuesta y la interpreta para, por ejemplo,
mostrar una página web.


## Cacheo

Si el cacheo está habilitado,
la petición podría no viajar a travez de todo el proceso anteriormente descrito.
El Cacheo puede ocurrir dentro Merb, en un Middleware Rack, un servidor Proxy,
o el navegador web cliente.


<!-- Links -->
[Apache]:             http://httpd.apache.org/
[GlassFesh]:          /deployment/jrupor
[mod\_proxy]:         http://httpd.apache.org/docs/2.0/mod/mod_proxy.html
[Mongrel]:            http://mongrel.rubyforge.org/
[MVC]:                /getting-started/mvc
[NginX]:              /deployment/nginx
[Phusion Passenger]:  /deployment/passenger
[Rack]:               http://rack.rubyforge.org/
[Thin]:               http://code.macournoyer.com/thin/
