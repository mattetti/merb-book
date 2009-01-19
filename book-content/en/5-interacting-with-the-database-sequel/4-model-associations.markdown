#Model Associations

`Sequel::Model` has a very simple set of association methods.
Sequel provides `many_to_one`, `one_to_many` and `many_to_many` to create database associations.


##One to Many

    class Post < Sequel::Model
      one_to_many :comments
    end
{:lang=ruby html_use_syntax=true}


    
The Post class above now has a set of association methods similar to ActiveRecord's has\_many.    

##Many to One

    class Post < Sequel::Model
      many_to_one :user
    end
{:lang=ruby html_use_syntax=true}

##Many to Many
    
    class Post < Sequel::Model
      many_to_many :tags
    end
{:lang=ruby html_use_syntax=true}

## One to One

    class User < Sequel::Model
      one_to_many :addresses, :one_to_one => true
    end
{:lang=ruby html_use_syntax=true}


    