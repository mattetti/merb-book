# Install instruction

* This will become a table of contents (this text will be scraped).
{:toc}

You will need to install Merb in order to use the framework.
However, before installing Merb,
you will need to have installed a C compiler, Ruby and [RubyGems][],
and a database (if you want to persist your models).

## OS X

### Prerequisites
You will need to install XCode (aka Developer Tools) from the Mac OS X DVD
or download it from the [Apple developer website][].

### Ruby & RubyGems
If you have OS X 10.5 (Leopard),
it is likely that you already have Ruby installed.

### Merb
    $ sudo gem install merb


## Linux
The following instructions are for Debian-based distributions ([Ubuntu][], for example),
which uses the <tt>apt-get</tt> package manager.
If you are using a different distribution, use that distribution's package manager
(for example, [RedHat][] systems use <tt>yum</tt> as its package manager).

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


## Windows
Windows users have a couple of options for installing Ruby and RubyGems.
One way is to download the Ruby binaries, install them, and then install RubyGems.

An alternative is to use the [One-Click Ruby Installer][]
which comes packaged with RubyGems (as well as a few other things). If you use
the One-Click Installer, make sure you check the 'Enable RubyGems' box in the
install wizard.

By default, it will install Ruby in the <tt>C:\Ruby</tt> directory.
Once installed, do the following:

Start --&gt; Programs --&gt; Ruby-&lt;version&gt; --&gt; RubyGems --&gt; RubyGems Package Manager

This will open a command prompt in the <tt>C:\Ruby</tt> directory and display
some usage information.  Then it's just a simple matter of installing Merb:

    C:\Ruby> gem install merb

This command might take a couple of minutes to run, since it must update the gem
cache, fetch all Merb related gems and then install them.

_Note_: If you want to use SQLite database (which is the default), you must
download and install it separately. More information can be found on the
[SQLite][] site.


[Apple developer website]:  http://developer.apple.com/technology/xcode.html
[RubyGems]:                 http://www.rubygems.org/
[Ubuntu]:                   http://www.ubuntu.com/
[RedHat]:                   http://www.redhat.com/
[One-Click Ruby Installer]: http://rubyinstaller.rubyforge.org/wiki/wiki.pl
[SQLite]:                   http://www.sqlite.org/
