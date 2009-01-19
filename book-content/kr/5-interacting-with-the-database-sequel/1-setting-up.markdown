#설치와 설정

##Sequel을 사용하는 프로젝트 생성하기

Sequel을 사용하는 코어 프로젝트 생성하시려면, merb-gen에 `--orm` 플래그를 주면 됩니다.

    $ merb-gen core --orm sequel new_app

이 명령이 원하는 어플리케이션을 생성해줄 테지만 부가적인 기능 측면에서는 조금 부족합니다.
merb-gen 명령을 통한 어플리케이션과 비슷한 결과를 얻기 위해서 merb-sequel-stack 젬을 사용할 수 있습니다.

    $ git clone git://github.com/jackdempsey/merb-sequel-stack.git
    $ cd merb-sequel-stack/
    $ rake install
    
merb-gen은 이제 sequel-app 생성기를 포함하게 될 것입니다.
Sequel, rspec, 그리고 나머지 `merb-gen app` 명령을 통해 생성되는 것들을 더해 줄 것입니다.
    
    $merb-gen sequel-app new_app

`merb-gen sequel-app` 명령은 기본으로 sqlite3를 사용하는 database.yml 파일을 생성할 것입니다.  
더 자세한 정보는 [저장소][]를 확인하시기 바랍니다.


[저장소]:       http://github.com/jackdempsey/merb-sequel-stack/tree