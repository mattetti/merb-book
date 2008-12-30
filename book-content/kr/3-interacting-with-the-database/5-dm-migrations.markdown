#Database Migrations

* This will become a table of contents (this text will be scraped).
{:toc}

## DB Creation and Setup
To first setup the db, do
   
    rake db:create
    rake db:automigrate

## Altering later
Afterwards, you can add columns or change certain attributes of columns simply by making the necessary changes in the model and then running

    rake db:autoupgrade
to do a non-destructive upgrade or 

    rake db:automigrate
to do a destructive upgrade that will clear the database. 

### BEWARE
"Non-destructive" does not necessarily mean that something bad can't happen. It's always good policy to backup the database before messing with it if you care about the data. 

### Default Values
If you are adding a column, you can set the <tt>:default</tt> attribute in the model, an it will set the value of the new attribute to that default value for each existing row. 

For example, if you have a Person class with just an id attribute and 2 people in the db, and then you add

    property :name, String, :default => "John Smith"
to the model file at <tt>app/models/person.rb</tt> and then run

    rake db:autoupgrade
then if you enter the console and inspect the people that had already been created, you will see:

     $ merb -i
     # annoying output you don't care about
     irb(main):001:0> Person.all
     ~ SELECT "id", "name" FROM "people" ORDER BY "id"
     => [#<Person id=1 name="John Smith">, #<Person id=2 name="John Smith">]
The People had their names automatically set to "John Smith" because that was the default value. 

### DM-Migrations
You can use the <tt>dm-migrations</tt> plugin to make migrations to help with more advanced tasks. 

There's some info (just a link as of now) [here](http://datamapper.org/doku.php?id=docs:migrations). 

TODO explain using dm-migrations