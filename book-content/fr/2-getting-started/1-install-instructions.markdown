# Mise en route
Nous aurons besoin d'installer Merb afin d'utiliser le framework. Toutefois, avant que nous installions Merb vous aurez besoin d'installer, un compilateur C, Ruby et [RubyGems](http://www.rubygems.org/), et une base de données (si vous voulez persister vos modèles).

## OS X

### Pré-requis
Vous aurez besoin d'installer XCode depuis le CD OS X ou bien en le téléchargeant depuis le [site développeur d'Apple](http://developer.apple.com/technology/xcode.html).

### Ruby et RubyGems
Si vous possédez OS X 10.5 (Leopard), alors vous avez plus de chance. Vous avez déjà Ruby d'installé.

### Merb
    $ sudo gem install merb


## Linux

### Pré-requis

    $ sudo apt-get install build-essential libxslt-dev libsqlite3-0 libsqlite3-dev

### Ruby et RubyGems

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
