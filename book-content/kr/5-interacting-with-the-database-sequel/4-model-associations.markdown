#모델 연관(Associations)

Sequel::Model has a very simple set of association methods.
Sequel provides `many_to_one`, `one_to_many` and `many_to_many` to create database associations.


##일대다

    class Post < Sequel::Model
      one_to_many :comments
    end

위의 Post 클래스는 이제 ActiveRecord의 has\_many와 비슷한 연관 메소드를 가지게 되었습니다.

##다대일

    class Post < Sequel::Model
      many_to_one :user
    end

##다대다
    
    class Post < Sequel::Model
      many_to_many :tags
    end


##일대일

    class User < Sequel::Model
      one_to_many :addresses, :one_to_one => true
    end
      
    