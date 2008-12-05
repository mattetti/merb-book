# Getting started
We will need to install Merb in order to use the framework. However, before we install Merb you will need to have installed, a C compiler, Ruby and [RubyGems](http://www.rubygems.org/), and database (if you want to persist your models).

## OS X

### Prerequisites
You will need to install XCode from the OS X CD or download it from the [Apple developer website](http://developer.apple.com/technology/xcode.html).

### Ruby & RubyGems
If you have OS X 10.5 (Leopard), then most likely you already have Ruby installed.

### Merb
    $ sudo gem install merb


## Linux

### Prerequisites

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
