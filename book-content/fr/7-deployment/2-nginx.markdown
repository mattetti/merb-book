#Nginx
![Nginx Banner][]{: .no-border}

**Site source:** [Nginx Wiki][]{: .reference}

* This will become a table of contents (this text will be scraped).
{:toc}

[Nginx][] (prononcé "engine x") est un serveur HTTP gratuit,
open-source, haute-performance, utilisable comme un [reverse proxy][],
et aussi comme un [serveur proxy][] IMAP/POP3.
Ecrit par [Igor Sysoev][] en 2005, Nginx héberge maintenant entre
1% et 4% de tous les domaines dans le monde (sources: [Google Online Security Blog][],
[Netcraft Survey 06/2008][]).
Bien que toujours en version beta, Nginx est populaire grâce à
sa stabilité, sa riche gamme de fonctionnalités, sa configuration simple,
et au peu de ressources qu'il consomme.

Comme Nginx ne fournit pas un adaptateur direct pour Merb,
vous devrez utiliser le [reverse proxy][] dans Nginx pour passer les
requêtes vers un (ou plusieurs) processus Merb séparé.
Ces processus peuvent s'exécuter avec n'importe quel serveur
applicatf basé sur Rack, comme [Mongrel][], [Thin][],
[Ebb][] ou [Glassfish][].

## Installation

Utilisez le gestionnaire de paquets que votre système fournit pour installer Nginx.

### Mac OS X (nécessite [MacPorts][])

    $ sudo port install nginx

### Debian / Ubuntu Linux

    $ sudo apt-get install nginx
    
### Gentoo Linux

    $ emerge www-servers/nginx


## Configuration

La configuration Nginx se situe dans '``/etc/nginx/nginx.conf``' sir vous êtes sur Linux,
et dans '``/opt/local/etc/nginx/nginx.conf``' sur Mac OS X.

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


## Tâche Capistrano

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

Pour déployer votre application Merb la première fois, vous devez lancer:

    $ cap deploy:setup
{:lang=shell html_use_syntax=true}

Après ça, voous pouvez faire le déploiement avec:

    $ cap deploy
{:lang=shell html_use_syntax=true}

## Monit

[Monit][] est un outil qui peut être utilisé pour démarrer, arrêter et surveiller
certains services. Engine Yard a créé un script appelé [monit\_merb\_mpc][],
qui aide ``monit`` à gérer Merb et son processus maître.
Dans sa version actuelle, ``monit\_merb\_mpc`` nécessite quelques modifications mineures
pour s'exécuter en dehors de l'environnement d'Engine Yard.
Une introduction complète peut se trouver sur [le blog d'Ezra][].

Pour surveiller le processus maître de Merb et ses sous-processus,
vous devez ajouter ce code à votre configuration ``monit``:

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
      

[Ebb]:                            http://ebb.rubyforge.org/
[Glassfish]:                      https://glassfish.dev.java.net/
[Google Online Security Blog]:    http://googleonlinesecurity.blogspot.com/2007/06/web-server-software-and-malware.html
[Igor Sysoev]:                    http://sysoev.ru/en/
[le blog d'Ezra]:                 http://brainspl.at/articles/2008/12/07/merb-master-worker-monit-control-setup
[MacPorts]:                       http://macports.org/
[Nginx Banner]:                   /images/nginx-header.jpg
[Nginx Wiki]:                     http://wiki.codemongers.com/Main
[Mongrel]:                        http://mongrel.rubyforge.org/
[Monit]:                          http://mmonit.com/monit/
[monit\_merb\_mpc]:               http://pastie.org/333352
[Netcraft Survey 06/2008]:        http://survey.netcraft.com/Reports/200806/
[Nginx]:                          http://wiki.codemongers.com/Main
[reverse proxy]:                  http://fr.wikipedia.org/wiki/Reverse_proxy
[serveur proxy]:                  http://fr.wikipedia.org/wiki/Serveur_proxy
[Thin]:                           http://code.macournoyer.com/thin/