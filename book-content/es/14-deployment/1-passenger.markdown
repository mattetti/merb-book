# Passenger

![Phusion Passenger](/images/phusion_banner.png){: .no-border}

**Sitio web de referencia:** [documentación sobre Passenger][]{: .reference}

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

[Passenger][], desarrollado por la empresa holandesa [Phusion][],  
es un modelo de [Apache][] para desplegar aplicaciones [Rack][].
Como Merb fue desarrollado como un Rack, 
usted puede ejecutar su aplicación Merb fácilmente 
en [Passenger][] utilizando [Ruby Edición Empresarial][].
Este ultimo es una versión del interprete de Ruby versión 1.8.6 
que incluye mejoras en el sistema de recolección de basura y 
el cual reduce el uso de memoria de las aplicaciones en un 33%.

A continuación se le presentaran las instrucciones para su instalación, 
las cuales son solamente para sistemas operativos Linux.

## Instalando Ruby Edicion Empresarial (REE)
Este interprete puede ser instalado 
junto a su versión del interprete Ruby 
que usted tiene ya instalado.
Esta versión será instalada dentro del directorio ``/opt``.

*Nota:* 
Usted requerirá tener ya instalada la librería ``readline``
si desea ejecutar Merb de manera interactiva.

### Bajar REE
Usted debe ejecutar el siguiente comando en su linea de comandos

    $ wget http://rubyforge.org/frs/download.php/41040/ruby-enterprise-1.8.6-20080810.tar.gz
{:lang=shell html_use_syntax=true}

### Instalación
A continuación se le presentara la secuencia que debe seguir
a fin de descomprimir el archivo bajado 

    $ tar xzvf ruby-enterprise-1.8.6-20080810.tar.gz
    $ cd ruby-enterprise-1.8.6-20080810
    $ ./installer
{:lang=shell html_use_syntax=true}

## Instalando Passenger
Luego, usted debe ejecutar los siguiente comandos 
a fin de proceder con la instalación e integración con [Apache][]

    $ gem install passenger
    $ passenger-install-apache2-module
{:lang=shell html_use_syntax=true}

## Configuracion
### El archivo "config.ru"
Este archivo requiere ser creado 
dentro del directorio raíz de su aplicación Merb.

    # config.ru
    require 'rubygems'
	require 'merb-core'
	
    # Quitar los comentarios en caso que su aplicación utiliza gemas empaquetadas.
    # gems_dir = File.expand_path(File.join(File.dirname(__FILE__), 'gems'))
    # Gem.clear_paths
    # $BUNDLE = true
    # Gem.path.unshift(gems_dir)

    Merb::Config.setup(:merb_root   => File.expand_path(File.dirname(__FILE__)),
                       :environment => ENV['RACK_ENV'])
    Merb.environment = "production" # Merb::Config[:ambiente]
    Merb.root = Merb::Config[:merb_root]
    Merb::BootLoader.run

    # Quitar comentarios en el caso que su aplicación sea montada en un sub-URI.
    # if prefix = ::Merb::Config[:prefijo_camino]
    #   use Merb::Rack::PathPrefix, prefijo
    # end

    run Merb::Rack::Application.new
{:lang=ruby html_use_syntax=true}

## Tareas para Capistrano

[Passenger]: http://www.modrails.com/
[Phusion]: ...
[Apache]: ...
[Rack]: http://rack.rubyforge.org/
[Ruby Edición Empresarial]: http://www.rubyenterpriseedition.com/
[documentación sobre Passenger]: http://www.modrails.com/documentation/Users%20guide.html

* [REE]: Ruby Edición Empresarial
