#Model Associations

Sequel::Model has a very simple set of association methods.
Sequel provides `many_to_one`, `one_to_many` and `many_to_many` to create database associations.


##One to Many

    class Post < Sequel::Model
      one_to_many :comments
    end
    
The Post class above now has a set of association methods similar to ActiveRecord's has\_many.    

##Many to One

    class Post < Sequel::Model
      many_to_one :user
    end

##Many to Many
    
    class Post < Sequel::Model
      many_to_many :tags
    end


## One to One

    class User < Sequel::Model
      one_to_many :addresses, :one_to_one => true
    end
      
    