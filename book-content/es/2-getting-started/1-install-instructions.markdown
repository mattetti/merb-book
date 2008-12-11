# Comenzando

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

Necesitaremos instalar Merb para usar la plataforma.
Claro, antes de que instalemos Merb necesitarás tener instalado un compilador C, Ruby y
[RubyGems][], y una base de datos (si quieres hacer tus modelos persistentes).

## OS X

### Prerequisitos
Necesitarás instalar XCode del CD OS X o descargarle del
[sitio web para desarrolladores de Apple][].

### Ruby & RubyGems
Si tienes OS X 10.5 (Leopard), es muy probable que tengas ya Ruby instalado.

### Merb
    $ sudo gem install merb


## Linux
Las siguientes instrucciones son para distribuciones basadas en Debian ([Ubuntu][], por
ejemplo) que usen el manejador de paquetes <tt>apt-get</tt>.
Si estás usando una distribución diferente, usa el manejador de paquetes de tu distribución
(por ejemplo, los sistemas [RedHat][] usan <tt>yum</tt> como su manejador de paquetes).

### Prerequisitos

    $ sudo apt-get install build-essential libxslt-dev libsqlite3-0 libsqlite3-dev

### Ruby & RubyGems

    $ sudo apt-get ruby ruby1.8-dev rdoc irb libyaml-ruby libzlib-ruby ri libopenssl-ruby \
      libxml-ruby

    $ wget "http://rubyforge.org/frs/download.php/45905/rubygems-1.3.1.tgz"
    $ tar -xvzf rubygems-1.3.1.tgz
    $ rm rubygems-1.3.1.tgz
    $ cd rubygems-1.3.1
    $ sudo ruby setup.rb
    $ cd ..
    $ rm -r rubygems-1.3.1
    $ sudo ln -s /usr/bin/gem1.8 /usr/bin/gem
    $ sudo gem update --system


### Merb

    $ sudo gem install merb


## Windows
Los usuarios de Windows tienen un par de opciones para instalar Ruby and RubyGems.
Una manera es descargar los binarios de Ruby, instalarlos, y luego instalar RubyGems.

Una alternativa es usar el [One-Click Ruby Installer][] que viene empaquetado con RubyGems
(y algunas otras cosas).
Si usas el One-Click Installer, asegúrate de seleccionar la opción 'Enable RubyGems' en el
wizard de instalación.

Por defecto te instalará Ruby en el directorio <tt>C:\Ruby</tt>.
Una vez instalado, has lo siguiente:

Start --&gt; Programs --&gt; Ruby-&lt;version&gt; --&gt; RubyGems --&gt; RubyGems Package Manager

Esto abrirá un prompt de comando en el directorio <tt>C:\Ruby</tt> y mostrará alguna
información sobre cómo usar.  Entonces es solo a cuestión de instalar Merb:

    C:\Ruby> gem install merb

Este comando puede demorar unos minutos en ejecutarse, pues debe actualizar la cache de
las gemas, traer todas las gemas relacionadas con Merb e instalarlas.

_Nota_: Si quieres usar una base de datos SQLite (es la que viene por defecto), tienes que
descargarla e instalarla por separado. Más información puede ser encontrada en el sitio de
[SQLite][].

[sitio web para desarrolladores de Apple]: http://developer.apple.com/technology/xcode.html
[RubyGems]:                 http://www.rubygems.org/
[Ubuntu]:                   http://www.ubuntu.com/
[RedHat]:                   http://www.redhat.com/
[One-Click Ruby Installer]: http://rubyinstaller.rubyforge.org/wiki/wiki.pl
[SQLite]:                   http://www.sqlite.org/
