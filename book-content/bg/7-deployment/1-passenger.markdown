#Passenger

![Phusion Passenger](/images/phusion_banner.png){: .no-border}

**Сайт за повече информация:**
[http://www.modrails.com/documentation/Users%20guide.html][]{: .reference}

[Phusion Passenger][] е Apache модул за обслужването на [Rack][] апликации.
Тъй като Merb е изграден върху Rack,
можете лесно да го стартирате чрез Passenger и [Ruby Enterprise Edition][].
Ruby Enterprise Edition е версия на Ruby 1.8.6
която има реализирана оптимизация на garbage collection,
 водеща до намаляване на използваната оперативна памет до 33%.
Следните инструкции са за инсталация на Linux.

##Инсталация на Ruby Enterprise Edition (REE)
Ruby Enterprise Edition може да бъде инсталирана в <tt>/opt</tt> директорията, отделно от стандартната версия на Ruby.

*Бележка:*
Трябва да разполагате с development <tt>readline</tt> бибилиотеките ако иската да стартирате интерактивно Merb

### Изтегляне на REE

    $ wget http://rubyforge.org/frs/download.php/41040/ruby-enterprise-1.8.6-20080810.tar.gz

### Инсталация

    $ tar xzvf ruby-enterprise-1.8.6-20080810.tar.gz
    $ cd ruby-enterprise-1.8.6-20080810
    $ ./installer


##Инсталация на Passenger

    $ gem install passenger
    $ passenger-install-apache2-module

##Конфигурация

###config.ru
Следния файл трябва да бъде разположен във вашата основна директория на Merb:

    # config.ru
    require 'rubygems'

    # Uncomment if your app uses bundled gems.
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

    # Uncomment if your app is mounted at a suburi.
    # if prefix = ::Merb::Config[:path_prefix]
    #   use Merb::Rack::PathPrefix, prefix
    # end

    run Merb::Rack::Application.new

## Capistrano задача


[http://www.modrails.com/documentation/Users%20guide.html]:  http://www.modrails.com/documentation/Users%20guide.html
[Phusion Passenger]:          http://www.modrails.com/
[Rack]:                       http://rack.rubyforge.org/
[Ruby Enterprise Edition]:    http://www.rubyenterpriseedition.com/

