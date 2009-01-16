# Installatie instructies

* This will become a table of contents (this text will be scraped).
{:toc}

Om het framework te gebruiken moeten we eerst Merb installeren. 
Maar, voor je Merb kan installeren 
moet je een C compiler, Ruby en [RubyGems][] installeren 
en een database (indien je jouw modellen wil persisteren).

## OS X

### Vereisten
Je zal XCode (aka Developer Tools) moeten installeren van de Mac OS X DVD 
of downloaden van de [Apple developer website][].

### Ruby & RubyGems
Heb je OS X 10.5 (Leopard), 
dan heb je hoogstwaarschijnlijk ook reeds een installatie van Ruby.

### Merb
    $ sudo gem install merb


## Linux
Volgende instructies zijn voor Debian-gebaseerde distributies ([Ubuntu][], bijvoorbeeld),
die de <tt>apt-get</tt> package manager gebruikt.
Indien je een andere distributie gebruikt, gebruik dan de package manager van die distributie
(bvb. [RedHat][] systemen gebruiken <tt>yum</tt> als package manager)

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

## Windows
Windows gebruikers hebben een antal opties om Ruby en RubyGems te installeren.
een mogelijkheid is de Ruby binaries te downloden, ze te installeren, en daarna RubyGems te installeren.

Een alternatief is de [One-Click Ruby Installer][] te gebruiken
die (samen met een aantal andere zaken) wordt gepackaged met RubyGems.
Indien je de One-Click Installer gebruikt,
vink dan zeker de "Enable RubyGems" checkbox aan in de installatie wizard.

Standaard, zal het Ruby in de <tt>C:\Ruby</tt> directory installeren.
Eend geinstalleerd, doe je het volgende:

Start --&gt; Programs --&gt; Ruby-&lt;version&gt;
--&gt; RubyGems --&gt; RubyGems Package Manager

Dit opent een commando prompt in de <tt>C:\Ruby</tt> directory
en toont wat gebruiksinformatie.
Hierna is het enkel een kwestie om Merb te installeren:

    C:\Ruby> gem install merb

Dit commando loopt gedurende een aantal minuten,
omdat het de gem cache moet updaten, alle Merb-gerelateerde gems moet ophalen,
en deze dan installeren.

_Nota_: Indien je de SQLite database wenst te gebruiken (dit is de standaard instelling),
mote je deze apart downloaden en installeren.
Meer informatie kan worden gvonden op de [SQLite][] site.


<!-- Links -->
[Apple developer website]:  http://developer.apple.com/technology/xcode.html
[One-Click Ruby Installer]: http://rubyinstaller.rubyforge.org/wiki/wiki.pl
[RedHat]:                   http://www.redhat.com/
[RubyGems]:                 http://www.rubygems.org/
[SQLite]:                   http://www.sqlite.org/
[Ubuntu]:                   http://www.ubuntu.com/
