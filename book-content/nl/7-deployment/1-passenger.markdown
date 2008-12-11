#Passenger

![Phusion Passenger](/images/phusion_banner.png){: .no-border}

**Referentie website:**
[http://www.modrails.com/documentation/Users%20guide.html][]{: .reference}

[Phusion Passenger][] is een Apache module om [Rack][] applicaties te deployen.
Omdat Merb is gebouwd is op Rack,
kan je Merb makkelijk op Passenger draaien en op [Ruby Enterprise Edition][].
Ruby Enterprise Edition is een versie van Ruby 1.8.6
met verbeteringen aan Ruby's garbage collection,
deze kan de memory footprint typisch met 33% reduceren.
De volgende instructies zijn voor Linux.

##Installeren van Ruby Enterprise Edition (REE)
Ruby Enterprise Edition kan worden geinstalleerd naast een reeds geinstalleerde versie van Ruby,
aangzien het wordt geinstalleerd in de <tt>/opt</tt> directory.

*Nota:*
Je moet de development <tt>readline</tt> libraries geinstalleerd hebben
die je Merb interactief wenst te runnen.

### Download REE

    $ wget http://rubyforge.org/frs/download.php/41040/ruby-enterprise-1.8.6-20080810.tar.gz

### Installatie

    $ tar xzvf ruby-enterprise-1.8.6-20080810.tar.gz
    $ cd ruby-enterprise-1.8.6-20080810
    $ ./installer


##Installatie Passenger

    $ gem install passenger
    $ passenger-install-apache2-module

##Configuratie

###config.ru
Volgend bestand moet in je Merb applicatie's root directory worden geplaatst:

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

## Capistrano Task


[http://www.modrails.com/documentation/Users%20guide.html]:  http://www.modrails.com/documentation/Users%20guide.html
[Phusion Passenger]:          http://www.modrails.com/
[Rack]:                       http://rack.rubyforge.org/
[Ruby Enterprise Edition]:    http://www.rubyenterpriseedition.com/

