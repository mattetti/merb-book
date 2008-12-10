# Estrutura do projeto
A estrutura típica de uma nova aplicação Merb (gerada com <tt>merb-gen app</tt>)
irá se parecer com:

    Diretório da aplicação (Merb.root)
      - app
        - controllers
        - helpers
        - models
        - views
          - exceptions
          - layout
      - autotest
      - config
        - environments
      - doc
      - gems
      - merb
      - public
        - images
        - javascripts
        - stylesheets
      - spec
      - tasks

Segue uma breve explicação sobre cada diretório e seu propósito.

## app
Este diretório é onde você irá gastar a maior parte de seu tempo,
já que ele contem as "tripas" da sua aplicação Merb.

### controllers
Todos os <i>controllers</i> da sua aplica&ccedil;&atilde;o s&atilde;o guardados aqui (sem maiores surpresas).
<i>Controllers</i> s&atilde;o, tipicamente, nomeados de uma forma pluralizada.
Por exemplo, se voc&ecirc; tiver um <i>model</i> "<tt>Page</tt>" o arquivo <i>controller</i> ir&aacute; ter o nome <tt>pages.rb</tt>.
Isto &eacute; uma conven&ccedil;&atilde;o, portanto voc&ecirc; est&aacute; livre para nomear seus <i>controllers</i> da maneira que quiser.
Veja a seção [controllers][] para maiores informações.

### models
Este diret&oacute;rio cont&eacute;m suas classes <i>model</i>.
Estas classes servem como seus [ORM][]s,
que permite um acesso orientado a objetos para as suas tabelas do banco de dados.
Veja a seção [models][] para maiores informações.

### views
Qualquer <i>template</i> ser&aacute; guardado aqui.
Por default, este diret&oacute;rio cont&eacute;m os subdiret&oacute;rios <tt>exceptions</tt>
e <tt>layout</tt>.
O diret&oacute;rio <tt>exceptions</tt> guarda <i>templates</i> que s&atilde;o, geralmente,
relacionados aos erros de HTTP.
Por exemplo, uma nova aplica&ccedil;&atilde;o Merb ir&aacute; conter um
arquivo <tt>not_found.html.{erb,haml}</tt> que corresponde ao c&oacute;digo
de status HTTP 404.
O diret&oacute;rio <tt>layout</tt> cont&eacute;m <i>templates</i> globais da aplica&ccedil;&atilde;o,
no qual as <i>actions templates</i> podem ser renderizadas.
O arquivo de <i>layout</i> default da aplica&ccedil;&atilde;o &eacute; o
<tt>application.html.{erb,haml}</tt>.
Veja a seção [views][] para maiores informações.

## config
Sim, você advinhou.
Os arquivos de configuração do Merb estão localizados aqui.
O arquivo <tt>router.rb</tt> contém a URL da sua aplicação [routes][],
que define a estrutura, ordem e aparência das suas URLs.
Outro arquivo importante, <tt>init.rb</tt>, trata da configuração de base do Merb.
This is where you can configure your ORM, template engine,
and testing framework.
You can also add custom configuration to the <tt>Merb::BootLoader</tt>
in its <tt>before_app_loads</tt> and <tt>after_app_loads</tt> blocks.
Another important file, <tt>dependencies.rb</tt>,
is where you can define your application's dependencies:
other libraries or gems that your application requires.
Any dependency listed in that file will be loaded when your Merb app starts.

### environments
Here is where any environment-specific configuration files are located.
There are a few default (pure Ruby) configuration files;
each corresponds to a specific Merb environment
(development, production, etc.).

## gems
When you get ready to [deploy][] your application,
it's recommended that you [bundle][] all of your dependencies
inside the application directory.
The <tt>gems</tt> directory is where these packaged dependencies
will be stored.
When you start the Merb application,
it will load any gems from this directory, overriding the system-wide gems.

## public
Here is where you can store "static" files,
such as the <tt>favicon.ico</tt> and <tt>robots.txt</tt> files.

### images
Any images that your templates might use should go here.

### javascripts
In the default "Merb stack", this directory contains two files:
<tt>application.js</tt> and <tt>jquery.js</tt>.
The default Merb stack comes packaged
with the wonderful [jQuery][] JavaScript framework.

If you have relatively small amounts of application-specific JavaScript code,
it should go inside the <tt>application.js</tt> file.
If this proves unwieldy, however, you can add subsidiary files as needed.

### stylesheets
In keeping with the separation of concerns,
any visual styling should be placed in a stylesheet.
When you generate a Merb app,
it creates a stylesheet file (called <tt>master.css</tt>),
which you can customize to your heart's content.

## spec
If you're using [RSpec][] as your [testing][] framework,
this directory will contain those tests.
By default, this directory contains two files:
an empty <tt>spec.opts</tt> file,
which you can use to add command-line arguments to rspec
(add colorized output, etc.) and <tt>spec_helper.rb</tt>,
which is where you can customize the actual spec runner (among other things).

## tasks
This directory contains Merb's [thor][] tasks.


[bundle]:           /deployment/bundle
[controllers]:      /getting-started/controllers
[deploy]:           /deployment
[jQuery]:           http://jquery.com/
[models]:           /getting-started/models
[ORM]:              http://en.wikipedia.org/wiki/Object-relational_mapping
[routes]:           /getting-started/router
[RSpec]:            http://rspec.info/
[testing]:          /testing-your-application
[thor]:             http://wiki.merbivore.com/faqs/thor
[views]:            /getting-started/views
