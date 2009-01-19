# Nginx

![Nginx](/images/nginx-header.jpg){: .no-border}

**Sitio web de referencia:** [documentación sobre Nginx][]{: .reference}

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

[Nginx][] (se pronuncia "enginx x") es un servidor HTTP y [proxy inverso]
gratuito, de código abierto y de alto rendimiento, 
ademas de ser [servidor proxy] para IMAP y POP3.
Escrito por [Igor Sysoev][] en el año 2005, 
este servidor esta actualmente manejando entre 
el 1% y el 4% de todos los dominios globales.
A pesar de estar ser todavía una versión "beta", 
Nginx es conocido por su estabilidad, su gran conjunto de características, 
una configuración sencilla y por consumir pocos recursos.

Como este servidor no provee actualmente de un adaptador directo para Merb,
usted requerirá utilizar un [proxy reverso][] en Nginx 
con el fin de direccionar peticiones hacia uno o varios procesos Merb distintos.
Esto puede ejecutarse con cualquier servidor de aplicaciones basado en Rack, 
como  [Mongrel][], [Thin][], [Ebb][] o [Glassfish][].

## Instalación 
Usted debe utilizar el manejador de paquetes que su
sistema operativo provee a fin de instalar Nginx.

Dependiendo de su sistemas operativo, 
proceda a ejecutar el siguiente comando.

### Mac OS X (requiere [MacPorts][])
    $ sudo port install nginx
{:lang=shell html_use_syntax=true}

### Debian / Ubuntu Linux
    $ sudo apt-get install nginx
{:lang=shell html_use_syntax=true}
    
### Gentoo Linux
    $ emerge www-servers/nginx
{:lang=shell html_use_syntax=true}

## Configuración
En el caso de utilizar algún sistema operativo Linux, 
usted encontrara el archivo de configuración ``nginx.conf``  
en el directorio ``/etc/nginx/``.
Si usted utiliza Mac OS X, lo encontrara en el directorio ``/opt/local/etc/nginx/``.

### El archivo de configuración ``nginx.conf``
A continuación se le presentara un ejemplo practico 
que muestra como usted debe configurar su servidor [Nginx][].

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

## Tareas para Capistrano
A continuación se le presentara una configuración estándar para [Capistrano][].

    set :application, "app"    
    set :scm, :git
    set :repository, "git://github.com/usuario/repositorio.git"
    set :deploy_to, "/path/to/merb/app"
    set :monit_group, "app"
    set :merb_env, "producción"
    
    role :app, "IP.de.su.servidor"
    role :web, "IP.de.su.servidor"
    role :db, "IP.de.su.servidor"
    
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
{:lang=ruby html_use_syntax=true}

A fin de desplegar su aplicación Merb por primera vez, 
usted debe ejecutar el siguiente comando

    $ cap deploy:setup
{:lang=shell html_use_syntax=true}

Desde de esto, usted va a poder desplegar su aplicación 
con el siguiente comando

    $ cap deploy
{:lang=shell html_use_syntax=true}

## Monit
[Monit][] es una herramienta que usted puede ser usada 
para el comienzo, cierre y monitoreo arbitrario de servicios.
La empresa [Engine Yard][] ha desarrollado un script envolvente llamado [monit\_merb\_mpc][]
que permite que [Monit][] pueda gestionar Merb y si proceso principal.
En la actual encarnación, ``monit\_merb\_mpc``
requiere de modificaciones menores a fin de ejecutar afuera del stack de [Engine Yard][].
Para mas información, referirse al [blog de Ezra][].

A fin de monitorear el proceso principal de Merb 
con sus respectivos procesos trabajadores,
usted deberá agregar la siguiente configuración a [Monit][]:

    check process merb_app_master
      with pidfile /var/log/engineyard/app/app-production-merb.main.pid
      start program = "/engineyard/bin/monit_merb_mpc app start_master -c2 -n4000" 
      stop program = "/engineyard/bin/monit_merb_mpc app stop_master" 
      # Si la memoria total es mayor a 80.0 MB para 2 ciclos entonces deberá reiniciar.
      group merb_app
    
    # Configuración de los procesos trabajadores (uno por cada puerto requerido)
    check process merb_app_4000
      with pidfile /var/log/engineyard/app/app-production-merb.4000.pid
      start program = "/engineyard/bin/monit_merb_mpc app register_worker 4000" 
      stop program = "/engineyard/bin/monit_merb_mpc app restart_worker 4000" 
      # Si la memoria total es mayor a 80.0 MB para 2 ciclos entonces deberá reiniciar.
      group merb_app
    
    check process merb_app_4001
      with pidfile /var/log/engineyard/app/app-production-merb.4001.pid
      start program = "/engineyard/bin/monit_merb_mpc app register_worker 4001" 
      stop program = "/engineyard/bin/monit_merb_mpc app restart_worker 4001" 
      # Si la memoria total es mayor a 80.0 MB para 2 ciclos entonces deberá reiniciar.
      group merb_app

[Ebb]: http://ebb.rubyforge.org/
[blog de Ezra]: http://brainspl.at/articles/2008/12/07/merb-master-worker-monit-control-setup
[Glassfish]: https://glassfish.dev.java.net/
[Igor Sysoev]: http://sysoev.ru/en/
[MacPorts]: http://macports.org/
[Mongrel]: http://mongrel.rubyforge.org/
[Monit]: http://mmonit.com/monit/
[monit\_merb\_mpc]: http://pastie.org/333352
[Nginx]: http://wiki.codemongers.com/Main
[servidor proxy]: http://en.wikipedia.org/wiki/Proxy_server
[proxy reverso]: http://en.wikipedia.org/wiki/Reverse_proxy
[Thin]: http://code.macournoyer.com/thin/
[Engine Yard]: ...
[documentación sobre Nginx]: http://wiki.codemongers.com/Main
