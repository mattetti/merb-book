#Nginx
![Nginx](/images/nginx-header.jpg){: .no-border}

**Reference website:**
<http://wiki.codemongers.com/Main>{: .reference}

* This will become a table of contents (this text will be scraped).
{:toc}

[Nginx][] (pronounced "engine x") is a free, open-source,
high-performance HTTP server and [reverse proxy][],
as well as an IMAP/POP3 [proxy server][].
Written by [Igor Sysoev][] in 2005,
Nginx now hosts between 1% and 4% of all domains worldwide
(sources: [1](http://googleonlinesecurity.blogspot.com/2007/06/web-server-software-and-malware.html),
[2](http://survey.netcraft.com/Reports/200806/)).
Although still in beta, Nginx is known for its stability, rich feature set,
simple configuration, and low resource consumption.

Because Nginx doesn't provide a direct adapter for Merb, you will
need to use the [reverse proxy][] in nginx to proxy requests to
one (or many) seperate Merb processes. These can run with any
Rack-based Application Server, like [Mongrel][], [Thin][],
[Ebb][] or [Glassfish][].

## Installation

Use the package manager your system provides to install Nginx.

### Mac OS X (requires [MacPorts][])

    $ sudo port install nginx

### Debian / Ubuntu Linux

    $ sudo apt-get install nginx
    
### Gentoo Linux

    $ emerge www-servers/nginx


## Configuration

The nginx configuration lives in ``/etc/nginx/nginx.conf``, if you're on Linux,
and ``/opt/local/etc/nginx/nginx.conf`` on Mac OS X.

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

To deploy your Merb application for the first time, you need to run

    $ cap deploy:setup

After that, you can deploy with

    $ cap deploy

## Monit

[Monit][] is a tool that can be used for starting, stopping,
and monitoring arbitrary services.
Engine Yard created a wrapper script called [monit\_merb\_mpc][]
that helps monit handle Merb and its master process.
In its current incarnation, ``monit\_merb\_mpc``
needs some minor modifications to run outside of the Engine Yard stack.
A full introduction can be found on [Ezra's blog][].

To monitor the Merb master process and workers,
you need to add this configuration to monit:

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


<!-- Links -->
[Ebb]:                                  http://ebb.rubyforge.org/
[Ezra's blog]: http://brainspl.at/articles/2008/12/07/merb-master-worker-monit-control-setup
[Glassfish]:                            https://glassfish.dev.java.net/
[Igor Sysoev]:                          http://sysoev.ru/en/
[MacPorts]:                             http://macports.org/
[Mongrel]:                              http://mongrel.rubyforge.org/
[Monit]:                                http://mmonit.com/monit/
[monit\_merb\_mpc]:                     http://pastie.org/333352
[Nginx]:                                http://wiki.codemongers.com/Main
[proxy server]: http://en.wikipedia.org/wiki/Proxy_server
[reverse proxy]: http://en.wikipedia.org/wiki/Reverse_proxy
[Thin]:                                 http://code.macournoyer.com/thin/
