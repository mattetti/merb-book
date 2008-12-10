# Começando
Você precisará instalar o Merb para usar o framework.
Entretanto, antes de instalar o Merb,
você precisará ter instalado um compilador C, o Ruby e o [RubyGems][],
e um banco de dados (se quiser persistir seus models).

## OS X

### Pré-requisitos
Você precisará instalar o XCode (Developer Tools) a partir do DVD do OS X
ou fazer o download no [Apple developer website][].

### Ruby & RubyGems
Se você tem o OS X 10.5 (Leopard),
é bem provável que você já tenha o Ruby instalado.

### Merb
    $ sudo gem install merb


## Linux
As instruções seguintes são para distribuições baseados no Debian ([Ubuntu][], por exemplo),
que usa o gerenciador de pacotes <tt>apt-get</tt>.
Se você estiver usando uma distribuição diferente, use o gerenciador de pacotes desta distribuição
(por examplo, sistemas [RedHat][] usam o <tt>yum</tt> como seu gerenciador de pacotes).

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


## Windows
Usuários de Windows tem diversas opções para instalar o Ruby e RubyGems.
Uma maneira é fazer download dos binários do Ruby, instalá-los, e então instalar o RubyGems.

Uma alternativa é usar o [One-Click Ruby Installer][]
que já vem com o RubyGems (e algumas outras coisas). Se você usar
o One-Click Installer, tenha certeza de habilitar a caixa 'Enable RubyGems' no
assistente de instalação.

Por padrão, ele instalará o Ruby no diretório <tt>C:\Ruby</tt>.
Depois de instalado, faça o seguinte:

Iniciar --&gt; Programas --&gt; Ruby-&lt;versão&gt; --&gt; RubyGems --&gt; RubyGems Package Manager

Isto abrirá um prompt de comando no diretório <tt>C:\Ruby</tt> e mostrar
algumas informações de uso. Depois, basta apenas instalar o Merb:

    C:\Ruby> gem install merb

Este comando pode levar algums minutos para terminar, visto que ele atualizará o cache da gem,
buscar todas as gems relacionadas ao Merb e instalá-las.

_Nota_: Se você quiser usar o banco de dados SQLite (que é o padrão), você deve
fazer download e instalá-lo separadamente. Mais informações podem ser encontradas no
site do [SQLite][].


[Apple developer website]:  http://developer.apple.com/technology/xcode.html
[RubyGems]:                 http://www.rubygems.org/
[Ubuntu]:                   http://www.ubuntu.com/
[RedHat]:                   http://www.redhat.com/
[One-Click Ruby Installer]: http://rubyinstaller.rubyforge.org/wiki/wiki.pl
[SQLite]:                   http://www.sqlite.org/
