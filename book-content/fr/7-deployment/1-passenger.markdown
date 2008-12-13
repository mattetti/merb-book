#Passenger

![Phusion Passenger Banner][]{: .no-border}

**Site source:** [Phusion Passenger User Guide][]{: .reference}

* This will become a table of contents (this text will be scraped).
{:toc}

[Phusion Passenger][] est une module Apache pour déployer
des applications [Rack][]. Comme Merb est construit sur Rack,
vous pouvez facilement l'exécuter sur Passenger et [Ruby Enterprise Edition][].
Ruby Enterprise Edition est une version de Ruby 1.8.6 avec des améliorations
au niveaux du ramasse-miette Ruby, qui généralement réduire la taille mémoire
des application de 33%.
Les instructions suivantes sont pour Linux.

##Installer Ruby Enterprise Edition (REE)
Ruby Enterprise Edition sera installé dans le dossier <tt>/opt</tt>.
Cela vous permet de garder de côté la version de Ruby que vous avez
 déjà sur votre système

*Note:* Vous aurez besoin d'installer les librairies de développement
readline si vous voulez exécuter Merb intéractivement.

### Télécharger REE

    $ wget http://rubyforge.org/frs/download.php/41040/ruby-enterprise-1.8.6-20080810.tar.gz

### Installer

    $ tar xzvf ruby-enterprise-1.8.6-20080810.tar.gz
    $ cd ruby-enterprise-1.8.6-20080810
    $ ./insaller


##Installer Passenger

    $ gem install passenger
    $ passenger-install-apache2-module

##Configuration

###config.ru
Le fichier suivant doit se trouver dans la racine de votre application Merb:

    # config.ru
    require 'rubygems'

    # Enlever les commentaires si votre application inclus des gems
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

    # Enlever les commentaire si votre application utilise un préfixe
    # if prefix = ::Merb::Config[:path_prefix]
    #   use Merb::Rack::PathPrefix, prefix
    # end

    run Merb::Rack::Application.new


## Capistrano Task

[Phusion Passenger]:               http://www.modrails.com/
[Phusion Passenger Banner]:        /images/phusion_banner.png
[Phusion Passenger User Guide]:    http://www.modrails.com/documentation/Users%20guide.html
[Rack]:                            http://rack.rubyforge.org/
[Ruby Enterprise Edition]:         http://www.rubyenterpriseedition.com/