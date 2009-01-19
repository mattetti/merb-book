# Instrucciones para la instalación

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

Se necesita instalar Merb para usar la plataforma.
De todas maneras, antes de instalar Merb, 
usted necesitará tener instalado un compilador C, Ruby y [RubyGems][], 
y una base de datos (si usted desea hacer sus modelos persistentes).

## OS X
### Prerequisitos
Necesitará instalar XCode (conocido como las Herramientas de Desarrollo) 
del DVD del sistema operativo OS X o descargarlo directamente del
[sitio web para desarrolladores de Apple][].

### Ruby & RubyGems
En el caso que usted tenga instalado en su sistema OS X 10.5 (Leopard), 
entonces su sistema ya cuenta con Ruby instalado y listo para su uso.

### Merb
    $ sudo gem install merb
{:lang=shell html_use_syntax=true}

## Linux
Las siguientes instrucciones son para aquellas distribuciones basadas en [Debian][] 
([Ubuntu][], por ejemplo) que usen el manejador de paquetes ``apt-get``.
Si usted utiliza una distribución diferente, use el manejador de paquetes de su distribución
(por ejemplo, los sistemas [RedHat][] usan ``yum`` como su manejador de paquetes).

### Prerequisitos
    $ sudo apt-get install build-essential libxslt-dev libsqlite3-0 libsqlite3-dev
{:lang=shell html_use_syntax=true}

### Ruby & RubyGems
    $ sudo apt-get ruby ruby1.8-dev rdoc irb libyaml-ruby libzlib-ruby ri libopenssl-ruby \
      libxml-ruby
{:lang=shell html_use_syntax=true}

    $ wget "http://rubyforge.org/frs/download.php/45905/rubygems-1.3.1.tgz"
    $ tar -xvzf rubygems-1.3.1.tgz
    $ rm rubygems-1.3.1.tgz
    $ cd rubygems-1.3.1
    $ sudo ruby setup.rb
    $ cd ..
    $ rm -r rubygems-1.3.1
    $ sudo ln -s /usr/bin/gem1.8 /usr/bin/gem
    $ sudo gem update --system
{:lang=shell html_use_syntax=true}

### Merb
    $ sudo gem install merb
{:lang=shell html_use_syntax=true}

## Windows
Los usuarios de Windows tienen un par de opciones para instalar Ruby and RubyGems.
Una manera es descargar los binarios de Ruby, instalarlos, y luego instalar RubyGems.

Una alternativa es usar el [One-Click Ruby Installer][] 
que viene empaquetado con RubyGems (y algunas otras cosas).
Si usted utiliza el One-Click Installer, 
asegúrese de seleccionar la opción 'Enable RubyGems' durante la instalación.

Por defecto, Ruby se instalara en el directorio ``C:\Ruby``.
Una vez instalado, usted debe hacer lo siguiente:

Start --&gt; Programs --&gt; Ruby-&lt;version&gt; --&gt; RubyGems --&gt; RubyGems Package Manager

Esto abrirá un prompt de comando en el directorio ``C:\Ruby`` 
y mostrará alguna información sobre cómo usarlo. 
Entonces es solo a cuestión de instalar Merb:

    C:\Ruby> gem install merb
{:lang=shell html_use_syntax=true}

Este comando puede demorar unos minutos en ejecutarse, 
pues debe actualizar la cache de las gemas, 
traer todas las gemas relacionadas con Merb e instalarlas.

_Nota_: Si desea usar una base de datos SQLite (la cual viene por defecto), 
usted debe descargarla e instalarla por separado. 
Más información puede ser encontrada en el sitio de [SQLite][].

[sitio web para desarrolladores de Apple]: http://developer.apple.com/technology/xcode.html
[Debian]: http://www.debian.org/
[RubyGems]: http://www.rubygems.org/
[Ubuntu]: http://www.ubuntu.com/
[RedHat]: http://www.redhat.com/
[One-Click Ruby Installer]: http://rubyinstaller.rubyforge.org/wiki/wiki.pl
[SQLite]: http://www.sqlite.org/

