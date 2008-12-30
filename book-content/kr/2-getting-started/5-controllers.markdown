# Controllers

* This will become a table of contents (this text will be scraped).
{:toc}

>컨트롤러는 사용자와 시스템 사이의 링크입니다.
>컨트롤러는 입력을 관련 view를 통해 스크린의 적절한 장소에 배치하는 것을 준비하여, 사용자에게 제공합니다. 
>또한 메뉴, 명령들과 데이터를 주는 방법 등을 제시하여 사용자의 출력을 위한 수단을 제공합니다.<!-- break -->  
>컨트롤러는 그런 사용자 산출을 받고, 적합한 메세지로 번역하여 한개 이상의 view에게 메세지를 전달합니다.<!-- break -->  
> - [Trygve Reenskaug][]{: .quote-author}, model-view-controller pattern design[^mvc-essay]의 저자.

{: cite=http://heim.ifi.uio.no/~trygver/1979/mvc-2/1979-12-MVC.pdf .lead-quote}

[MVC][] 패러다임에서 컨트롤러는 뷰와 비즈니스 로직(Model)사이를 연결하는 접착제같은(glue layer) 층을 대표합니다.

구체적으로, 컨트롤러는 엔드유저 액션을 어플리케이션 응답에 매핑시키는 책임을 가지고 있습니다.

기술적으로 말해 Merb에서, 컨트롤러는 ``Merb::Controller``에서 상속받은 클래스입니다.
Merb스택 어플리케이션에서는 ``Application``이라고 불리는 컨트롤러 클래스가 생성됩니다.
생성되는 모든 컨트롤러들은 ``Application``에서 상속을 받습니다. 따라서 ``Application``과 같은 어트리뷰트를 공유합니다.

Merb의 [Router][]은 들어오는 요청의 세부항을 검사하고 ``router.rb``파일에 지정된 규칙과 비교를 합니다.
규칙과 맞는 것이 발견되었다는 가정하에 적절한 컨트롤러와 액션에게 요청을 보냅니다.

이 장에서는 컨트롤러를 어떻게 생성하고 조직하는지에 대해 알아보도록 하겠습니다.
또 어떻게 **액션들**을 작성하는지에 대해서도 보겠습니다. 액션들은 들어오는 요청들을 핸들링하기위해 부르는 컨트롤러의 메소드입니다. 마지막으로 어떻게 컨트롤러의 기능들을 확장하는지도 알아보겠습니다.

## 컨트롤러 생성하기 {: #generating_controllers}

표준 컨트롤러와 [RESTful][] 컨트롤러, 두가지 종류의 컨트롤러를 생성할 수 있습니다.
 
### 표준 컨트롤러{: #a_standard_controller}

    $ merb-gen controller birds
      [ADDED]  app/controllers/birds.rb
      [ADDED]  app/views/birds/index.html.erb
      [ADDED]  spec/requests/birds_spec.rb
      [ADDED]  app/helpers/birds_helper.rb
{:lang=shell html_use_syntax=true}
 
위의 명령어는 몇 개의 파일들을 생성해줍니다. 

``birds.rb`` 컨트롤러 파일은 다른 컨트롤러에서 필요로 하는 메소드와 함께 각 액션에서 필요한 메소드를 가지고 있습니다.
뷰 템플릿 파일인 ``index.html.erb``은 ``erb`` (embedded Ruby) 프로세서를 이용하여 HTML파일을 생성하는데 이용될 수 있습니다.
나머지 파일들(``birds_spec.rb``, ``birds_helper.rb``)은 테스트 상세와 헬퍼 메소드들을 저장하는데 이용됩니다.

생성된 컨트롤러를 가볍게 살펴봅시다:

    class Birds < Application

      def index
        render
      end

    end
{:lang=ruby html_use_syntax=true}

생성기(generator)는 ``Application``에서 상속된 ``Birds``라는 클래스를 새롭게 더했습니다.
새로운 클래스를 보면 ``index``라는 메소드가 있습니다.
컨트롤러의 맥락에서, 이러한 메소드들을 **컨트롤러 액션** 또는 간단하게 **액션**이라고 부릅니다.


``Application`` (``Merb::Controller``의 서브클래스)는 일반적으로 상속하는 클래스입니다. 
그래서 컨트롤러 사이에서 코드를 공유하기에 편리한 장소입니다.<!-- break -->  
(_use with care_)


+-- {: .notes}
만약 컨트롤러를 생성하다가 실수한 것을 알게 되었다면, 
생성 명령에서 ``-d`` 옵션을 추가해서 생성했던 컨트롤러를 삭제할 수 있습니다:

      $ merb-gen controller birds -d
        [DELETED]  app/controllers/birds.rb
        [DELETED]  app/views/birds/index.html.erb
        [DELETED]  spec/requests/birds_spec.rb
        [DELETED]  app/helpers/birds_helper.rb
  {:lang=shell html_use_syntax=true}
=--

### REStful 컨트롤러{: #a_restful_controller}

    $ merb-gen resource_controller cats
      [ADDED]  spec/requests/cats_spec.rb
      [ADDED]  app/controllers/cats.rb
      [ADDED]  app/views/cats/index.html.erb
      [ADDED]  app/views/cats/show.html.erb
      [ADDED]  app/views/cats/edit.html.erb
      [ADDED]  app/views/cats/new.html.erb
      [ADDED]  app/helpers/cats_helper.rb
{:lang=shell html_use_syntax=true}

여러분이 새롭게 생성된 컨트롤러 파일(``app/controllers/cats.rb``)을 열어보시면,
``Cats``라고 새롭게 생성된 클래스가 있는 것을 보시게 될 것입니다.
예상한대로, ``Application``에서 상속한 클래스입니다.
하지만, 이번에는 비어있는 ``index``액션 대신에 우리는 7개의 미리 내용들이 정의되어 있는 액션들을 볼 수 있습니다.

생성된 파일을 보겠습니다:

    class Cats < Application
      # provides :xml, :yaml, :js

      def index
        @cats = Cat.all
        display @cats
      end

      def show(id)
        @cat = Cat.get(id)
        raise NotFound unless @cat
        display @cat
      end

      def new
        only_provides :html
        @cat = Cat.new
        display @cat
      end

      def edit(id)
        only_provides :html
        @cat = Cat.get(id)
        raise NotFound unless @cat
        display @cat
      end

      def create(cat)
        @cat = Cat.new(cat)
        if @cat.save
          redirect resource(@cat), :message => {:notice => "Cat was successfully created"}
        else
          message[:error] = "Cat failed to be created"
          render :new
        end
      end

      def update(id, cat)
        @cat = Cat.get(id)
        raise NotFound unless @cat
        if @cat.update_attributes(cat)
           redirect resource(@cat)
        else
          display @cat, :edit
        end
      end

      def destroy(id)
        @cat = Cat.get(id)
        raise NotFound unless @cat
        if @cat.destroy
          redirect resource(:cats)
        else
          raise InternalServerError
        end
      end

    end # Cats
{:lang=ruby html_use_syntax=true}

휴, 많은 코드들이 있네요. 경험으로 봐서, 이해하지 못하는 코드들은 사용하지 **않는 것**이 좋습니다.
다행히도 위의 코드들은 꽤 이해하기 쉽고 상당히 구체적으로 살펴볼 예정입니다.


그러나 코드들을 뜯어보기 전에 [REST][]에 대해 알아봅시다.

## REST{: #rest}

[REST][]는 [Representational State Transfer][]의 두문자어 입니다.
REST는 [Roy Fielding][]에 의해 2000년에 처음으로 소개되었습니다[^rest\_intro].
REST는 어떻게 [리소스들](http://en.wikipedia.org/wiki/Representational_State_Transfer#REST.27s_central_principle:_resources)이 정의되고 어드레스되는지에 대한 소프트웨어 아키텍쳐 스타일 아웃라이닝입니다.
그러므로 [리소스들](http://en.wikipedia.org/wiki/Representational_State_Transfer#REST.27s_central_principle:_resources)은 REST의 핵심 컴포넌트입니다.

**REST의 맥락에서 리소스는 무언인가?**

리소스란 URI (global identifier)에 의해 참조되는 구체적인 정보 소스입니다.

그것은 특정 주소를 통해 여러분이 액세스할 수 있는 몇 가지 정보입니다.
REST는 HTTP프로토콜을 사용하여 다양한 액터들의 데이터간에 의사소통을 합니다.
리소스는 웹서비스에서 종종 쓰이곤 하는데, 이유는 원리들이 웹리소스에 아주 잘 들어맞기 때문입니다.

**보통 REST 웹리소스를 어떻게 매핑하는가:**

**URI:**      http://site.com/cats 또는 http://site.com/cats/1-felix
(global identifier/address)<!-- break -->  
**포멧:**  MIME 타입이나 확장자(HTML, JSON, XML, YAML, CSV, PDF, ...)<!-- break -->  
**액션:**   리소스 메소들에 HTTP메소드(POST, GET, PUT, and DELETE) 매핑

만약 리소스가 정의되어 있다면, Merb는 컨트롤러와 액션을 선택하기 위해 ``URI``와 HTTP메소드를 이용합니다.

----

**TECHNICAL REVIEW IN PROGRESS, PLEASE DO NOT TRANSLATE**


### 기본 라우팅 스타일{: #the_default_routing_style}

When a new application is generated, the router contains a single default route
which maps URL Paths <!-- is this the right name --> to Controllers like this:

    /:controller/:action/:id(.:format)

This means that a request for ``http://example.com/posts/display/17``
would cause an instance of the ``Posts`` controller to be created.
The method ``display`` would be called on that instance with an ``:id`` of 17.
It might look something like this:

    Posts < Application
      def display
        #Post is a Model class
        @post = Post.get(params[:id])
        display @post
      end
    end.
{:lang=ruby html_use_syntax=true}

In this style, methods are created to handle different actions.
Each Controller has a method for every action that it can respond to.
There are no limits on the number of actions that can be in a controller.
Particularly in small applications where there are only a couple of controllers,
this style allows the developer to easily add a new feature
by simply adding a method to a controller.

###RESTful 스타일{: #the_restful_style}

The REST philosophy is to view every web request
as a request to retrieve (GET),
create (POST), change (PUT), or remove (DELETE) some resource
over which the server is keeping track.
There are a number of benefits to this model.
<!-- we need a chapter on resources -->
Among them are clean URI name spaces,
well organized interaction between Models and Controllers,
and performance.
Generally, it is considered to be good practice
to have one resource controller for each Model.

To route to a resource controller, use this line when setting up routes:

    resources :posts

Resources can also be singleton and/or nested.
Please read the [Router][] chapter for more information.

By default, a resource Controller has seven methods.
The routing for these methods is based on the HTTP method
(GET, POST, PUT, and DELETE), as well as the URL.

####Index{: #index}

routed to by:

    GET /posts
        /posts.index(.:format)

The expectation here is that the user will be presented with a list
of every resource of this type that the server knows about.
In the current example, this might be all of the posts in a blog.

####New{: #new}

routed to by:

    GET /posts/new

This is the first of three User Interface methods that don't map nicely
onto the HTTP verbs.
It is used to show the use of a form to create a new resource.
The form's content will be sent back to the server
and handled by the ``create`` method.
In the example above,
the page might present the use with a form to write a new blog post.

####Create{: #create}

routed to by:

    POST /posts

This method receives data from the client
that is used to construct a new resource.
Generally, the system responds by redirecting the client
to the newly created resource, but this is only a convention.

####Show{: #show}

routed to by:

    GET /posts/:id

This request displays an individual resource identified by ``:id``.
For example, the above might show an single blog posting with all of its
comments.

####Edit{: #edit}

routed to by:

    GET /posts/:id/edit

This is another User Interface method.
It is intended to help a user edit a resource
by displaying a form with that resource's information in it.
In the example above, the user might be presented
with a form to edit an already existing post.
When the form is sent to the server it, it will be handled by the update method.

####Update{: #update}

routed to by:

    PUT /posts/:id

This method is a request to change an already existing resource.
The method needs to update the model and the return a response to the user.
A common convention is to redirect the user to the modified resource.

Of special interest in this function is the use of the HTTP verb "PUT".
Very few clients can use this verb.
To get around this restriction,
any POST with a method field containing "PUT"
is silently converted to a PUT method by Merb
before the request is routed.

####Delete{: #delete}

routed to by:

    GET /posts/:id/delete

This is the last of the User Interface methods.
It is used to remove a resource from the server.
It presents the user with the information they need
to construct a proper destroy request.
It may also be used to confirm a user's desire to remove the resource.
Requests from this page are routed to the ``destroy`` method.

####Destroy{: #destroy}

routed to by:

    DELETE  /posts/:id

This is a request for the server to remove a resource identified by ``:id``.
For example, the user might wish to remove an unwanted blog post.

Like update, this method relies upon an HTTP verb - DELETE -
that is not widely supported.
A POST whose method field contains "DELETE"
is silently converted to a DELETE Request.
This can present issues, as a link tag cannot generate a POST request
without the use of JavaScript.
One way around this is to use the delete page above
with a form or button to confirm the request.
Another way is to use JavaScript to form a proper request.

###메소드들을 추가, 삭제하기{: #adding_and_removing_methods}
Although the methods listed above are standard in Merb,
provisions have been made to add others.
It is best if such actions deal with a single resource
and only perform the four basic operations to it.
Examples of good uses for adding functions might be
having multiple ways to view a resource
or needing more than one form to create or edit a resource.
These methods must be passed as options
to the 'resources' declaration in the router.
(Please see the API documentation)

There are also circumstances where it is not necessary
to use all of these methods.
Perhaps no user is allowed to delete a resource,
or the show page already contains a form to edit the resource.
In these cases,
simply not providing the method will prevent it from being called.

##컨트롤러들과 함께 merb-gen 사용하기{: #using_merbgen_with_controllers}
TODO -- need to mention both normal controllers and resources

##컨트롤러 액션 메소드들{: #controller_action_methods}
이 색션은 컨트롤러 메소드들에서 실제로 어떤일이 일어나는지에 대해 보도록하겠습니다.
컨트롤러 메소드들은 최대한 가벼워야 된다는 것을 잊지말기 바랍니다.

###렌더링하고 디스플레이하기{: #render_and_display}
일반적으로, 컨트롤러 메소드가 마지막으로 하는 것은 응답의 일부로 서 전달된 값을 리턴하는 것입니다.
프레임웍이 항상 뷰를 불러주는 레일즈와 다른 부분입니다. 
Merb에서는 컨트롤러가 스트링을 직접 리턴해도 괜찮습니다.

예를 들어:

    class Hello < Merb::Controller
      def hello_world
        "Hello World!"
      end
    end
{:lang=ruby html_use_syntax=true}

이 코드는 "Hello World!" 문자열을 응답으로서 직접 보냅니다.

일반적으로 우리는 컨트롤러에서 출력 텍스트를 생성하는 것을 원하지 않습니다.
이건 [View][] 레이어가 할 일입니다. 뷰는 ``render``나 ``display`` 메소드를 통해 컨트롤러에서 불려지게 됩니다. 

``render``메소드는 뒤에서 몇가지 일들을 합니다.
사용할 레이아웃을 결정하고 어떤 뷰파일을 렌더할 것인지 선택하며, 렌더링하고, 결과 텍스트를 리턴해줍니다.
``render``는 컨트롤러에서 설정했던 모든 인스턴스 변수들이 뷰와 레이아웃에서 사용가능하도록 해줍니다.


예를 들어:

    class Posts < Application
      def show(id)
        @post = Post.get(id)
        render
      end
    end
{:lang=ruby html_use_syntax=true}

위의 코드는 ``posts.html.erb``레이아웃을 사용하여 ``show.html.erb`` 템플릿을 렌더링할 것입니다.
2개의 파일에서 ``@post`` 변수가 접근가능할 것입니다.
``render``가 메소드의 리턴값으로서 메소드의 마지막에 있는 것을 유의하기 바랍니다.
<!-- can anyone be clearer here? -->

``display``메소드는 ``render``메소드가 하는 모든 것을 합니다만, 좀 더 깊이 들어갑니다.
만약 ``display``가 렌더링할 적합한 템플릿을 찾지 못한다면, 대신 전달된 객체의 포멧에 기반하여 메소드를 부릅니다.
만약 그 메소드가 리턴값이 있다면 그것을 응답으로 전달해줍니다.

예를 들어:

    class Posts < Application
      def show(id)
        @post = Post.get(id)
        display @post
      end
    end
{:lang=ruby html_use_syntax=true}

여기에서 우리는 앞에서와 같이, HTML 요청의 응답으로서 같은 템플릿을 렌더링할 것입니다.
그러나 만약 메소드가 XML포멧을 제공하는 것으로 되어있는데 XML템플릿이 없다면, ``display``메소드는 대신 ``@post.to_xml``을 부르고 결과를 리턴합니다.

2개의 메소드들에는 다른 많은 옵션들이 있습니다.
개발자분들은 해당 API 문서를 참조하여 사용하시기 바랍니다.


###모델과의 상호작용{: #interaction_with_model}
대부분의 액션 메소드들은 한개 이상의 모델들과 상호작용하길 원할 것입니다.
어떻게 상호작용이 될 지는 사용하는 ORM에 의존하게 됩니다.
모델에서 리턴되는 레코드들은 뷰에서 사용되기 위해 '@'로 시작되는 인스턴스 변수에 저장되어야 합니다.

모든 상황을 예상하기 어려운 가운데, 두새개 이상의 모델 메소드를 사용해야 한다면 이것은 모델 레이어에 좀 더 많은 기능을 추가해야 한다는 신호입니다.
만약 같은 모델 클래스가 반복적으로 호출된다면, 그 로그인<!-- (???) -->을 그 클래스의 새로운 메소드로 옮기는 것이 리펙토링하는 좋은 방법일 것입니다.
두새개 이상의 모델클래스가 컨트롤러에서 필요하게 된다면, 컨트롤러를 모델에 좀더 가깝게 매치시키도록 재작업을 하거나 그러한 관계들을 캡슐화하는 프레젠터 모델을 만드시기 바랍니다.

404 페이지들을 사용하는데 있어, Merb는 ORM에 의해 생성된 많은 익셉션들을 다룰 수 있습니다.
그렇지만 모델레이어에서 익셉션들을 처리하고 유저에게 문제점에 대해 좀 더 나은 설명을 제공하는 것은 좋은 연습이 될 것입니다.

###요청에 의한 정보 : ``params``와 ``request``해시{: #information_from_the_request_the_params_and_request_hashes}
컨트롤러는 요청에의해서 생성된 2가지의 해시에 대해 접근할 수 있습니다.

``params``해시는 다음의 것들을 포함하고 있습니다:

* 라우터에 의해 결정된 컨트롤러와 액션
* 클라이언트에 의해 보내진 Post 또는  질의데이터 해시 
  (폼에서 보내진 데이터가 끝나는 곳임)
* ``:id``와 같은 URI파싱으로 부터의 다른 요소들
  (상세한 정보는 [Router][]를 설명하는 장에서 보시기 바랍니다.)

``request``해시는 HTML 요청과 그 환경에 대한 정보들을 담고 있습니다.
보통 Merb는 여기에서 사용하기 쉬운 형태로 정보들을 번역할 것입니다.
하지만 항상 충분하지만은 않을 것입니다.

###클라이언트에 대한 지속적인 정보 : 세션과 쿠키{: #persistant_information_about_the_client_sessions_and_cookies}
HTTP는 상태가 없는 프로토콜 입니다. 
이는 각각의 요청들이 그 자체로서 독자적인 것을 의미합니다. 그리고 호출 사이의 정보를 보관할 방법이 없습니다.
웹개발자에게는 지속적인 상태를 시뮬레이션하는 것이 편리합니다. 
쿠키는 클라이언트를 식별하는데 사용됩니다. 쿠키는 컨트롤러에 있는 쿠키 해시를 통해 사용할 수 있습니다.

하지만 클라이언트를 따라서 지속적인 상태를 주는 것 처럼 만드는 쉽고 보다 유연한 방법이 있습니다.
``session`` 해시는 같은 클라이언트로부터 들어오는 다양한 요청들간에 지속시킵니다.
세션을 유지하는 여러가지 방법들이 있지만, 여기에서 더 설명하지는 않겠습니다. 
하지만 결과는 같습니다.
세션에 저장된 객체는 다음에 유저가 요청을 할 때도 세션에 그대로 저장되어 있습니다.

세션은 사용자의 자격증명을 저장하는데 사용될 수 있습니다.
실제로 Merb-Auth가 인증할 때 쓰는 것이 세션입니다.
세션은 리다이렉팅이 된 후 에러 메세지를 저장할 수 있습니다.
또한 멀티스텝 프로세스에서 완료된 스텝에 대한 정보를 저장할 수 있습니다.


예를 들어:

    class Users < Application
      def login
        if login_was_successful
          # Make sure that when the user reaches the home page,
          # we can remember who they were.
          session[:user] = User.current_user
          redirect url(:home)
        else
          # Provide a message telling the user why they are back
          # at the login screen.
          session[:error_message] = "Could not log you in; please try again."
          redirect url(:login)
        end
      end
    end
{:lang=ruby html_use_syntax=true}

레일즈에서 개발하던 분들은 Merb에 ``flash``해시가 없는 것을 유의하시기 바랍니다.
대신, 페이지들 사이에서 메세지를 직접 보내는 데에 새션을 사용할 수 있습니다.


###리다이렉팅{: #redirecting}

브라우저에 페이지를 뒤로 보내는 것 대신, 서버가 다른 페이지에 대한 정보를 브라우저에게 물어볼 수 있습니다.
Merb에서는 리소스를 POST, PUT,이나 DELETE를 통해 수정함으로써, 요청에 대한 응답으로 종종 이뤄집니다.

이렇게 하기 위해, 서버는 클라이언트에게 보통 body없이, 구체적으로 포멧화된 응답을 보냅니다.
Merb는 이러한 응답을 [redirect][]메소드를 사용하여 만들어줄 것입니다.

예를 들어:

    class Posts < Application
      def update(id)
        post = Post.get(id)
        if post.update_attributes(params[:post])
          redirect resource(post) # Show the client the updated post.
        else
          session[:errors] = post.errors

          # Send the client back to the edit page so they can fix the errors.
          redirect resource(:edit, post)
        end
      end
    end
    #
    # NOTE: 위 예제에 있는 리소스 메소드는 url메소드와 흡사한
    #           URI를 리턴합니다.
{:lang=ruby html_use_syntax=true}

###예외와 상태 코드들{: #exceptions_and_status_codes}

TODO -- How does merb deal with exceptions?

예외를 발생시키는것 외에, Merb는 'status='메소드를 사용하여 상태코드를 직접 세팅할 수 있습니다.

예를 들어:

    class Posts < Application
      def update(id)
        unless params[:post]
          status = 401 # Tell the client we could not understand the request.
          return render("We could not seem to find the content of modified post",
              :layout=>'error')
        end
        post = Post.get(id)
        post.update_attributes(params[:post])
        redirect resource(post) # Show the client the updated post.
      end
    end
{:lang=ruby html_use_syntax=true}

##컨트롤러 확장하기{: #extending_controllers}

이 장에서는 컨트롤러 클래스들과 어플리케이션의 행동을 어떻게 튜닝할 것인지에 살펴보도록 하겠습니다.


###포멧들{: #formats}

TODO - What formats are, How do we determine the format of a
request(.format || accept-format header), using provides, generating different
formats, examples.  Mention the value of RESTful controllers and web services.

###Before and After 필터들{: #before_and_after_filters}

TODO -- about filter, creating filters, order of execution, breaking out of
the filter chain, returning or modifying the response in a filter, examples.

###``Application``의 사용{: #use_of_application}

어플리케이션의 기본 스택과 컨트롤러 생성기에서 생성되는 모든 것은 ``Application``에서 상속받습니다.
``Application``클래스에 메소드를 넣음으로써 개발자들은 어드벤티지를 얻을 수 있습니다.
이렇게 넣은 메소드들은 모든 컨트롤러에서 사용가능합니다.

``Application``클래스는 또한 모든 컨트롤러에서 돌아가는 "before"와 "after"필터를 세팅할 수 있습니다.

``Application``클래스는 ``app/controllers/application.rb``파일에 정의되어 있습니다.


###프라이빗 메소드들{: #private_methods}
가능한한 컨트롤러에서 로직들을 뽑아내 리팩토링하는 것이 좋습니다.
컨트롤러가 복잡한 로직을 담고있다면, 프라이빗 메소드에 위치해야 할 것입니다.
이렇게 함으로써 액션 메소드들은 깔끔해지고 테스트와 디버그하기가 쉬워집니다.
프라이빗으로 이러한 메소드들을 선언하는 것이 매우 중요한데, 이유는 기본적으로 퍼블릭 메소들이 라우터에 의해 호출될 수 있기 때문입니다. 이것은 보안상의 결함을 가져올 수 있습니다.


<!-- Links -->
[MVC]:              /getting-started/mvc
[redirect]: http://merbivore.com/documentation/1.0/doc/rdoc/merb-core-1.0/index.html?a=M000529&name=redirect
[Representational State Transfer]:         http://en.wikipedia.org/wiki/Representational_State_Transfer
[resources]:  http://en.wikipedia.org/wiki/Representational_State_Transfer#REST.27s_central_principle:_resources
[REST]:             http://en.wikipedia.org/wiki/Representational_State_Transfer
[RESTful]:          http://en.wikipedia.org/wiki/Representational_State_Transfer#RESTful_Web_services
[Router]:           /getting-started/router
[Roy Fielding]:     http://en.wikipedia.org/wiki/Roy_Fielding]
[Trygve Reenskaug]: http://en.wikipedia.org/wiki/Trygve_Reenskaug
[View]:             /getting-started/view

<!-- References -->
[^rest\_intro]: Chapter 5 of Fielding’s dissertation is ["Representational State Transfer (REST)"](http://www.ics.uci.edu/~fielding/pubs/dissertation/rest_arch_style.htm)
[^mvc-essay]:   http://heim.ifi.uio.no/~trygver/1979/mvc-2/1979-12-MVC.pdf

<!-- Abbreviations -->
*[HTTP]:    Hypertext Transfer Protocol
*[REST]:    Representational state transfer
