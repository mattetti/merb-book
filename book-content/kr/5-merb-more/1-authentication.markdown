# 인증

* This will become a table of contents (this text will be scraped).
{:toc}
> 유저가 주장한 아이디가 실제로 맞는지 검증하는 것이 인증시스템의 책임입니다.
> 믿을만한 호스트, 패스워드 인증, (‘OpenID’와 같은) 믿을 수 있는 네트웍 등을 통한 인증시스템 방안들이 있습니다.
> 확인이되면 인증시스템의 책임은 끝나게 됩니다.
> [Adam French][]{: .quote-author}
{: cite=http://adam.speaksoutofturn.com/post/57615195/entication-vs-orization .lead-quote}

## Merb-auth gems{: #merbauth_gems}

[merb-auth][]는 메타젬입니다. 메타젬이란 아무 코드도 없는 루비젬을 일컫습니다.
메타젬의 단 한가지 목적은 의존성들을 선언하고 설치가 쉽도록 도와주는 것입니다.

Merb 1.0.x버전에서 merb-auth는 3개의 젬을 사용합니다:

* [merb-auth-core][]
* [merb-auth-more][]
* [merb-auth-slice-password][]

### merb-auth-core{: #merbauthcore}

[merb-auth-core][]는 유저모델로 무엇을 써야하는지나 어떻게 인증을 해야하는지에 대해서는 지시하려 하지 않습니다.
대신, 인증에 통과하는 객체를 확인하고 세션에 인증된 객체의 키를 저장하는 로직에 초점을 맞추고 있습니다.

이것은 사실, MerbAuth의 가이드 원리입니다. 세션은 컨트롤러 헬퍼의 도움으로  인증을 위한 장소로 사용됩니다.

여러분은 컨트롤러 액션, 라우트 혹은 라우트 그룹을 보호하기 위해 선택할 수 있습니다. 
이것이 사람들이 말하는 인증된 세션이라고 부르는 이유입니다.

MerbAuth는 올바른HTTP 상태코드를 리턴해주는 Merb의 예외처리 핸들링 기능을 이용합니다.

로그인에 실패하거나 컨트롤러 코드의 어떤 지점에서 로그인을 강제하면 (옵션 메세지와 함께) "인증되지 않았다"는 예외를 발생시킵니다.
그리고 유저에게는 로그인 페이지가 띄워질 것입니다. 
사실, 로그인 페이지는 ``Extensions#unauthenticated``를 위한 뷰 템플릿입니다.

객체가 false로 평가되지 않고 세션의 안밖에서 직렬화될 수 있다면, MerbAuth를 유저객체로써 함께 사용하는 것이 가능합니다. 

마지막으로, "chained strategies" 능력으로부터 merb-auth는 큰 힘을 발휘합니다.
여러분이 원하는 만큼 스트래티지를 추가할 수 있습니다.
작동(로그인)이 되거나 모든 것이 해당되지 않을때(실패)까지 하나씩 시도될 것입니다. 

인증전략은 요청을 인증하는 방법입니다.
전략의 예는 다음과 같습니다:

* Salted user (user login with a password using a "salted" encryption)
* OpenID
* API key/token
* Basic HTTP Authentication


### merb-auth-more{: #merbauthmore}

[merb-auth-more][]는 merb-auth-core에 추가적인 기능을 더합니다.
이 젬은 일반적인 전략들과  "User"객체 "mixins"을 제공합니다.

전략들:

* login or email password form (aka password\_form)
* basic HTTP authentication (aka basic\_auth)
* OpenID

믹스인:

* ActiveRecord salted user
* DataMapper salted user
* relaxdb salted user
* sequel salted user

salted user 믹스인은 기본적인 salted SHA1 패스워드 인증을 제공합니다.
기본 패스워드 전략과 함께 사용하기 위해 ``User.authenticate 메소드``를 구현해주어야만 합니다.

### merb-auth-slice-password{: #merbauthslicepassword}

[merb-auth-slice-password][]는 매우 심플한  Merb슬라이스 입니다.
기본 로그인, 로그아웃, 폼기반 패스워드 로그인, 기본 인증을 제공해줍니다.

기본적으로 ``password\_form``과 ``basic\_auth`` 전략을 로드할 것입니다.

"인증된 Hello World" 예제에서 설명했듯이, 뷰와 전략은 커스터마이징할 수 있습니다.


## Merb스택에서의 인증{: #authentication_in_merb_stack}

기본 Merb 스택[^merb-stack-app] 어플리케이션을 생성하면, merb-auth는 일반적인 사용을 위한 세팅이 이미 되어 있습니다.

만약 사용하기 원하지 않는다면, 간ㄷ나헤게 ``config/dependencies.rb``파일안의 ``merb-auth``의존성 부분을 코멘트 처리하시면 됩니다.


## 인증된 Hello World{: #authenticated_hello_world}


### 어플리케이션 생성하기{: #generate_an_application}

첫번째 단계는 Merb 스택을 이용하여 여러분의 어플리케이션을 생성하는 것입니다.

    $ merb-gen app hello_world
    $ cd hello_world
{:lang=shell html_use_syntax=true}

이것은 미리 설정된 인증과 함께 어플리케이션 스텁을 생성해줄 것입니다.
기본 요소들은:

    app/models/user.rb

    merb/merb-auth/setup.rb
    merb/merb-auth/strategies.rb
{:lang=ruby html_use_syntax=true}

기본적으로, 패스워드와 로그인을 이용하여 사용자인증을 관리합니다. 
물론, 우리는 먼저 데이터베이스를 세팅하고 사용자를 더해주어야 겠지요.


    $ rake db:automigrate
    $ merb -i
    >> u = User.new(:login => "login_name")
    >> u.password = u.password_confirmation = "sekrit"
    >> u.save
{:lang=ruby html_use_syntax=true}


### 보호하기 위한 무언가를 생성하기{: #generate_something_to_protect}

이제 우리는 어플리케이션도 가지고 있고 사용자도 있으므로 무언가를 보호할 필요가 있습니다. 

    $ merb-gen controller hello_world
{:lang=ruby html_use_syntax=true}

컨트롤러에 뭔가 넣어보겠습니다.

    class HelloWorld < Application
      def index
        "Hello World"
      end
    end
{:lang=ruby html_use_syntax=true}

merb를 실행시켜보고 <http://localhost:4000/hello_world>를 보시면, "Hello World"결과를 보실 수 있을 것입니다.

### 라우트 보호하기{: #protect_the_route}

그것은 아직 보호되어 있지 않습니다. 이제 해보도록 하겠습니다.
우리는 컨트롤러 액션이나  ``config/router.rb``파일에서 라우트를 이용하여 보호할 수 있습니다.
라우터를 기반한 방법을 보도록 하겠습니다.

``config/router.rb``을 열어보시기 바랍니다:

    Merb::Router.prepare do
      authenticate do
        match("/hello_world").to(:controller => "hello_world")
      end
    end
{:lang=ruby html_use_syntax=true}

이렇게 하면 유저가 로그인을 하게 할 것입니다. 
This is discovered in the router and when it fails, it stops in the router. (???)
<http://localhost:4000/hello_world>에 가보시면 액세스하기 위해 로그인을 해야하는 것을 볼 수 있을 것입니다.
로그아웃은 <http://localhost:4000/logout>에 가면 됩니다.

### 컨트롤러 보호하기{: #protect_the_controller}

이제 위의 코드를 제거하고 컨트롤러 레벨에서 보호해보도록 하겠습니다.
이것은 리소스들에 대한 제어를 보다 좋게할 것입니다. 예를 들어,


    Merb::Router.prepare do
      match("/hello_world").to(:controller => "hello_world")
    end
{:lang=ruby html_use_syntax=true}

컨트롤러안에 해당 코드를 넣도록 하겠습니다.

    class HelloWorld < Application

      before :ensure_authenticated

      def index
        "Hello World"
      end

    end
{:lang=ruby html_use_syntax=true}

컨트롤러 안에서 현재 로그인된 유저에 대한 접근을 얻기위해서는 다음과 같이 합니다:

    session.user
{:lang=ruby html_use_syntax=true}

아주 기본적인 Hello World인증에 대해 살펴봤습니다.


### 기본 뷰 덮어쓰기{: #overwrite_the_default_views}

만약 여러분이 좀 더 많은 커스터마이징을 원하시면 다음 명령을 실행해보시기 바랍니다:

    rake slices:merb-auth-slice-password:freeze:views
{:lang=ruby html_use_syntax=true}

위 명령은 슬라이스의 뷰를 카피하여 여러분 어플리케이션의 ``슬라이스`` 디렉토리로 카피합니다.
Then you need to move/copy them to your ``app/views`` directory
and edit the copied views. (???)


[^merb-stack-app]: merb-gen app hello\_world

## 인증된 요청 테스트 해보기{: #testing_an_authenticated_request}

요청이 인증되는지를 테스트해보기 위해 여러분은 먼저 로그인을 할 필요가 있습니다.
요청 spec을 돌리는 중에, 로그인하기 쉬운 방법은 헬퍼를 사용하는 것입니다.

여기에 `spec/spec\_helper.rb``파일에 더해진 2개의 헬퍼 예제가 있습니다.

    Merb::Test.add_helpers do

      def create_default_user
        unless User.first(:login => "krusty")
          User.create( :login => "krusty",
                       :password => "klown",
                       :password_confirmation => "klown") or raise "can't create user"
        end
      end

      def login
        create_default_user
        request("/login", {
          :method => "PUT",
          :params => {
            :login => "krusty",
            :password => "klown"
          }
        })
      end

    end
{:lang=ruby html_use_syntax=true}

첫번째 헬퍼는 만약 기존에 유저가 존재하지 않을 경우, 기본 유저를 생성합니다.
두번째 헬퍼는 기본유저의 어트리뷰트들을 이용하여 로그인 요청을 보냅니다.
로그인 액션이 PUT을 사용한 것을 유의해서 보시기 바랍니다.

이제 2개의 헬퍼를 더했으니, 이제 조금만 수정하면 되겠습니다.

    before(:each) do
      login
      @response = request(resource(:articles))
    end
{:lang=ruby html_use_syntax=true}

위의 예에서, articles의 URI로 보내진 요청은 인증이 될 것입니다.

<!-- Links -->
[Adam French]:      http://adam.speaksoutofturn.com
[merb-auth]:        http://github.com/wycats/merb/tree/master/merb-auth
[merb-auth-core]:   http://github.com/wycats/merb/tree/master/merb-auth/merb-auth-core
[merb-auth-more]:   http://github.com/wycats/merb/tree/master/merb-auth/merb-auth-more
[merb-auth-slice-password]: http://github.com/wycats/merb/tree/master/merb-auth/merb-auth-slice-password

*[API]: Application Programming Interface
