#Sequel 플러그인

Sequel::Model은 ORM의 최소기능들을 모아놓은 것같이 보일 것입니다.
하지만 기능들을 확장하는 것이 매우 쉽습니다.
Sequel 플러그인들 모델에 유용한 기능을 더해주는 젬들로 패키징된 라이브러리들입니다.
모델에서 `is :pluginname`을 선언해주면 해당 플러그인을 사용할 수 있습니다.
Sequel 플러그인들을 사용하는 것은 아주 손쉽고 작성하기도 간편합니다.


##유용한 플러그인들

###sequel\_timestamped

이름에서 보듯, sequel\_timestamped는 모델에 표준 타임스탬프 칼럼을 업데이트 해줄 것입니다.

    class Note < Sequel::Model
      is :timestamped
    end

만약 모델이 `created_at`과 `updated_at` 타임스탬프 칼럼을 가지고 있다면, 업데이트 될 것입니다.

[sequel\_timestamped source][]에서 얻으실 수 있습니다.

###sequel\_notnaughty

sequel\_notnaughty 플러그인은 표준 Sequel::Model 검증을 대체하여 엄격한 검증을 해줍니다.
Not-naughty는 쉽고 확장가능한 검증 프레임웍을 제공하는 젬입니다.
    
    class User < Sequel::Model
      is :notnaughty
      
      #now use the not-naughty syntax for validation
      validates do
        presence_of :login
        length_of :login, :minimum => 5
      end
    end

[sequel\_notnaughty source][], [not-naughty source][]에서 얻으실 수 있습니다.


###sequel\_polymorphic

Sequel\_polymorphic은 다형적 관계를 설정하는 어려운 일들을 대신 해줍니다.
이 플러그인은 이러한 상황들의 Sequel의 연관을 다루는 기능을 더해줍니다.

    class Note < Sequel::Model
      is :polymorphic
      one_to_many :assets, :as => :attachable
    end

    class Asset < Sequel::Model
      is :polymorphic
      many_to_one :attachable, :polymorphic => true
    end

이 예는 Note와 그 Asset 간에 투명한 다형적 관계를 생성해줍니다.

[sequel\_polymorphic source][]에서 얻으실 수 있습니다.

###sequel\_taggable

Sequel taggable은 Jack Dempsey이 Merb에 관련한 일을 하다가 개발한 또다른 플러그인입니다.
이것은 모델에 간단한 태깅 메소드를 더해줍니다.
현재 Tag 테이블을 생성하는 테스크를 갖추고 있지는 않습니다만, 플러그인의 소스에 마이그레이션이 포함되어 있습니다.

    class Article < Sequel::Model
      is :taggable
    end
    
    a = Article.create(:title => "My first article")
    t = Tag.create(:name => "a tag")
    a.add_tag(t)

Sequel\_taggable은 sequel\_polymophic플러그인에 의존합니다.
[sequel\_taggable source][]에서 얻으실 수 있습니다.

[sequel_timestamped source]:    http://github.com/bricooke/sequel_timestamped/tree/master

[sequel_notnaughty source]:     http://github.com/boof/sequel_notnaughty/tree/master

[not-naughty source]:           http://github.com/boof/not-naughty/tree/master

[sequel_polymorphic source]:    http://github.com/jackdempsey/sequel_polymorphic/tree/master

[sequel_taggable source]: http://github.com/jackdempsey/sequel_taggable/tree/master