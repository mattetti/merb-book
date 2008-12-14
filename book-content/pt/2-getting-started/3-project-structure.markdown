# Estrutura
A estrutura t&iacute;pica de uma nova aplica&ccedil;&atilde;o Merb (gerada com <tt>merb-gen app</tt>)
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
já que ele contém as "tripas" da sua aplicação Merb.

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
Sim, voc&ecirc; advinhou.
Os arquivos de configura&ccedil;&atilde;o do Merb est&atilde;o localizados aqui.
O arquivo <tt>router.rb</tt> cont&eacute;m configura&ccedil;&otilde;es 
sobre as URLs da sua aplica&ccedil;&atilde;o ([routes][]).
Nele &eacute; definido a estrutura, ordem e apar&ecirc;ncia das suas URLs.
Outro arquivo importante, <tt>init.rb</tt>, trata da configura&ccedil;&atilde;o de base do Merb.
Nele &eacute; onde voc&ecirc; pode configurar seu ORM, <i>template engine</i> e framework de testes.
Voc&ecirc; tamb&eacutem pode adicionar configura&ccedil;&otilde;es customizadas
para o <tt>Merb::BootLoader</tt> nos blocos <tt>before_app_loads</tt> e <tt>after_app_loads</tt> do 
arquivo <tt>init.rb</tt>.
Outro arquivo importante, <tt>dependencies.rb</tt>,
&eacute; onde voc&ecirc; pode definir as depend&ecirc;ncias da sua aplica&ccedil;&atilde;o:
bibliotecas ou gems que a sua aplica&ccedil;&atilde;o necessite.
Qualquer depend&ecirc;ncia listada neste arquivo ser&aacute; carregada
quando sua aplica&ccedil;&atilde;o Merb iniciar.

### environments
Aqui é onde qualquer arquivo de configuração específico dos ambientes está localizado.
Existem alguns arquivos default (em Ruby puro) de configuração; cada um corresponde
a um ambiente do Merb (desenvolvimento, produção, etc.).

## gems
Quando voc&ecirc; estiver pronto para fazer o [deploy][] da sua aplica&ccedil;&atilde;o,
&eacute; recomendado que voc&ecirc; empacote ([bundle][]) todas as suas depend&ecirc;ncias
dentro do diret&oacute;rio da aplica&ccedil;&atilde;o.
O diret&oacute;rio <tt>gems</tt> &eacute; onde estas depend&ecirc;ncias empacotadas ser&atilde;o guardadas.
Quando voc&ecirc; inicia a aplica&ccedil;&atilde;o Merb, ela ir&aacute; 
carregar qualquer gem deste diret&oacute;rio, sobrescrevendo as gems do sistema.

## public
Aqui &eacute; onde voc&ecirc; pode armazenar arquivos que s&atilde;o "est&aacute;ticos",
como por exemplo, os arquivos <tt>favicon.ico</tt> e <tt>robots.txt</tt>.

### images
Qualquer imagem que seu template utilizar deve estar aqui.

### javascripts
No "Merb stack" default, este diret&oacute;rio cont&eacute;m dois arquivos:
<tt>application.js</tt> e <tt>jquery.js</tt>.
O "Merb stack" default vem empacotado com o maravilhoso
<i>framework</i> JavaScript [jQuery][].

Se voc&ecirc; tem pequenos peda&ccedil;os de c&oacute;digo JavaScript, espec&iacute;ficos da sua aplica&ccedil;&atilde;o,
eles devem ficar dentro do arquivo <tt>application.js</tt>.
Se este arquivos se tornar muito "pesado", você pode acrescentar arquivos adicionais sempre que necessário.

### stylesheets
Seguindo a preocupa&ccedil;&atilde;o em manter as coisas separadas,
qualquer estiliza&ccedil;&atilde;o visual deve ser colocada em uma folha de estilos.
Quando voc&ecirc; gera uma aplica&ccedil;&atilde;o Merb, ele cria uma arquivo
de folha de estilos (chamado <tt>master.css</tt>),
que você pode customizar com seu conteúdo preferido.

## spec
Se voc&ecirc; est&aacute; usando [RSpec][] como seu <i>framework</i> de testes([testing][]),
este diret&oacute;rio ir&aacute; conter os testes.
Por default, este diret&oacute;rio cont&eacute;m dois arquivos:
um arquivo vazio <tt>spec.opts</tt>,
que voc&ecirc; pode usar para adicionar argumentos de linha de comando para o rspec
(por exemplo, adicionar um output em cores, etc.) e <tt>spec_helper.rb</tt>,
que &eacute; onde voc&ecirc; pode customizar o inicializador do spec (dentre outras coisas).

## tasks
Este diretório contém tarefas [thor][] do Merb.


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
