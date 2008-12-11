#Models

* This will become a table of contents (this text will be scraped).
{:toc}

Broadly stated, models are the programmatic representation
of the concepts and data that an application uses.
In a blogging application, these would be things
such as postings, comments, and users.
In a store-front application,
they might be products, costumers, shopping carts, sales, etc...
Merb was designed to give developers as much latitude as possible
in describing their models.
Models can be anything a developer can represent with Ruby classes.

Having said this, the vast majority of applications
will use some kind of [ORM][] (Object Relational Mapper)
to persist data between requests.
Most apps will store their data in some form of a database.
The default Merb Stack uses DataMapper to communicate with an SQLite database.
This is an excellent choice for easy development of new projects.

Once in production, however,
it is generally recommended that developers make the switch
to one of the more powerful database engines, such as Postgres or MySQL.
Projects which are coming from the Rails world
may wish to keep their ActiveRecord models; Merb supports this as well.

The rest of this chapter will focus on using DataMapper
to create Model classes.

## Attributes

In a DataMapper model, attributes are defined with the ``property`` method.
This method takes the name of the attribute, a data type, and a hash of
options.  Unlike ActiveRecord, a DataMapper model doesn't require separate
migration files (although migrations are supported).  Here's a fairly standard
DataMapper model:

    class Article
      include DataMapper::Resource
      property :id,           Serial
      property :title,        String
      property :content,      Text
      property :published_at, DateTime
    end
{:lang=ruby html_use_syntax=true}

Take a look at the [properties][] section of the DataMapper site for more details.

## Validations

You can do model validations two different ways. Either you can define them at
the same time as the attribute definition, or use an explicit ``validates_*``
method.  The following two examples are equivalent:

    # Using "auto-validations", defined with the property.
    class Person
      include DataMapper::Resource
      property :id,   Serial
      property :name, String,  :nullable => false
      property :age,  Integer, :length => 1..150
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

For more info, head over to DataMapper's [validations][] page.

## Associations

DataMapper has a very versatile way of defining associations between your models.
All association types are supported, including One-To-Many, Many-To-Many, etc.
Associations are configured using the ``has`` and ``belongs_to`` methods.

Lets say, for example, you're writing a blog application. This application will
have Article and Comment models. Here's how we would setup the association:

    class Article
      include DataMapper::Resource
      # setup properties
      has n, :comments
    end

    class Comment
      include DataMapper::Resource
      # setup properties
      belongs_to :article
    end
{:lang=ruby html_use_syntax=true}

This gives you methods to work with the associations.

    article = Article.first
    article.comments  # Returns all associated comments.
    comment = Comment.first
    comment.article   # Returns the parent Article.
{:lang=ruby html_use_syntax=true}

If you take a look at the Article model, you'll notice the "mythical, magical ``n``".
This method is a shortcut to ``Infinity`` and is used to provide the
"has many" association.

Setting up a "has one" association is as simple as passing the integer ``1``
(one) to the ``has`` method. For example:

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

Similar to the "has many" association, you get some helper methods:

    person = Person.first
    person.coffee_cup  # Returns the person's cup.
    cup = CoffeeCup.first
    cup.person  # Returns the cup's owner.
{:lang=ruby html_use_syntax=true}

For more complicated examples, such as "has many through", refer to DataMapper's
[associations][] page.

## Callbacks

Callbacks allow you to "hook" into various methods, to provide additional
functionality, or (for example) ensure that a property is formatted in a certain
manner. DataMapper supports callbacks using an [aspect-oriented][] approach
and includes (among others) the ``before`` and ``after`` methods.

Let's say you have a Comment model and you wanted to ensure that the
``homepage`` property begins with "http://" without having to require
the person to explicitly provide it. This is one way of achieving that:

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

As you can see, the ``before`` method takes (as symbols) the name of the
method you're "hooking" into and the name of the method which will do the work.
You can also pass a block:

    before :save do
      # ... the monkey dance.
    end
{:lang=ruby html_use_syntax=true}

You can define callbacks for essentially any method, including class methods.
For more details, refer to DataMapper's [hooks][] page.

[ORM]:             http://en.wikipedia.org/wiki/Object-relational_mapping
[properties]:      http://datamapper.org/doku.php?id=docs:properties
[validations]:     http://datamapper.org/doku.php?id=docs:validations
[associations]:    http://datamapper.org/doku.php?id=docs:associations
[aspect-oriented]: http://en.wikipedia.org/wiki/Aspect_oriented
[hooks]:           http://datamapper.org/doku.php?id=docs:hooks
