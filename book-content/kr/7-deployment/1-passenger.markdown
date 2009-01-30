# Passenger

![Phusion Passenger](/images/phusion_banner.png){: .no-border}

**참조 웹사이트:**
<http://www.modrails.com/documentation/Users%20guide.html>{: .reference}

* This will become a table of contents (this text will be scraped).
{:toc}


[Phusion Passenger][]는 [Rack][]어플리케이션을 배치하기 위한 아파치 모듈입니다.
Merb가 Rack 기반으로 만들어졌기 때문에,  Passenger와 [Ruby Enterprise Edition][] 위에서 어플리케이션을 운영할 수 있습니다.
Ruby Enterprise Edition은 루비의 가비지 콜렉션을 개선하여 메모리를 33% 정도 절약할 수 있는 루비 1.8.6버전입니다.
다음 절차에 따라서 리눅스에 설치할 수 있습니다.

##Ruby Enterprise Edition (REE) 설치하기{: #installing_ruby_enterprise_edition_ree}
Ruby Enterprise Edition은 여러분이 기존에 설치했던 루비와 같이 설치할 수 있습니다. 
/opt 디렉토리에 설치됩니다.

*Note:*
Merb를 인터렉티브하게 운영하시려면 development  ``readline``라이브러리를 설치하셔야 합니다.

### REE 다운로드{: #download_ree}

    $ wget http://rubyforge.org/frs/download.php/41040/ruby-enterprise-1.8.6-20080810.tar.gz

### 설치{: #install}

    $ tar xzvf ruby-enterprise-1.8.6-20080810.tar.gz
    $ cd ruby-enterprise-1.8.6-20080810
    $ ./installer


##Passenger 설치{: #installing_passenger}

    $ gem install passenger
    $ passenger-install-apache2-module

##설정{: #configuration}

###config.ru{: #configru}
여러분의 Merb 어플리케이션 루트 디렉토리에 다음의 파일들이 있어야 합니다:

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

## Capistrano 태스크{: #capistrano_task}


<!-- Links -->
[Phusion Passenger]:          http://www.modrails.com/
[Rack]:                       http://rack.rubyforge.org/
[Ruby Enterprise Edition]:    http://www.rubyenterpriseedition.com/
