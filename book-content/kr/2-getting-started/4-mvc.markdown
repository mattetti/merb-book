#MVC

* This will become a table of contents (this text will be scraped).
{:toc}

MVC는 Model, View, Controller의 두문자어입니다.
테스트하고 유지하기 쉬운 웹어플리케이션의 구조 형태를 기술하고 있습니다.
왜냐하면 비즈니스 로직과 서버 로직, 컨텐츠 생성을 나눠주기 때문입니다.
이것이 '``merb-gen app``' 명령을 실행시켰을때 생성되는 표준 Merb 어플리케이션 구조입니다.
이 구조는 또한 [Rails][], [CakePHP][], [Django][], 그리고 다른 많은 웹개발 프레임웍에서 사용되고 있습니다.

Merb에서 효과적으로 개발하기 위해서는 MVC 구조가 어떻게 동작되고, 어떻게 하면 가장 효과적인 방법으로 MVC를 이용할 수 있는지 이해하는 것이 중요합니다.
이번 장에서는 프레임웍의 전체에 걸쳐 살펴보도록 하겠습니다.
다음의 각각 3개 챕터에서 자세히 살펴봅시다.

[Models][]은 프레임웍의 핵심입니다.
어플리케이션의 비즈니스 로직에 대한 책임을 맡고 있습니다.
Merb에서는 DataMapper나 Active Record 같은 ORM을 통해서 데이터베이스에 접근하여 연관을 맺게 됩니다.
때로 모델은 데이터베이스 테이블에 대한 래퍼(wrapper) 정도로 ORM에서 사용되기도 합니다.
하지만 일반적으로 'fat'모델을 가지고 있는 것으로 간주됩니다.
모델 클래스들은, 평범하지 않은 데이터 조각들을 회수하거나 조작하기 위한 데이터관계나 메소드들 같은 것을
보관해야 하는 곳이라는 의미입니다.

[Views][]는 어플리케이션의 화려한  바깥 shell이라고 보면 되겠습니다.
Views는 사용자 요청에 의한 실질적인 컨텐츠들(HTML, XML, JSON)을 생성하는 책임을 갖습니다.
가장 일반적으로 [Erb][] (embedded Ruby)나 [Haml][]같은 템플릿 포멧으로 작성됩니다.
현명한 개발자들은 Views안에 최대한 적은 양의 코드를 넣으려고 할 것입니다.

[Controllers][]는 들어오는 요청들과 그에 대한 응답을 처리하는 책임을 갖습니다.
들어오는 요청들을 식별하고, 필요한 모델들의 인스턴스들을 가져오고, 이를 처리하여 View로 정보를 내보내줍니다.

일반적인 Merb 어플리케이션에서는 위에서 언급한 3종류의 코드들이  '``app``' 디렉토리 밑에 같은 이름의 폴더안에 위치하고 있습니다. 다음 장에서는 각각의 파트들을 어떻게 구현하는지에 대해 보도록 하겠습니다.

초보 개발자들은 컨트롤러 레이어에 많은 코드를 넣으려고 할 것입니다만 그것은 코드를 깨지게 쉽게하고, 테스트를 힘들게 만듭니다. 대신 개발자들은 요청/응답 싸이클에 직접적으로 연관되지 않는 코드들을 모델에 넣음으로써, 컨트롤러들이 최대한 "가볍게"하도록 권합니다.


<!-- Links -->
[CakePHP]:              http://www.cakephp.org/
[Controllers]:          /getting-started/controllers
[Django]:               http://www.djangoproject.com/
[Erb]:                  http://en.wikipedia.org/wiki/ERuby
[Haml]:                 http://haml.hamptoncatlin.com/
[Models]:               /getting-started/models
[Rails]:                http://rubyonrails.org
[Views]:                /getting-started/views

