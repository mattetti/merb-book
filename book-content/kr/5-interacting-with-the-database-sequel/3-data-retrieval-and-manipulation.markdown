#데이터 검색과 조작

##레코드 찾기

꺾쇠 괄호는 한개의 객체를 리턴할 것입니다.
프라이머리 키는 조건들로 사용되는 패러미터나 해시로 보낼수 있습니다.     
    
    $ merb -i
    >> Post[1]
    => #<Post @values={:published=>false, :body=>"This is a blog post", :id=>1, :title=>"First Post"}>
    
    >> Post[:title => 'First Post']
    => #<Post @values={:published=>false, :body=>"This is a blog post", :id=>1, :title=>"First Post"}>
    
`Post.all`은 모든 Post 객체 세트를 리턴할 것입니다.
Sequel 모델은 Sequel 데이터셋처럼 다뤄집니다.
데이터셋에 사용가능한 모든 선택, 정제관련 메소드들은 Sequel::Model에 적용될 수 있습니다.
다음 예를 간단히 하기 위해 우리가 봤던 Sequel::Model에서 생성된 SQL구문을 보도록 하겠습니다.

    $ merb -i
    >> Post.all
     ~ SELECT * FROM `posts`
     
    >> Post.filter(:published => true).all
     ~ SELECT * FROM `posts` WHERE (`published` = 't')

    >> Post.exclude(:published => true).all
     ~ SELECT * FROM `posts` WHERE (`published` != 't')
     
    >> Post.order(:created_at.desc).paginate(2, 10).all
      ~ SELECT * FROM `posts` ORDER BY `created_at` DESC LIMIT 10 OFFSET 10
      
## CRUD의 나머지 3문자

### 생성

    >> p = Post.create(:title => 'second post', :body => 'another post for something')
    => #<Post @values={:published=>false, :body=>"another post for something", :id=>2, :title=>"second post"}>
    >> p.new?
    => false

### 업데이트

    >> p = Post[2]
    => #<Post @values={:published=>false, :body=>"another post for something", :id=>2, :title=>"second post"}>
    >> p.update(:title => 'replacement title')
    => #<Post @values={:published=>false, :body=>"another post for something", :id=>2, :title=>"replacement title"}>
    
### 삭제

    >> p = Post[2]
    => p.destroy
    >> p.exists?
    => false

대량의 삭제 또한 사용할 수 있습니다.    
    
    # 각 객체에 대해서 디스트럭션 훅(destruction hook)을 실행할 것입니다.
    Post.filter(:user_id => 3).destroy
    
    # 이 방법이 더 빠르지만 훅들(hooks)을 실행하지는 않을 것입니다.
    # 그냥 단순히 한개의 쿼리를 실행할 뿐입니다.
    Post.filter(:user_id => 3).delete

Sequel CRUD가 동작하는 것을 보는 간단한 방법은 merb-gen 명령을 통해 리소스를 생성한 후, 생성된 컨트롤러를 보시면 됩니다.    
