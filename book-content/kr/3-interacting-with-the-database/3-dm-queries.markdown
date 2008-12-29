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
### 1개의 데이터 얻기
#### 프라이머리 키에 의한 방법
##### Serial

    ModelName.get(1)
##### String

    ModelName.get("foobar")
 시리얼키들에 대해서는 다른 가능성들이 있습니다. datamapper 사이트가 여러분들을 도와드릴 것입니다.

### 속성(들)에 의한 방법

You have to get the first in the db that follows the criteria if you get only one. (see below for getting several)

    ModelName.first(:attr1 => val1, :attr2 => val2)
Or just one attribute

    ModelName.first(:attr => val)
But you don't just have to make the attribute equal something. 

    ModelName.first(:attr.gt => val)
will find get the first <tt>model_name</tt> such that <tt>model_name.attr > val</tt> is true. 

You can find the full list of conditions here:

[http://datamapper.org/doku.php?id=docs:finders#conditions](http://datamapper.org/doku.php?id=docs:finders#conditions)

### Get Many
Getting many is just the same as getting 1, but you do

    ModelName.all(args)
rather than

    ModelName.first(args)
For example, 

    ModelName.all(price.gt => 5)
will get all ModelNames with prices over 5, just as 

    ModelName.first(price.gt => 5)
will get the first with its price over 5. 

## Update
Use this sequence when altering an existing row in the database. 

2 Choices:
### Change Attributes, Then Update
#### Change Attributes
You make some changes to the instance. 

    model_name.attr = foo
#### Update
Then, you update it in the db.

    model_name.update
This acts just the same as <tt>model_name.save</tt> (see above), saving the changes to the db and returning <tt>true</tt> if valditions succeed, and returning <tt>false</tt> and making the error messages available in an array by

     model_name.errors
### Change Attributes and Update at Once
If you have a hash of attributes, you can change and update all at once by doing

    model_name.update_attributes(hash)
This acts just like <tt>save</tt> and <tt>update</tt> as explained above. 
### Dirtiness
You can check if an object is "dirty", or has had its attributes changed, by calling

    model_name.dirty?
which will return <tt>true</tt> if it has changed and <tt>false</tt> if it hasn't. 

This is especially useful because the method is smart. If the first <tt>ModelName</tt> in the database has <tt>attr1</tt> of 3, then

     foo = ModelName
     foo.attr1 = 3
     puts foo.dirty? #false
## Destroy
This is really easy, and there's basically one choice of how to do it. 

     foo = ModelName.get(42)
     foo.destroy
<tt>destroy</tt> will return <tt>true</tt> if it succeeds in deleting <tt>foo</tt> and <tt>false</tt> if it fails. 
