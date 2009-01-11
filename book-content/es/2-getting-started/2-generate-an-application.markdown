# Generar un aplicación

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

Merb viene con un generador (``merb-gen``) 
para crear aplicaciones. 
Este generador puede crear diferentes tipos aplicaciones; 
para ver todas las opciones del mismo, 
escriba en la linea de comandos

	$ merb-gen -H
{:lang=shell html_use_syntax=true}

Por ahora, limitémonos solamente a los tipos de aplicaciones Merb 
que pueden ser generadas a través del mismo.

## Tipos
Merb puede ser usado para desarrollar desde aplicaciones consistentes en un solo archivo,
muy pequeñas y rápidas hasta grandes y complejos web services.
Diferentes estructuras para la aplicación pueden generarse, dependiendo de las necesidades
del desarrollador.
Las diferentes estructuras que usted puede generar 
son ``app``, ``core``, ``flat`` y ``very_flat``.

### App (stack)
El stack dogmático de Merb.
Esta opción genera una estructura de directorios completa para una aplicación 
con un conjunto completo de archivos de configuración.
También agrega el archivo ``config/dependancies.rb`` 
que incluye las todas las librerías contenidas en ``merb-more`` y ``DataMapper``.

    $ merb-gen app my-application
{:lang=shell html_use_syntax=true}

Esta aplicación contiene todo lo necesario 
para comenzar a construir una aplicación web de primer nivel; 
la cual es muy similar a la estructura típica de una aplicación Rails.
Este libro parte de la suposición 
de que usted ha comenzado a desarrollar una aplicación de este tipo.

Inicie esta aplicación ejecutando ``merb`` 
en el directorio raíz de la aplicación.
Esto iniciará Merb y lo pondrá a escuchar en el puerto por defecto 4000.
Para ver su aplicación en acción, 
visita <http://localhost:4000/> en su navegador web.

### Core (núcleo)
Core generará una estructura de directorios completa para una aplicación 
con un conjunto completo de archivos de configuración.
A diferencia de la opción ``app`` -- el stack dogmática y completo -- 
ninguna dependencia será agregada a la aplicación.

    $ merb-gen core my-application
{:lang=shell html_use_syntax=true}

Inicie esta aplicación ejecutando ``merb`` 
en el directorio raíz de la aplicación.
Fíjese que, a diferencia de las otras tres aplicaciones generadas, 
en core no existe contenido por defecto definido.
Visitando <http://localhost:4000/> en su navegador web 
generará un error hasta que adicione contenido y lo enrute.

### Flat (plana)
Una aplicación plana mantiene toda su lógica en un solo archivo, 
pero tiene archivos de configuración separados y un directorio propio para las vistas.

    $ merb-gen flat my-application
{:lang=shell html_use_syntax=true}

Este tipo de aplicación se inicializa, como cualquier otra aplicación generada por Merb,
ejecutando ``merb`` en el directorio raíz de la aplicación.
Por defecto, todos los métodos en la clase ``my-application`` 
serán tratados como acciones con ``my-application`` como el controlador. 
Por ejemplo: <http://localhost:4000/my-application/foo>

Esto invocará ``MyApplication#foo`` 
y creará la salida desde la plantilla ``foo.html.*``.

### Very Flat (muy plana)
Este tipo de aplicación es similar a otros micro plataformas de Ruby, 
donde la aplicación completa se ubica en un solo archivo.

    $ merb-gen very_flat my-applcation
{:lang=shell html_use_syntax=true}

Para ejecutar una aplicación muy plana, inicia Merb con el siguiente comando 
(en el directorio de tu aplicación):

    $ merb -I my-application.rb
{:lang=shell html_use_syntax=true}

Esto arrancará  Merb y lo pondrá a escuchar en el puerto por defecto (4000). 
Para ver tu aplicación en acción, visita <http://localhost:4000/> en su navegador web.
