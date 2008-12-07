# Comenzando
Neccesitaremos instalar Merb para usar la plataforma. Claro, antes de que instalemos Merb necesitarás tener instalado un compilador C, Ruby y [RubyGems](http://www.rubygems.org/), y una base de datos (si quieres hacer tus modelos persistentes).

## OS X

### Prerequisitos
Necesitarás instalar XCode del CD OS X o descargarle del [sitio web para desarrolladores de Apple](http://developer.apple.com/technology/xcode.html).

### Ruby & RubyGems
Si tienes OS X 10.5 (Leopard), es muy probable que tengas ya Ruby instalado.

### Merb
    $ sudo gem install merb


## Linux

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
