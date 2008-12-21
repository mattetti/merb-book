# 生成一个应用程序

* This will become a table of contents (this text will be scraped).
{:toc}

Merb配备一个生成器(``merb-gen``)用以创造Merb应用程序。该生成器可以产生不同类型的Merb应用;想了解所有可用的生成器选项，键入

    $ merb-gen -H
{:lang=shell html_use_syntax=true}

现在，让我们暂时只关注可以生成的几种类型的Merb应用。

## 类型
Merb可用于任何应用，从非常小，快，单文件应用到大型的，复杂的网络服务。取决于开发人员的需求，可以生成不同的应用结构，您可以生成的应用程序包括，``app``, ``core``, ``flat``, 和 ``very_flat``.


### App
生成一个完整的目录结构的应用与一套完整的配置文件。它还增加了``config/dependencies.rb``文件，其中包括所有的``merb-more``和``DataMapper``。

    $ merb-gen app my-application
{:lang=shell html_use_syntax=true}

此应用程序包含开始建立一个网络应用程序所需的一切，非常相似默认结构的Ruby on Rails应用。这本书的大部分将假设你已经开始用这种方式。

在应用程序的根目录运行merb。这将启动Merb并把它绑定到的默认端口4000 。要查看您的应用程序，访问 <http://localhost:4000/>。

### Core
Core将产生全部应用程序的目录结构，包括一套完整的配置文件。与``App``不同的是``Core``没有加入对其他gems的依赖。

    $ merb-gen core my-application
{:lang=shell html_use_syntax=true}

在应用程序的根目录运行merb启动此应用程序。在这里必须指出，与其他三个产生的应用程序不同，Core没有预设内容。直接访问 <http://localhost:4000/> 将产生错误，开发人员需要自己增加内容和路由。

### Flat
一个Flat的应用将所有的逻辑放在一个单一文件中，配制信息会放到其他单独的文件中，并且拥有自己的view目录。

    $ merb-gen flat my-application
{:lang=shell html_use_syntax=true}

Flat的应用像任何其他merb应用一样，在应用程序的根目录运行merb启动此应用程序。根据预设，所有在类``my-application``中的方法将被视为控制器的action。例如：<http://localhost:4000/my-application/foo>

这将调用``MyApplication#foo``，并且在渲染输出中使用``foo.html``模板。

### Very Flat
一个Very Flat的应用类似于其他Ruby微型框架，那就是将整个应用放在一个文件中。

    $ merb-gen very_flat my-applcation
{:lang=shell html_use_syntax=true}

在应用程序的根目录中启动此应用程序:

    $ merb -I my-application.rb
{:lang=shell html_use_syntax=true}

这将启动Merb并把它绑定到的默认端口4000 。要查看您的应用程序，访问 <http://localhost:4000/>。
