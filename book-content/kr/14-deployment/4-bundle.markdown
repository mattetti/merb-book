# 어플리케이션 번들링

* This will become a table of contents (this text will be scraped).
{:toc}

## 번들링을 하는 이유

여러분의 머신에서 개발을 하는 동안, 어플리케이션은 원활하게 돌아갈 것입니다.
어플리케이션은 로컬 머신에 설치된 다양한 라이브러리와 루비 젬들에 의존하고 있을 것입니다.
현재는 잘 돌아가겠지만 어플리케이션을 배치하려는 서버에는 가용하지 않는 젬이 있을 수 있습니다.
만약 여러분이 다른 개발자들과 일을 하신다면, 그들이 다른 버전을 가지고 있거나 의존하는 패키지 중 없는 것이 있을 수 있을 것입니다.
또한 새 프로젝트를 시작하 예전 어플리케이션과는 충돌을 일으키는 새 버전의 라이브러리를 설치할 필요도 있을 것입니다.

이러한 상황들을 피하기 위해 의존성들을 번들링/얼리기를 권합니다.

## 번들하는 방법

의존성들을 번들하기 위해 2가지가 필요합니다:
To bundle dependencies you need two things:
  * config/dedendencies.rb 파일
  * 최신의 task/merb.thor 테스크

만약 여러분이 오래된 버전의 Merb를 사용하고 계시다면, 현재의 merb.thor파일을 삭제하고 새로운 버전을 재생성 하고 싶으실 것입니다:
    

    $ rm -rf tasks/merb.thor
    $ merb-gen thor
{:lang=shell html_use_syntax=true}

/config 폴더에 dependencies.rb파일이 있는지 확인하시고 없다면 새로 만드시기 바랍니다.

여기에 기본 Merb 스택에서 생성된 dependencies.rb파일 예가 있습니다.

    # dependencies are generated using a strict version, don't forget to edit the dependency versions when upgrading.
    merb_gems_version = "1.0.7.1"
    dm_gems_version   = "0.9.10.1"

    # For more information about each component, please read http://wiki.merbivore.com/faqs/merb_components
    dependency "merb-action-args", merb_gems_version
    dependency "merb-assets", merb_gems_version  
    dependency "merb-cache", merb_gems_version   
    dependency "merb-helpers", merb_gems_version 
    dependency "merb-mailer", merb_gems_version  
    dependency "merb-slices", merb_gems_version  
    dependency "merb-auth-core", merb_gems_version
    dependency "merb-auth-more", merb_gems_version
    dependency "merb-auth-slice-password", merb_gems_version
    dependency "merb-param-protection", merb_gems_version
    dependency "merb-exceptions", merb_gems_version
 
    dependency "dm-core", dm_gems_version         
    dependency "dm-aggregates", dm_gems_version   
    dependency "dm-migrations", dm_gems_version   
    dependency "dm-timestamps", dm_gems_version   
    dependency "dm-types", dm_gems_version        
    dependency "dm-validations", dm_gems_version  

    dependency "merb_datamapper", merb_gems_version
    dependency "do_sqlite3" # If using another database, replace this
{:lang=ruby html_use_syntax=true}

보통 이 파일은 config/init.rb 에서 요구하는 파일입니다.

dependencies에 열거된 모든 의존성들을 번들하시려면 , 다음의 명령을 여러분의 개발머신에서 실행하시기 바랍니다.

    $ thor merb:gem:install
 

로컬 프로젝트 폴더의 루트에 ./gems 디렉토리와 ./gems/cache 디렉토리가 여러분이 사용하시는 SCM(예, git)에 더해졌는지 확인하시기 바랍니다.
또 ./gems/gems 와 ./gems/specifications를 무시하도록 SCM을 설정해주셔야 합니다.

필요한 의존성이 변경될 때마다 항상 잊지말고 위의 사항들을 지켜주시기 바랍니다.

그렇게 하는 이유는, 여러분의 배치 플랫폼 아키텍쳐나 같이 일하는 다른 개발자들의 머신에서 네이티브 젬들이 다시 컴파일될 필요가 있기 때문입니다.

다음번 다른사람이 어플리케이션을 설치하거나 여러분이 deploy 하시면, 다음의 명령을 실행해 주시면 됩니다:

    $ bin/thor merb:gem:redeploy

이 명령이 캐시에 있거나 아직 로컬에 없는 젬들을 설치해줄 것입니다.

만약 Capistrano나 Vlad 같은 배치 솔루션을 사용하고 계신다면, 이 절차들을 SCM이 코드들을 checked out한 바로 다음에 넣을 수 있을 것입니다.



