#Nginx
![Nginx](/images/nginx-header.jpg){: .no-border}

**Reference website:**
<http://wiki.codemongers.com/Main>{: .reference}

* This will become a table of contents (this text will be scraped).
{:toc}

[Nginx][] (uitgesproken als "engine x") is een free, open-source,
high-performance HTTP server en [reverse proxy][],
bovendien een IMAP/POP3 [proxy server][].
Geschreven door [Igor Sysoev](http://sysoev.ru/en/) in 2005,
host Nginx nu tussen de 1% en 4% van alle domeinen wereldwijd
(bronnen: [1](http://googleonlinesecurity.blogspot.com/2007/06/web-server-software-and-malware.html),
[2](http://survey.netcraft.com/Reports/200806/)).
Alhoewel hij nog steeds in beta is, is Nginx gekend voor zijn stabiliteit, rijke feature set,
eenvoudige configuratie, en lage resource consumptie.

Omdat Nginx geen  directe adapter voor Merb vooriet, zal de
de [reverse proxy][] moeten gebruiken in nginx om de requests te proxy-en naar
een (of meerdere) aparte Merb processen. Deze kunnen runnen met om het even welke
Rack-based applicatie server, zoals [Mongrel][], [Thin][],
[Ebb][] of [Glassfish][].

## Installatie

Gebruik de package manager voorzien door je systeem om Nginx te installeren.

### Mac OS X (vereist [MacPorts][])

    $ sudo port install nginx

### Debian / Ubuntu Linux

    $ sudo apt-get install nginx
    
### Gentoo Linux

    $ emerge www-servers/nginx


## Configuratie

De nginx configuratie staat in /etc/nginx/nginx.conf, indien je op Linux werkt,
en /opt/local/etc/nginx/nginx.conf op Mac OS X.

### /etc/nginx/nginx.conf
    
    user <name> <group>;
    worker_processes 4;
    pid /var/run/nginx.pid;
    
    events {
      worker_connections 8192;
      use epoll;
    }
    
    http {

      include /etc/nginx/mime.types;

      default_type application/octet-stream;

      log_format main '$remote_addr - $remote_user [$time_local] '
                      '"$request" $status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

      sendfile on;

      tcp_nopush        on;

      gzip              on;
      gzip_http_version 1.0;
      gzip_comp_level   2;
      gzip_proxied      any;
      gzip_buffers      16 8k;
      gzip_types        text/plain text/html text/css application/x-javascript text/xml application/xml application/xml+rss text/javascript;

      server_names_hash_bucket_size 64;

      upstream merb {
        server 127.0.0.1:4000;
        server 127.0.0.1:4001;
      }
      
      server {
        listen 80;
        
        root /path/to/merb/app/current/public;
        
        access_log /path/to/merb/app/shared/log/access.log main;
        access_log /path/to/merb/app/shared/log/error.log notice;
        
        location / {
          
          proxy_set_header  X-Real-IP       $remote_addr;
          proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header  Host            $http_host;
          
          proxy_redirect false;
          proxy_max_temp_file_size 0;
          
          if (-f $request_filename) {
            break;
          }
          
          if (-f $request_filename.html) {
            rewrite (.*) $1.html break;
          }
          
          if (!-f $request_filename) {
            proxy_pass http://merb;
            break;
          }
          
        } # location
        
      } # server

    } # http


## Capistrano Task

    set :application, "app"
    
    set :scm, :git
    set :repository, "git://github.com/user/repo.git"
    set :deploy_to, "/path/to/merb/app"
    
    set :monit_group, "app"
    set :merb_env, "production"
    
    role :app,  "ip.of.your.server"
    role :web,  "ip.of.your.server"
    role :db,   "ip.of.your.server"
    
    ssh_options[:paranoid] = false
    
    namespace :deploy do
      [:start, :stop, :restart].each do |action|
        task action, :roles => :app do
          sudo "/usr/sbin/monit #{action.to_s} all -g merb_#{monit_group}"
        end
      end
      
      task :migrate, :roles => :db do
        run "cd #{release_path}; rake MERB_ENV=#{merb_env} db:migrate:up"
      end
      
      task :spinner, :roles => :app do
        start
      end
    end

Om je Merb applicatie voor de eerste keer te deployen, moet je het volgende commando runnen

    $ cap deploy:setup

Nadien, kan je deployen met

    $ cap deploy

## Monit

[Monit][] is een tool die kan worden gebruikt voor het starten, stoppen en opvolgen
van arbitraire services. Engine Yard creëerde een wrapper script 
[monit\_merb\_mpc][] genoemd, dat  monit helpt Merb
en zijn master process te behandelen.
In zijn huidige vorm, heeft monit\_merb\_mpc een aantal kleine wijzigingen nodig
om buiten de Engine Yard stack te kunnen draaien.
Een volledige introductie kan gevonden worden op [Ezra's blog][].

Om de Merb master en worker processen op te volgen, moet je volgende configuratie toevoegen aan monit:

    check process merb_app_master
      with pidfile /var/log/engineyard/app/app-production-merb.main.pid
      start program = "/engineyard/bin/monit_merb_mpc app start_master -c2 -n4000" 
      stop program = "/engineyard/bin/monit_merb_mpc app stop_master" 
      #if totalmem is greater than 80.0 MB for 2 cycles then restart       # eating up memory?
      group merb_app
    
    # Worker configuration (one for each worker port required)
    check process merb_app_4000
      with pidfile /var/log/engineyard/app/app-production-merb.4000.pid
      start program = "/engineyard/bin/monit_merb_mpc app register_worker 4000" 
      stop program = "/engineyard/bin/monit_merb_mpc app restart_worker 4000" 
      if totalmem is greater than 80.0 MB for 2 cycles then restart       # eating up memory?
      group merb_app
    
    check process merb_app_4001
      with pidfile /var/log/engineyard/app/app-production-merb.4001.pid
      start program = "/engineyard/bin/monit_merb_mpc app register_worker 4001" 
      stop program = "/engineyard/bin/monit_merb_mpc app restart_worker 4001" 
      if totalmem is greater than 80.0 MB for 2 cycles then restart       # eating up memory?
      group merb_app
      

[Igor Sysoev]:                          http://sysoev.ru/en/
[Nginx]:                                http://wiki.codemongers.com/Main
[proxy server]: http://en.wikipedia.org/wiki/Proxy_server
[reverse proxy]: http://en.wikipedia.org/wiki/Reverse_proxy
[Mongrel]:                              http://mongrel.rubyforge.org/
[Thin]:                                 http://code.macournoyer.com/thin/
[Ebb]:                                  http://ebb.rubyforge.org/
[Glassfish]:                            https://glassfish.dev.java.net/
[MacPorts]:                             http://macports.org/
[Monit]:                                http://mmonit.com/monit/
[monit\_merb\_mpc]:                       http://pastie.org/333352
[Ezra's blog]: http://brainspl.at/articles/2008/12/07/merb-master-worker-monit-control-setup