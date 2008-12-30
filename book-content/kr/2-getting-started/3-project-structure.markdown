# 프로젝트 구조
* This will become a table of contents (this text will be scraped).
{:toc}


``merb-gen app`` 명령으로 생성된 일반적인 Merb 어플리케이션의 구조는 다음과 같습니다:

    Application directory (Merb.root)
      - app
        - controllers
        - helpers
        - models
        - views
          - exceptions
          - layout
      - autotest
      - config
        - environments
      - doc
      - gems
      - merb
      - public
        - images
        - javascripts
        - stylesheets
      - spec
      - tasks

각 디렉토리를 그 목적과 함께 간단히 살펴보도록 하겠습니다.

## app{: #app}
이 디렉토리는 어플리케이션의 실질내용들을 담고있어, 여러분들은 대부분의 시간을 여기에서 보내게 될 것입니다. 

### controllers{: #controllers}
어플리케이션의 모든 컨트롤러들은 이곳에 위치하게 됩니다. 
컨트롤러들은 일반적으로 복수형입니다.
예를들어, "``Page``" 모델이 있다고 한다면,
컨트롤러 파일은 ``pages.rb``이 될 것입니다.
이것은 그냥 컨벤션입니다. 
그렇지만 여러분은 자유롭게 원하는데로 컨트롤러 이름을 정할 수 있습니다.
더 정보를 원하시면 [controllers][] 색션을 보시기 바랍니다.

### models{: #models}
이 디렉토리에는 모델 클래스들이 들어있습니다.
이 클래스들은 일반적으로 데이터베이스 테이블에 객체지향 접근을 제공하는[ORM][]을 담당하게 됩니다. 
더 정보를 원하시면 [models][]색션을 보시기 바랍니다. 

### views{: #views}
모든 템플릿들이 여기에 저장되어 있습니다.
기본적으로 하위에 ``exceptions``과 ``layout``의 디렉토리들이 있습니다.
``exceptions`` 디렉토리는 HTTP에러와 관련된 템플릿들이 들어있습니다.
예를들어, 새롭게 생성한 Merb 어플리케이션은 
404 HTTP 스테이터스 코드에 상응하는 ``not_found.html.{erb,haml}`` 파일을 담고있습니다.
``layout`` 디렉토리는 액션에 상응하여 렌더링될 템플릿들이 들어 있습니다. 
기본적인 어플리케이션 레이아웃 파일은 ``application.html.{erb,haml}``입니다.
더 정보를 원하시면 [views][] 색션을 보시기 바랍니다. 

## config{: #config}
여러분들이 예상하신대로 Merb 설정파일들은 여기에 위치하고 있습니다.
``router.rb``파일은 어플리케이션 URL의 구조와 순서 그리고 모양새를 정의하는 [routes][]를 담고 있습니다.
다른 중요한 파일로는 ``init.rb``이 있으며, Merb설정의 베이스를 담당합니다.
이 파일에서 ORM, 템플릿 엔진, 그리고 테스팅 프레임웍을 설정합니다.
또한 ``Merb::BootLoader``안의 ``before_app_loads``와 ``after_app_loads`` 
블록에서 커스텀 설정을 더할 수 있습니다.
또 중요한 파일로, 어플리케이션의 의존성(다른 라이브러리나 어플리케이션에서 필요한 gem들)을 
담당하는  ``dependencies.rb``이 있습니다.
이 파일에 적힌 의존성들은 Merb 어플리케이션이 시작될때 로드됩니다.

### environments{: #environments}
특정 환경에 대한 설정파일이 이곳에 위치하게 됩니다.
몇가지 기본적인 설정 파일들이 있습니다(순수 루비파일). 
각 파일들은 특정 Merb 환경에 대응됩니다(development, production, etc.).

## gems{: #gems}
어플리케이션을 배치([deploy][])할 준비가 되었다면, 
어플리케이션의 디렉토리안에 모든 의존성들을 번들링([bundle][])하는 것을 추천합니다.
``gems`` 디렉토리 안에 패키지된 의존성들이 저장되게 됩니다.
Merb 어플리케이션을 실행시켰을 때, 이 디렉토리에서 로드된 gem들은  시스템에 설치된 gem들을 오버라이딩할 것입니다.

## public{: #public}
``favicon.ico``과 ``robots.txt``같은 "정적인" 파일들이 저장되어 있는 곳입니다.

### images{: #images}
템플릿이 사용하는 이미지들은 여기에 있어야 합니다.

### javascripts{: #javascripts}
기본적인 "Merb stack"에서 이 디렉토리는 2개의 파일을 담고 있습니다:
``application.js``와 ``jquery.js``.
기본 Merb스택은 [jQuery][]  자바스크립트 프레임웍이 기본으로 탑재되어 있습니다.

만약 여러분이 상대적으로 작은 양의 어플리케이션에 특정한 자바스크립트 코드를 가지고 있다면, ``application.js``파일안에 포함시키시기 바랍니다.
만약 무거워 다루기 힘들다면 추가로 파일을 추가해도 됩니다.

### stylesheets{: #stylesheets}
어떤 비주얼 스타일이라도 스타일 시트안에 있어야 합니다.
어플리케이션을 생성시키면, 컨텐츠를 커스터마이징할 수 있는 ``master.css`` 스타일시트를 만들어줍니다.

## spec{: #spec}
만약 여러분이 [RSpec][]을 [testing][] 프레임웍으로 사용하신다면, 테스트들이 이 디렉토리에 위치하게 됩니다.
기본적으로 다음의 2개 파일을 담고 있습니다:
rspec에 커맨드라인  아규먼트들(add colorized output, etc.) 을 더할 수 있는 빈 ``spec.opts`` 파일, 
실질적인 spec runner를 커스터마이징할 수 있게 해주는 ``spec_helper.rb``파일.

## tasks{: #tasks}
이 디렉토리에는  Merb의 [thor][] 태스크들이 담겨있습니다.


<!-- Links -->
[bundle]:           /deployment/bundle
[controllers]:      /getting-started/controllers
[deploy]:           /deployment
[jQuery]:           http://jquery.com/
[models]:           /getting-started/models
[ORM]:              http://en.wikipedia.org/wiki/Object-relational_mapping
[routes]:           /getting-started/router
[RSpec]:            http://rspec.info/
[testing]:          /testing-your-application
[thor]:             http://wiki.merbivore.com/faqs/thor
[views]:            /getting-started/views
