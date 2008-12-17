# 安装指导

* This will become a table of contents (this text will be scraped).
{:toc}

您需要安装Merb ，以便使用该框架。然而，在安装Merb之前 ，您将需要安装C编译器， Ruby和[RubyGems][] ，以及数据库（如果你想持久化你的模型） 。

## OS X

### 先决条件 
您需要安装XCode（又名开发工具），你可以由Mac OS X的DVD安装，或从苹果公司开发网站下载([Apple developer website][])。

### Ruby & RubyGems
如果您使用OS X 10.5(Leopard)，很可能您已经有预先安装好的Ruby。

### Merb
    $ sudo gem install merb


## Linux
下面的说明是以Debian为基础的Linux发行版本(例如，[Ubuntu][])，使用apt-get作为包管理器。如果您使用的是一个不同的发行版本，请使用其提供的软件包管理软件(例如，[RedHat][]系统使用yum)。

### 先决条件 

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
Windows用户有几个选择来安装Ruby和RubyGems 。一种方法是下载Ruby可执行文件，安装它们，然后安装RubyGems 。

另一种是使用[One-Click Ruby Installer][]，其本身包含了RubyGems和其他一些程序。但安装时，请务必选中“启用RubyGems”(Enable RubyGems)。

默认情况下，Ruby会被安装在C:\Ruby目录。一旦安装完毕，我们就可以安装Merb：

开始 --&gt; 程序 --&gt; Ruby-&lt;version&gt; --&gt; RubyGems --&gt; RubyGems Package Manager

这将打开一个命令提示符C:\Ruby，然后，安装Merb ： 

    C:\Ruby> gem install merb

此命令可能需要运行几分钟，因为它必须更新Ruby的缓存，获取所有Merb有关的gems，然后安装它们。

_注_：如果您想使用SQLite数据库（系统默认），您必须下载并单独安装它。更多信息可在[SQLite][]的网站找到。


<!-- Links -->
[Apple developer website]:  http://developer.apple.com/technology/xcode.html
[One-Click Ruby Installer]: http://rubyinstaller.rubyforge.org/wiki/wiki.pl
[RedHat]:                   http://www.redhat.com/
[RubyGems]:                 http://www.rubygems.org/
[SQLite]:                   http://www.sqlite.org/
[Ubuntu]:                   http://www.ubuntu.com/
