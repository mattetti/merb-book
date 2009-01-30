#모델

* This will become a table of contents (this text will be scraped).
{:toc}

폭넓게 정해진 의미에서의 모델은 어플리케이션이 사용하는 컨셉이나 데이터의 프로그래밍적인 표현입니다.
블로깅 어플리케이션에서는 포스팅, 코멘트, 그리고 유저와 같은 것들이 될 것입니다.
상점 어플리케이션의 경우에는 상품, 고객, 쇼핑카트, 판매와 같은 것들입니다.
Merb에서는, 개발자들이 모델을 기술할 수 있는 범위를 가능한한 넓게 설계하였습니다.
모델은 개발자가 루비클래스로 묘사할 수 있는 어떤 것도 될 수 있습니다.

엄청나게 많은 수의 어플리케이션들이 요청간의 데이터를 유지하기 위해서  [ORM][] (Object Relational Mapper)을 사용하고 있습니다.
대부분의 어플리케이션은 데이터베이스에 데이터를 저장할 것입니다.
기본적으로 Merb스택은 [SQLite][] 데이터베이스와 의사소통하기 위해서 [DataMapper][]를 사용하고 있습니다.
이것은 새로운 프로젝트의 쉬운 개발을 위해서 최상의 선택일 것입니다.

그러나 프로덕션 모드에서는  [PostgreSQL][]나 [MySQL][]과 같은 강력한 데이터베이스 엔진을 선택하기를 추천합니다.
루비온레일즈에서 온 프로젝트들은 [ActiveRecord][] 모델을 그대로 사용하길 원할 것입니다. 
Merb는 [ActiveRecord][]도 지원합니다.

이 장의 나머지 부분에서는 DataMapper를 이용하여 모델 클래스를 생성하는 것에 살펴보도록 하겠습니다.

## 어트리뷰트{: #attributes}

DataMapper 모델에서는 어트리뷰트들은 ``property``메소드와 함께 정의됩니다.
이 메소드는 어트리뷰트의 이름, 데이터타입, 그리고 해시옵션을 받습니다.
ActiveRecord와는 다르게, DataMapper 모델은 (마이그레이션은 지원합니다만) 별도의 마이그레이션 파일을 필요로하지 않습니다.
여기 아주 전형적인 DataMapper 모델을 보겠습니다:

    class Article
      include DataMapper::Resource
      property :id,           Serial
      property :title,        String
      property :content,      Text
      property :published_at, DateTime
    end
{:lang=ruby html_use_syntax=true}

보다 상세한 설명을 원하시면 DataMapper 사이트의 [properties][] 색션을 참조하시기 바랍니다.

## 검증{: #validations}
모델 유효성 검증을 2가지의 방법을 통해 할 수 있습니다.
어트리뷰트 정의를 하는 동시에 검증을 정의하거나 명시적으로 ``validates_*``메소드를 사용해서 검증할 수 있습니다.
다음의 두 예제에는 같은 것입니다:

    # Using "auto-validations", defined with the property.
    class Person
      include DataMapper::Resource
      property :id,   Serial
      property :name, String,  :nullable => false
      property :age,  Integer, :length   => 1..150
    end

    # Using the "validates_*" methods.
    class Person
      include DataMapper::Resource
      property :id,   Serial
      property :name, String
      property :age,  Integer

      validates_present :name
      validates_length  :age, :within => 1..150
    end
{:lang=ruby html_use_syntax=true}

더 많은 정보는 DataMapper의 [validations][] 페이지를 보시기 바랍니다.

## 관계(Associations){: #associations}

DataMapper는 매우 다재다능한 모델간 관계 정의방법을 가지고 있습니다.
일대다, 다대다 등을 포함한  모든 관계 타입들이 지원됩니다.
관계(Associations)는 ``has``와``belongs_to`` 메소드를 사용하여 설정됩니다.

여러분이 블로그 어플리케이션을 작성하고 있다고 가정해 보겠습니다.
이 어플리케이션은 Article과 Comment 모델을 가지고 있을 것입니다.
여기에 관계설정을 어떻게 하는지에 대한 예가 있습니다:

    class Article
      include DataMapper::Resource
      # Set up properties.
      has n, :comments
    end

    class Comment
      include DataMapper::Resource
      # Set up properties.
      belongs_to :article
    end
{:lang=ruby html_use_syntax=true}

이것은 관계를 나타내는 메소드들을 보여줍니다.

    article = Article.first
    article.comments  # Returns all associated comments.
    comment = Comment.first
    comment.article   # Returns the parent Article.
{:lang=ruby html_use_syntax=true}

Article 모델을 보시면, "마법같은 ``n``" 부분을 유의해서 보시게 될 것입니다.
이 메소드는 ``무한``에 대한 쇼트컷이고 "has many" 관계를 제공하기 위해 사용됩니다.

"has one"관계를 설정하는 것은 숫자 ``1``을 ``has``메소드에게 주는 것으로 간단하게 끝납니다.

예를 들어:

    class Person
      include DataMapper::Resource
      # setup properties
      has 1, :coffee_cup
    end

    class CoffeeCup
      include DataMapper::Resource
      # setup properties
      belongs_to :person
    end
{:lang=ruby html_use_syntax=true}

레일즈의 ``has many`` 관계에서와 같이 이러한 관계들은 헬퍼 메소드들을 제공합니다.

    person = Person.first
    person.coffee_cup  # Returns the person's cup.
    cup = CoffeeCup.first
    cup.person  # Returns the cup's owner.
{:lang=ruby html_use_syntax=true}

``has many through``와 같이 보다 복잡한 예들은 DataMapper의 [associations][] 페이지를 참조하기 바랍니다.

## 콜백{: #callbacks}

콜백은 다양한 메소드들을 "잡아챌(hook)" 수 있게 해줍니다. 콜백은 추가적인 기능을 제공하기 위해서, 또는 속성이 특정한 수법으로 포멧되도록 하기위해서 사용합니다.
DataMapper는 [aspect-oriented][] 접근법이나 다른 메소드들 사이에 ``before``나 ``after``메소드를 사용해서 콜백을 지원합니다.

여러분이 Comment 모델을 가지고 있다고 생각해봅시다.
여러분은 유저들이 일부러 요청하지 않아도 ``homepage``속성이 "http://"로 시작되도록 하고 싶습니다.
다음의 예제가 그것을 이루는 방법 중 하나입니다.

    class Comment
      include DataMapper::Resource
      property :homepage, String

      before :save, :sanitize_homepage

      private

      def sanitize_homepage
        # If the homepage already begins with "http://", just return.
        return if homepage =~ /^http[s]?:\/\/\w/
        self.homepage = 'http://' + homepage
      end
    end
{:lang=ruby html_use_syntax=true}

보시다시피, ``before``메소드가 여러분이 "잡아채는(hooking)" 메소드의 이름을 (심볼로) 받습니다. 
그리고 해당 이름의 메소드가 일을 해낼 것입니다.
여러분은 또한 블록을 보낼 수도 있습니다:

    before :save do
      # ... the monkey dance.
    end
{:lang=ruby html_use_syntax=true}

여러분은 본질적으로, 클래스 메소드를 포함한 어떤 메소드라도 콜백을 정의할 수 있습니다.
더 자세한 정보는 DataMapper의 [hooks][] 페이지를 보시기 바랍니다.


<!-- Links -->
[ActiveRecord]:    http://en.wikipedia.org/wiki/ActiveRecord_%28Rails%29
[aspect-oriented]: http://en.wikipedia.org/wiki/Aspect_oriented
[associations]:    http://datamapper.org/doku.php?id=docs:associations
[DataMapper]:      http://datamapper.org/doku.php
[hooks]:           http://datamapper.org/doku.php?id=docs:hooks
[MySQL]:           http://en.wikipedia.org/wiki/MySQL
[ORM]:             http://en.wikipedia.org/wiki/Object-relational_mapping
[PostgreSQL]:      http://en.wikipedia.org/wiki/PostgreSQL
[properties]:      http://datamapper.org/doku.php?id=docs:properties
[SQLite]:          http://www.sqlite.org/
[validations]:     http://datamapper.org/doku.php?id=docs:validations
