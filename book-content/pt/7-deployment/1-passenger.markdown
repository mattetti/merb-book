#Passenger

![Phusion Passenger](/images/phusion_banner.png){: .no-border}

**website de referência:** [http://www.modrails.com/documentation/Users%20guide.html](http://www.modrails.com/documentation/Users%20guide.html){: .reference}


[Phusion Passenger](http://www.modrails.com/) é um módulo Apache para realizar deploy de aplicações [Rack](http://rack.rubyforge.org/). Como o Merb é construído no topo do Rack, você pode facilmente rodá-lo no Passenger e com o Ruby Enterprise Edition [Ruby Enterprise Edition](http://www.rubyenterpriseedition.com/). Ruby Enterprise Edition é uma versão de Ruby 1.8.6 com melhorias no Garbage Collector, que pode tipicamente reduzir em 33% o quanto uma aplicação utiliza de memória. As seguintes instruções são para linux.

##Instalando Ruby Enterprise Edition (REE)
Ruby Enterprise Edition pode ser instalado juntamente com a versão do Ruby que você já tem instalada, pois será instalado no diretório <tt>/opt</tt>.

*Nota:* Você precisará as bibliotecas de desenvolvimento do readline instaladas se desejares rodar o Merb interativamente.
### Baixando o REE

    $ wget http://rubyforge.org/frs/download.php/41040/ruby-enterprise-1.8.6-20080810.tar.gz

### Instalando o REE

    $ tar xzvf ruby-enterprise-1.8.6-20080810.tar.gz
    $ cd ruby-enterprise-1.8.6-20080810
    $ ./installer


##Instalando o Passenger

    $ gem install passenger
    $ passenger-install-apache2-module

##Configuração

###config.ru
O seguinte arquivo precisa ser colocado na raiz de suas aplicações Merb.

    # config.ru
    require 'rubygems'

    # Descomente se seu aplicativo usa gems embutidas
    # gems_dir = File.expand_path(File.join(File.dirname(__FILE__), 'gems'))
    # Gem.clear_paths
    # $BUNDLE = true
    # Gem.path.unshift(gems_dir)

    require 'merb-core'

    Merb::Config.setup(:merb_root   => File.expand_path(File.dirname(__FILE__)),
                       :environment => ENV['RACK_ENV'])
    Merb.environment = "production" #Merb::Config[:environment]
    Merb.root = Merb::Config[:merb_root]
    Merb::BootLoader.run

    # Descomente se seu aplicativo está sob uma suburi.
    # if prefix = ::Merb::Config[:path_prefix]
    #   use Merb::Rack::PathPrefix, prefix
    # end

    run Merb::Rack::Application.new

## Tarefa Capistrano
