# Installation

* This will become a table of contents (this text will be scraped).
{:toc}

Nous aurons besoin d'installer Merb afin d'utiliser le framework.
Toutefois, avant que nous installions Merb
vous aurez besoin d'installer, un compilateur C, Ruby et [RubyGems][],
et une base de données (si vous voulez persister vos modèles).

## OS X

### Pré-requis
Vous aurez besoin d'installer XCode depuis le DVD d'installation OS X
ou bien en le téléchargeant depuis le [site développeur d'Apple][].

### Ruby et RubyGems
Si vous possédez OS X 10.5 (Leopard),
il est probable que Ruby soit déjà installé.

### Merb

    $ sudo gem install merb
{:lang=shell html_use_syntax=true}


## Linux
Les instructions suivantes sont faite pour une distribution du type Debian ([Ubuntu][], par exemple),
qui utilise le gestionnaire de paquets <tt>apt-get</tt>.
Si vous utilisez une distribution différente, utilisez le gestionnaire de paquets de cette distribution
(par exemple, les systèmes [RedHat][] utilisent <tt>yum</tt> comme gestionnaire de paquets).

### Pré-requis

    $ sudo apt-get install build-essential libxslt-dev libsqlite3-0 libsqlite3-dev
{:lang=shell html_use_syntax=true}

### Ruby et RubyGems

    $ sudo apt-get ruby ruby1.8-dev rdoc irb libyaml-ruby libzlib-ruby ri libopenssl-ruby libxml-ruby
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
Les utilisateurs de Windows peuvent choisir entre plusieurs options pour installer Ruby et Rubygems.
La première façon est de télécharger les binaires Ruby, les installer, puis d'installer RubyGems.

Une alternative est de se servir de [l'installeur Ruby One-Click][]
qui inclut RubyGems (ainsi que quelques autres paquets). Si vous utilisez
l'installeur One-Click, vérifiez que vous avez coché la case "Enable RubyGems" durant
l'installation.

Par défaut, il installera Ruby dans le répertoire <tt>C:\Ruby</tt>.
Une fois installé, exécutez le programme suivant:

Démarrer --&gt; Programmes --&gt; Ruby-&lt;version&gt; --&gt; RubyGems --&gt; RubyGems Package Manager

Cela ouvrira une console avec une ligne de commande dans le répertoire <tt>C:\Ruby</tt> et affichera
des informations d'utilisation. Après, il vous suffit d'installer Merb:

    C:\Ruby> gem install merb
{:lang=shell html_use_syntax=true}

Cette commande peut nécessiter quelques minutes pour se terminer, elle doit mettre à jour
le cache des gems, récupérer tous les gems relatifs à Merb et les installer.

_Note_: Si vous voulez utilisez la base de données SQLite (qui vient par défaut), vous devez
la télécharger et l'installer séparément. Vous aurez plus d'informations sur le site [SQLite][]


[site développeur d'Apple]:     http://developer.apple.com/technology/xcode.html
[RubyGems]:                     http://www.rubygems.org/
[Ubuntu]:                       http://www.ubuntu.com/
[RedHat]:                       http://www.redhat.com/
[l'installeur Ruby One-Click]:  http://rubyinstaller.rubyforge.org/wiki/wiki.pl
[SQLite]:                       http://www.sqlite.org/