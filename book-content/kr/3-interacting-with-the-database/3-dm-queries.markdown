#데이터베이스 쿼리

* This will become a table of contents (this text will be scraped).
{:toc}

CRUD (Create, Read, Update, Destroy) 액션들에 대해서 각각 살펴보도록 하겠습니다.

## Create

만약 다음에서 설명드리는 내용보다 깊게 알고싶으시면 [datamapper 문서 CRUD부분](http://datamapper.org/doku.php?id=docs:crud)를 참조하시기 바랍니다.

db의 새로운 열을 생성할때 이 시퀀스를 사용합니다.

### New

먼저 ModelName의 인스턴스를 만들어줍니다.

    model_name = ModelName.new
### 속성들 설정

그다음, 해시에 그 속성들을 설정합니다.

    model_name.attributes = {:attr1 => val1, :attr2 => val2}

혹은, (아마 원하시지 않을 테지만) 선호하신다면 하나식 일일이 설정하실 수도 있습니다.

    model_name.attr1 = val1
    model_name.attr2 = val2
### 저장하기
이제 저장하시면 됩니다:

     model_name.save
### 유효성 검증 결과
모든 검증을 통과해서 제대로 저장되었다면, true를 리턴합니다.
하나 이상의 검증을 통과하지 못해서 저장에 실패하면 false를 반환합니다.

#### 에러
실패한다면, 

    model_name.errors
이것이 각각의 실패에 대해 에러메세지 배열을 줄 것입니다.

## 데이터 읽기
만약 다음에서 설명드리는 내용보다 깊게 알고싶으시면 [datamapper 문서 finder 부분](http://datamapper.org/doku.php?id=docs:finders)을 참조하시기 바랍니다.

데이터베이스에서 열(들)을 얻으실때는 다음의 시퀀스를 사용하시면 됩니다.
### 한 개의 데이터 얻기
#### 프라이머리 키에 의한 방법
##### Serial

    ModelName.get(1)
##### String

    ModelName.get("foobar")
 시리얼키들에 대해서는 다른 가능성들이 있습니다. datamapper 사이트가 여러분들을 도와드릴 것입니다.

### 속성(들)에 의한 방법

DB에서 첫번째 것을 얻기위한 기준을 다음과 같이 줘서 얻을 수 있습니다.

    ModelName.first(:attr1 => val1, :attr2 => val2)
혹은 한개의 속성을 가지고도 할 수 있습니다.

    ModelName.first(:attr => val)
그렇다고 속성이 어떤것과 같다고 할 필요는 없습니다.

    ModelName.first(:attr.gt => val)
이것은 model_name.attr > val 이 참인 첫번째 model_name을 찾아 얻어낼 것입니다.

조건들에 대한 전체리스트들은 아래 링크에서 보실 수 있습니다:

[http://datamapper.org/doku.php?id=docs:finders#conditions](http://datamapper.org/doku.php?id=docs:finders#conditions)

### 여러개의 데이터 얻기 
여러개의 데이터를 얻는 것은 한개를 얻는 것과 같습니다. 그러나, 아래와 같이 해주셔야 합니다.

    ModelName.all(args)
아래 처럼 하시면 안됩니다.

    ModelName.first(args)
예를 들면,

    ModelName.all(price.gt => 5)
이렇게 하면 가격이 5보다 큰 모든 ModelNames을 얻게 될 것입니다. 

    ModelName.first(price.gt => 5)
그리고 이 예는 가격이 5보다 큰 첫번째 데이터를 얻게 해줄 것입니다.

## 업데이트
데이터베이스에 들어있는 row를 바꾸실때는 다음 순서를 따르시면 됩니다.

2가지 방법이 있습니다.:
### 먼저 속성들을 변경한 후, 업데이트하는 방법
#### 속성들 변경하기
인스턴스의 속성들을 변경합니다.

    model_name.attr = foo
#### 업데이트하기
그리고 db를 업데이트합니다.

    model_name.update

이것은 model_name.save과 똑같이 행동합니다.(위에서 언급한 부분 참조)
만약 유효성검증이 성공한다면 변경한 내용들을 db에 저장하고 true 값을 반환합니다.
그리고 다음의 명령은 배열에 에러메세지들을 넣어주고 false를 반환합니다.

     model_name.errors
### 속성들 변경과 업데이트를 한번에 하기
만약 속성들이 있는 해시를 가지고 있다면, 다음의 명령을 통해서 변경과 업데이트를 한번에 할 수 있습니다.

    model_name.update_attributes(hash)
이것은 위에서 언급했던 저장과 업데이트를 하는 것과 똑같이 행동합니다.

### Dirtiness
여러분은 다음의 명령을 실행함으로써 객체가 더러워졌는지("dirty"), 또는 객체의 속성들이 변경되었는지 체크할 수 있습니다.

    model_name.dirty?
만약 변경이 되었다면 true, 아니라면 false를 반환합니다.

메소드가 똑똑해서 아주 쓸만한 명령입니다.
만약 데이터베이스의 첫번째 ModelName이 속성 attr1의 값이 3인 상황이라면,

     foo = ModelName
     foo.attr1 = 3
     puts foo.dirty? #false
     
## 삭제하기
삭제는 매우 쉽습니다. 삭제하는 방법은 한개입니다.

     foo = ModelName.get(42)
     foo.destroy
destroy는 삭제가 성공하면 true를, 실패하면 false를 반환합니다. 

