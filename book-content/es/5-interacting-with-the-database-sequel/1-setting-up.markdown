# Instalación y configuración

## Generando un proyecto utilizando Sequel
A fin de crear una aplicación Merb utilizando Sequel, 
usted debe agregar la opción ``--orm`` 
cuando ejecute el comando ``merb-gen``.

    $ merb-gen core --orm sequel nueva_aplicacion
{:lang=shell html_use_syntax=true}

Este comando construirá el esqueleto de la aplicación.

A fin de lograr resultados similares a los descriptos anteriormente,
usted puede utilizar la gema ``merb-sequel-stack``.

    $ git clone git://github.com/jackdempsey/merb-sequel-stack.git
    $ cd merb-sequel-stack/
    $ rake install
{:lang=shell html_use_syntax=true}
    
El comando ``merb-gen`` ahora incluirá el generador ``sequel-app``.
Este generara una aplicación que utilice Sequel, RSpec y las demás 
funcionalidades que se esperan del comando ``merb-gen app``.
    
    $merb-gen sequel-app nueva_aplicación
{:lang=shell html_use_syntax=true}
    
Por defecto, el comando ``merb-gen sequel-app`` generará 
el archivo ``.config/database.yml`` que utilizará el adaptador SQLite3.

Para mas información, por favor referirse a la página del [stack Sequel Merb][].

[stack Sequel Merb]: http://github.com/jackdempsey/merb-sequel-stack/tree
