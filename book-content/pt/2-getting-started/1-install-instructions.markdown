# Começando
Nós precisaremos instalar o Merb para usar o framework. Entretanto, antes disso você precisará instalar um compilador C, o Ruby e o [RubyGems](http://www.rubygems.org/), e um servidor de banco de dados (se quiser persistir seus models).

## OS X

### Pré-requisitos
Você precisará instalar o XCode a partir do CD do OS X ou fazer o download no [Apple developer website](http://developer.apple.com/technology/xcode.html).

### Ruby & RubyGems
Se você tem o OS X 10.5 (Leopard), então provavelmente você já tem o Ruby instalado.

### Merb
    $ sudo gem install merb


## Linux

### Pré-requisitos

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
