# Aan de slag
Om het framework te gebruiken moeten we eerst Merb installeren. Maar, voor je Merb kan installeren moet je een C compiler, Ruby en [RubyGems](http://www.rubygems.org/) installeren en een database (indien je je modellen wil persisteren).

## OS X

### Vereisten
Je zal XCode (aka Developer Tools) moeten installeren van de Mac OS X DVD of downloaden van de [Apple developer website](http://developer.apple.com/technology/xcode.html).

### Ruby & RubyGems
Heb je OS X 10.5 (Leopard), dan heb je hoogstwaarschijnlijk ook reeds een installatie van Ruby.

### Merb
    $ sudo gem install merb


## Linux

### Vereisten

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
