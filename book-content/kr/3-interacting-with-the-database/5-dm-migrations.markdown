#데이터베이스 마이그레이션

* This will become a table of contents (this text will be scraped).
{:toc}

## DB생성과 셋업
db를 처음 셋업하기 위해서는 다음과 같이 하시면 됩니다.
   
    rake db:create
    rake db:automigrate

## 나중에 변경하게 될 때 
나중에 칼럼들을 추가하거나 칼럼들의 특정 속성들을 변경하는 것은 매우 간단합니다.
모델에 필요한 부분을 변경한 후 다음의 명령을 실행하시면 됩니다.

    rake db:autoupgrade
non-destructive한 업그레이드를 하시려면 위의 명령을, destructive 한 업그레이드는 아래의 명령을 실행하시면 됩니다.
아래의 명령을 실행하시면 데이터베이스에 들어있던 자료들은 없어지게 됩니다.

    rake db:automigrate


### 주의사항
"Non-destructive"는 꼭 나쁜 일이 일어나는 것만을 의미하지는 않습니다.
만약에 여러분이 데이터에 대해 신경을 쓰신다면, 항상 데이터베이스를 어질러 놓기 전에 백업하시는 것이 좋은 정책일 것입니다.

### 기본 값
만약 여러분이 칼럼을 추가하시면 모델에 :default 속성을 설정하실 수 있습니다.
그리고 기존의 각 행에 대한 default 값을 새로운 속성의 값으로 설정할 것입니다.

예를 들어, 여러분이 id 속성을 가진 Person 클래스를 가지고 있고 db에는 2명이 있다고 합시다. 
For example, if you have a Person class with just an id attribute and 2 people in the db, and then you add

    property :name, String, :default => "John Smith"

app/models/person.rb에 있는 모델 파일에 위의 내용을 추가한 후, 다음 명령을 실행합니다.

    rake db:autoupgrade

그리고 콘솔에 들어가서 만들어진 people을 확인해보면 다음의 내용을 보시게 될 것입니다.    

     $ merb -i
     # annoying output you don't care about
     irb(main):001:0> Person.all
     ~ SELECT "id", "name" FROM "people" ORDER BY "id"
     => [#<Person id=1 name="John Smith">, #<Person id=2 name="John Smith">]
     
이름 속성에 "John Smith"를 기본값으로 설정했기 때문에 자동적으로  "John Smith"가 들어가 있는 것을 확인할 수 있습니다.


### DM-Migrations
보다 고급의 일들을 할 수 있도록 도와주는 dm-migrations 플러그인을 사용할 수 있습니다.
[여기](http://datamapper.org/doku.php?id=docs:migrations)에서 보다 자세한 정보들을 볼 수 있습니다.

TODO explain using dm-migrations