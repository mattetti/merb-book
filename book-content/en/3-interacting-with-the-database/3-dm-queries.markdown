#Database Queries

* This will become a table of contents (this text will be scraped).
{:toc}

We'll go through each of the CRUD (Create, Read, Update, Destroy) actions
## Create

See [http://datamapper.org/doku.php?id=docs:crud](http://datamapper.org/doku.php?id=docs:crud) if you need more info than what follows
### New

First, make an instance of ModelName

    model_name = ModelName.new
### Set Attributes

Then, set its attributes to a hash

    model_name.attributes = {:attr1 => val1, :attr2 => val2}

Or, you could set them one at a time if you prefer (but you probably don't):

    model_name.attr1 = val1
    model_name.attr2 = val2
### Save
Now, save it:

     model_name.save
### Validation Outcome
This will return <tt>true</tt> if it saves properly, passing all validations. 
It will return <tt>false</tt> if it fails to save due to failing one or more validiations. 

#### Errors
If it does fail, 

    model_name.errors
will give you an array of the error messages from each failure. 

## Read

See [http://datamapper.org/doku.php?id=docs:finders](http://datamapper.org/doku.php?id=docs:finders) for more info than the following 
### Get 1
#### By Primary Key
##### Serial

    ModelName.get(1)
##### String

    ModelName.get("foobar")
There are other possibilities for serial keys. That's what the DM site will help you with. 

### By some attribute(s)
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