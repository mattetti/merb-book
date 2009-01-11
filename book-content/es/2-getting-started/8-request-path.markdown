# Camino de una Petición

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

Todas las aplicaciones web actúan en respuesta a una petición HTTP realizada por un cliente.
Cada acción termina con una respuesta proporcionada por el servidor HTTP.
En este capítulo, se presentara el flujo de programa a seguir 
desde la petición del cliente hasta la respuesta otorgada por el servidor.

## Del cliente a su puerta

La manera de como funciona internamente la Internet están fuera del alcance de este libro.
Pero, sin embargo, es sumamente útil recordar
que existe un cliente (por ejemplo, un navegador web) que será utilizado
para generar una petición que pasara a través de un número
de entidades (proxies, caches, firewalls, entre otras) para alcanzar un determinado servidor.
Cualquiera de estas entidades puede examinar la petición, modificarla,
y posiblemente almacenar el resultado que retorne este servidor.
En el mejor de los casos, estas acciones serán transparentes al usuario
y de ninguna importancia para el servidor en cuestión.

Sin embargo, pueden existir determinadas situaciones (particularmente con sitios dinámicos),
donde estas acciones necesitarán de ser tomadas en cuenta.
También existen maneras para obtener ventaja de la infraestructura de la Internet
para reducir la carga a realizar en el servidor.
Esto puede producir ahorros tanto en el ancho de banda como en los costos en equipamiento.

## Proxy Inverso (opcional)

La primera parada a realizar por una petición en una aplicación en funcionamiento
es usualmente un proxy inverso tales como el [NginX][] o el [mod\_proxy][] de [Apache][].
Dependiendo de la configuración, estos proxies pueden servir archivos estáticos
(pro ejemplo imágenes, hojas de estilo CSS, código JavaScript o videos).
Frecuentemente, se le permite al proxy servir páginas cacheadas
sin siquiera interactuar con su aplicación web.

[Phusion Passenger][] no es un proxy inverso, _per se_.
Sin embargo, en aras del nuestro argumento, se pretenderá que sí lo es.
(Específicamente, este recibirá una petición a través del servidor [Apache][]
y consecuentemente enviará una petición [Rack][] al servidor de la aplicación.)

## Servidor Web

En el caso que la petición no haya sido retornada por el proxy inverso,
o si no hay ninguno en uso,
la petición será reenviada a un **servidor web**.
[Mongrel][], [Thin][], [Ebb][], y un número de programas menos conocidos
se encargan de cumplir con este rol.

Una vez que la respuesta sea recibida por el servidor web,
esta será parseada y enviada al [Rack][] a través de un manipulador.

## Rack y Merb

Merb recibe una petición dentro del entorno [Rack][].
Un entorno Rack envuelve todas las cabeceras de estilo CGI para una petición.
Debido a que Merb utiliza [Rack][] como una capa de abstracción,
el cambio de servidores web resulta ser sumamente simple.
Estos servidores web pueden ser también llamados "adaptadores".

Antes de que Merb despache una petición a través de la stack,
uno puede adicionar diferentes "middlewares" en el [Rack][].
Estos pueden procesar la petición antes de que esta sea enviada a través de Merb.
Alternativamente, también pueden "envolver" una petición,
permitiendo así la ejecución de código arbitrario tanto antes como después 
del paso de la petición a través de la stack.
Los [middlewares][] del Rack pueden ser herramientas muy poderosas, permitiéndole 
mantener registros de eventos a medida, cacheo, realizar análisis de rendimiento, etc.

El uso de [Rack][] no será cubierto extensivamente en este capitulo,
pero usted puede encontrar la configuración del [Rack][] de Merb en el 
archivo ``config/rack.rb`` (en la aplicación de stack).

## Enrutador

Una vez que la petición ha pasado al stack,
esta le pregunta al enrutador hacia donde debe dirigirse.
Entonces la petición se envía a sí misma hacia el controlador.

El trabajo del Enrutador es la asignación de parámetros extraídos 
de la petición aunque, ademas, debe direccionar a la misma.
En la mayoría de los casos, el enrutador conecta una petición a un 
determinado método (acción) definido en un controlador
asignando aquellos parámetros extraídos de la petición al mismo.

Detrás de escena, la plataforma Merb ya ha realizado cierto trabajo por usted.
Al momento que una petición alcanza un controlador, Merb se ha encargado de:

* Extraer la ruta [URI][] de la petición.
* Parsear los datos Post o Query enviados por el cliente,
  organizándolos en la colección ``params``.
* Configurar el acceso a las cookies de la petición y a la sesión actual.

El desarrollador puede usar esta información para enrutar la petición.
Por favor, referirse al capítulo sobre enrutamiento (???) para más información.

## Acción del Controlador

La petición es ahora despachada a un determinado método de un controlador.
Por ejemplo: el método o la acción ``mostrar`` del  controlador ``Articulos``.
La acción puede mostrar una vista o simplemente retornar una cadena de caracteres.
El valor retornado por el método será usado para generar la respuesta del Rack.
Esta es simplemente una tupla sencilla que contiene [estado, cabeceras, cuerpo].

## Hacia afuera

Finalmente, Merb retorna la respuesta Rack bien construida al servidor web.
El servidor web, a su vez, confecciona una respuesta HTTP 
que será enviada por el cable.
El cliente recibe la respuesta y la interpreta, por ejemplo,
mostrándola como una página web.

## Cacheo

En el caso el cual el cacheo está habilitado,
la petición podría no viajar a través de todo el proceso anteriormente descrito.
El Cacheo puede ocurrir dentro Merb, en un middleware del Rack, un servidor Proxy,
o el navegador web cliente.

[Apache]:             http://httpd.apache.org/
[GlassFesh]:          /deployment/jrupor
[mod\_proxy]:         http://httpd.apache.org/docs/2.0/mod/mod_proxy.html
[Mongrel]:            http://mongrel.rubyforge.org/
[MVC]:                /getting-started/mvc
[NginX]:              /deployment/nginx
[Phusion Passenger]:  /deployment/passenger
[Rack]:               http://rack.rubyforge.org/
[Thin]:               http://code.macournoyer.com/thin/
[middlewares]: ...
[URI]: ...
