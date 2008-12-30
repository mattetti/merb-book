#Nginx
![Nginx](/images/nginx-header.jpg){: .no-border}

**Reference website:**
<http://wiki.codemongers.com/Main>{: .reference}

* This will become a table of contents (this text will be scraped).
{:toc}

[Nginx][] ("엔진엑스"라고 발음합니다)는 무료이고 오픈소스입니다.
[Nginx][]는 고성능 HTTP서버와 [reverse proxy][],  IMAP/POP3 [proxy server][]를 갖추고 있습니다.
2005년에 [Igor Sysoev][]에 의해 만들어진 Nginx는 세계적으로 1%에서 4%의 시장점유율을 가지고 있습니다(sources: [1](http://googleonlinesecurity.blogspot.com/2007/06/web-server-software-and-malware.html),
[2](http://survey.netcraft.com/Reports/200806/)).

아직 베타버전임에도 불구하고 Nginx는 안정성, 풍부한 기능, 간단한 설정, 그리고 낮은 리소스 소비로 알려져 있습니다.

Nginx는 Merb에 대해서 다이렉트 어답터를 제공하지 않으므로, Nginx의 [reverse proxy][]를 사용해서 한개 이상의 Merb 프로세스에 요청들을 프록시해야 합니다. 이러한 것은 [Mongrel][], [Thin][], [Ebb][] 또는 [Glassfish][] 같은 Rack 기반 어플리케이션 서버에서도 마찬가지입니다.

## 설치{: #installation}

Nginx 설치는 여러분 시스템의 패키지 메니저를 사용하시면 됩니다.

### Mac OS X (requires [MacPorts][]){: #mac_os_x_requires_macports}

    $ sudo port install nginx

### 데비안/ 우분투 리눅스{: #debian__ubuntu_linux}

    $ sudo apt-get install nginx
    
### 젠투 리눅스{: #gentoo_linux}

    $ emerge www-servers/nginx


## 설정{: #configuration}

여러분의 시스템이 리눅스라면 설정파일이 ``/etc/nginx/nginx.conf``에 있으며, Mac OS X라면 ``/opt/local/etc/nginx/nginx.conf``에 있을 것입니다.

### /etc/nginx/nginx.conf{: #etcnginxnginxconf}
    
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


## Capistrano 태스크{: #capistrano_task}

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

여러분의 Merb 어플리케이션을 배치하기 위해 다음의 명령을 실행하시면 됩니다.

    $ cap deploy:setup

그 후에, 다음의 명령을 실행해주시기 바랍니다.

    $ cap deploy

## Monit{: #monit}

[Monit][]은 임의적인 서비스들을 시작하고, 멈추고, 모니터링할 수 있는 툴입니다.
Engine Yard에서는 monit이 Merb와 그 마스터 프로세스를 처리할 수 있도록, [monit\_merb\_mpc][]이라 불리는 렙퍼 스크립트를 만들었습니다.
``monit\_merb\_mpc``를 구현하시려면, Engine Yard스택 밖에서 실행하기 위한 약간의 수정이 필요합니다. 
완전한 소개글은 [Ezra's blog][]를 참조하시기 바랍니다.

Merb마스터 프로세스와 workers를 모니터하기 위해서는 다음의 설정을 monit에 추가해 주셔야 합니다:

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
