# Enpaquetando su aplicación Merb

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

## ¿Por qué empaquetar?
Mientras usted esta desarrollando en su computadora, 
su aplicacion puede estar funcionando perfectamente.
Esta depende de multiples librerias/gemas escritas en Ruby
que se encuentra actualmente instaladas en su computadora.

Mientras todo puede estar funcionando momentaneamente, 
probablemente las mismas gemas no estaran disponibles 
en el servidor que utilizara para el despliegue de su aplicacion.
En el caso que usted trabaje con otros desarrolladores, 
ellos pueden estar perdiendo dependencias o tener versiones distintas.

Usted puede tambien comenzar un uevo proyecto 
y utilizar una version actualizada de una determinada libreria, 
la cual puede crear algunos conflictos con su vieja aplicacion.

A fin de evitar los problemas mencionado anteriormente, 
es recomendable que empaquete o frize las dependencias de su aplicacion.

## Como empaquetar su aplicacion
A fin de empaquetar las dependencias que usted necesita:
 * el archivo ``config/dependencies.rb``
 * las ultimas tareas definidas en el archivo ``task/merb.thor``

En el caso de estar utilizando una version antigua de Merb, 
usted tal vez desea remover los archivos ``merb.thor`` existentes 
y regenerar una version actualizada:

    $ rm -rf tasks/merb.thor
    $ merb-gen thor
{:lang=shell html_use_syntax=true}

Asegurese que tiene el archivo ``dependencies.rb`` 
dentro del directorio ``/config`` o cree uno nuevo.

A continuacion se le presentara el archivo ``dependencies.rb``
generado por defecto por el stack Merb.

    # Las dependencies son generadas utilizando una version estricta, 
	# no se olvide de editar las versiones de las dependencias cuando 
	# actualice las versiones de las mismas.
    merb_gems_version = "1.0.8"
    dm_gems_version   = "0.9.11.1"

    # Para mas informacion sobre cada uno de los componentes, 
	# por favor referirse a la pagina http://wiki.merbivore.com/faqs/merb_components
    dependency "merb-action-args", merb_gems_version
    dependency "merb-assets", merb_gems_version  
    dependency "merb-cache", merb_gems_version   
    dependency "merb-helpers", merb_gems_version 
    dependency "merb-mailer", merb_gems_version  
    dependency "merb-slices", merb_gems_version  
    dependency "merb-auth-core", merb_gems_version
    dependency "merb-auth-more", merb_gems_version
    dependency "merb-auth-slice-password", merb_gems_version
    dependency "merb-param-protection", merb_gems_version
    dependency "merb-exceptions", merb_gems_version
    dependency "dm-core", dm_gems_version         
    dependency "dm-aggregates", dm_gems_version   
    dependency "dm-migrations", dm_gems_version   
    dependency "dm-timestamps", dm_gems_version   
    dependency "dm-types", dm_gems_version        
    dependency "dm-validations", dm_gems_version  
    dependency "merb_datamapper", merb_gems_version
    dependency "do_sqlite3" 
	# Reemplace esta ultima dependencia con la correspondiente a su motor de base de datos.
{:lang=ruby html_use_syntax=true}

Usualmente este archivo es requerido 
por el archivo ``config/init.rb`` de su aplicacion.

A fin de empaquetar todas estas dependencias en su archivo de dependencies, 
por favor ejecute el siguiente comando en su computadora de desarrollo.

    $ thor merb:gem:install
{:lang=shell html_use_syntax=true} 

Asegurese que los directorios ``./gems`` y ``./gems/cache``
son incluidos en su [manejador de codigo fuente][] ([Git][], por ejemplo).
Ademas, usted debe ignorar los contenidos incluidos 
en los directorios ``./gems/gems`` y ``./gems/specifications``.

Cada vez que usted actualice una dependencia requerida, 
no se olvide de ejecutar el comando mencionado anteriormente.

El motivo para realizar esta tarea es que las gemas nativas 
necesitan ser recompiladas en la plataforma de despliegue de su aplicacion o
en la computadora de los miembros de su equipo de desarrollo.

La proxima vez que alguien desee instalar su aplicacion o 
simplemente desplegarla, solo ejecute el siguiente comando:

    $ bin/thor merb:gem:redeploy
{:lang=shell html_use_syntax=true}

Este comando instalara las gemas que se encuentran en el cache 
pero no se instalaran aquellas gemas que no se encuentran disponibles localmente.

En el caso que usted este utilizando una solucion de despliegue 
tales como [Capistrano][] o [Vlad][], usted puede agregar este paso 
despues de que el codigo fuente haya sido marcado desde su [manejador de codigo fuente][].

[Git]: ...
[Capistrano]: ...
[Vlad]: ...
[manejador de codigo fuente]: ...
