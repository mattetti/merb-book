#Model Associations

`Sequel::Model` has a very simple set of association methods.
Sequel provides `many_to_one`, `one_to_many` and `many_to_many` to create database associations.


##One to Many

    class Post < Sequel::Model
      one_to_many :comments
    end
{:lang=ruby html_use_syntax=true}


    
The Post class above now has a set of association methods similar to ActiveRecord's has\_many.
The method is actually aliased to `has_many`, to maintain some ActiveRecord similarity.  

##Many to One

    class Post < Sequel::Model
      many_to_one :user
    end
{:lang=ruby html_use_syntax=true}

The `many_to_one` association can also be called by `belongs_to`.

##Many to Many
    
    class Post < Sequel::Model
      many_to_many :tags
    end
{:lang=ruby html_use_syntax=true}

The `many_to_many` association can also be called by `has_and_belongs_to_many`.

## One to One

Sequel::Model does not have a separate method to indicate a one\_to\_one relationship.
A :one\_to\_one parameter can be passed to `one_to_many` to create this association.

    class User < Sequel::Model
      one_to_many :addresses, :one_to_one => true
    end
{:lang=ruby html_use_syntax=true}


    