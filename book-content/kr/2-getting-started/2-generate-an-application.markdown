# 어플리케이션 생성하기 
* This will become a table of contents (this text will be scraped).
{:toc}

Merb는  어플리케이션을 생성하기 위한 ``merb-gen``이라는 명령줄 도구(generator)를 가지고 있습니다.  
제너레이터는 다양한 형태의 Merb 어플리케이션을 생성할 수 있습니다. 
모든 가능한 타입들을 보기 위해서는 옵션을 다음과 같이 주고 실행하시면 됩니다.

    $ merb-gen -h


## 타입들{: #types}

Merb는 매우 작고, 빠른, 단일파일의 어플리케이션부터  크고, 복잡한 웹서비스를 하는 어플리케이션까지 사용될 수 있습니다. 
개발자의 요구에 맞춰 다양한 어플리케이션 구조를 생성할 수 있습니다. 
생성할 수 있는 어플리케이션 구조들은 very_flat, flat, core 그리고 app 입니다.

### App{: #app}
완고한 Merb 스택. 풀셋의 설정파일로 응용 프로그램 디렉토리 구조를 생성합니다. 
또한 모든 merb-more와 DataMapper를 포함하는 config/dependencies.rb파일을 더해줍니다.

    $ merb-gen app my-application

이 어플리케이션은 일류 웹어플리케이션을 구축하는데 필요한 모든 것을 갖추고 있습니다.
레일즈의 기본 구조와 매우 유사한 구조를 가지고 있습니다. 
이 책은, 여러분이 대부분 이 어플리케이션 타입을 가지고 있다고 가정하고 진행될 것입니다.

어플리케이션의 루트 디렉토리에서 ``merb`` 명령을 실행시켜 어플리케이션을 구동할 수 있습니다. 
이 명령은 Merb를 시작하고 포트 4000번에 바인딩할 것입니다. 
여러분의 어플리케이션을 보시려면  [http://localhost:4000/](http://localhost:4000/)을 방문해 보십시오.

### Core{: #core}
Core는 풀셋의 설정파일들과 함께 전체 어플리케이션 디렉토리를 생성해줍니다. 
app과는 다르게 어떤 종속적인 것들(dependencies)도 더해지지 않습니다.

    $ merb-gen core my-application

어플리케이션의 루트 디렉토리에서 ``merb`` 명령을 실행시켜 어플리케이션을 구동할 수 있습니다. 
다른 3종류의 어플리케이션 종류와는 다르게 core에 디폴트 컨텐츠가 들어가있지 않습니다. 
[http://localhost:4000/](http://localhost:4000/)를 방문하시더라도 컨텐츠와 라우팅이 더해지지 않았다면 에러를 발생시킬 것입니다.

### Flat{: #flat}
Flat 어플리케이션은 한개의 파일에 모든 로직을 담고있습니다. 
하지만 설정 관련 파일들과 뷰 디렉토리는 별도로 가지고 있습니다.

    $ merb-gen flat my-application

어플리케이션의 루트 디렉토리에서 ``merb`` 명령을 실행시켜 어플리케이션을 구동할 수 있습니다. 
기본적으로 my-application 클래스에 있는 메소드들은  my-application을 컨트롤러로 취급하여 액션으로 다뤄집니다.
 예시: [http://localhost:4000/my-application/foo](http://localhost:4000/my-application/foo)

이것은 MyApplication#foo을 부르고 foo.html.* 템플릿에서 결과를 렌더링하여 보여주게 될 것입니다.

### Very Flat{: #very_flat}
Very Flat 어플리케이션은 전체 어플리케이션이 한개의 파일안에 들어가있는 여타 루비 마이크로 프레임웍과 비슷합니다.

    $ merb-gen very_flat my-applcation

Very Flat 어플리케이션을 구동하기 위해서는 Merb를 다음의 명령과 같이 실행시키기 바랍니다.(루트 디렉토리 안에서)

    $ merb -I my-applcation.rb

이 명령은 Merb를 시작하고 포트 4000번에 바인딩할 것입니다. 여러분의 어플리케이션을 보시려면  [http://localhost:4000/](http://localhost:4000/)을 방문해 보십시오.








