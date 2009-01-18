# Database Queries

* This will become a table of contents (this text will be scraped).
{:toc}

We'll go through each of the CRUD (Create, Read, Update, Destroy) actions

## Create

See [http://datamapper.org/doku.php?id=docs:crud](http://datamapper.org/doku.php?id=docs:crud) if you need more info than what follows.

You use this sequence when making a new row in the db. 

### New

First, make an instance of ModelName

    model_name = ModelName.new
{:lang=ruby html_use_syntax=true}    
    
### Set Attributes

Then, set its attributes to a hash

    model_name.attributes = {:attr1 => val1, :attr2 => val2}
{:lang=ruby html_use_syntax=true}

Or, you could set them one at a time if you prefer (but you probably don't):

    model_name.attr1 = val1
    model_name.attr2 = val2
{:lang=ruby html_use_syntax=true}
    
### Save

Now, save it:

     model_name.save
{:lang=ruby html_use_syntax=true}
     
### Validation Outcome

This will return <tt>true</tt> if it saves properly, passing all validations. 
It will return <tt>false</tt> if it fails to save due to failing one or more validations. 

#### Errors

If it does fail, 

    model_name.errors
{:lang=ruby html_use_syntax=true}


will give you an array of the error messages from each failure. 

## Read

See [http://datamapper.org/doku.php?id=docs:finders](http://datamapper.org/doku.php?id=docs:finders) for more info than the following 

Use this sequence when fetching row(s) from the database. 
### Get 1
#### By Primary Key
##### Serial

    ModelName.get(1)
{:lang=ruby html_use_syntax=true}

##### String

    ModelName.get("foobar")
{:lang=ruby html_use_syntax=true}

There are other possibilities for serial keys. That's what the DM site will help you with. 

### By some attribute(s)

You have to get the first in the db that follows the criteria if you get only one. (see below for getting several)

    ModelName.first(:attr1 => val1, :attr2 => val2)
{:lang=ruby html_use_syntax=true}

Or just one attribute

    ModelName.first(:attr => val)
{:lang=ruby html_use_syntax=true}


But you don't just have to make the attribute equal something. 

    ModelName.first(:attr.gt => val)
{:lang=ruby html_use_syntax=true}


will find get the first <tt>model_name</tt> such that <tt>model_name.attr > val</tt> is true. 

You can find the full list of conditions here:

[http://datamapper.org/doku.php?id=docs:finders#conditions](http://datamapper.org/doku.php?id=docs:finders#conditions)

### Get Many

Getting many is just the same as getting 1, but you do

    ModelName.all(args)
{:lang=ruby html_use_syntax=true}

rather than

    ModelName.first(args)
{:lang=ruby html_use_syntax=true}

For example, 

    ModelName.all(price.gt => 5)
{:lang=ruby html_use_syntax=true}

will get all ModelNames with prices over 5, just as 

    ModelName.first(price.gt => 5)
{:lang=ruby html_use_syntax=true}

will get the first with its price over 5. 

## Update

Use this sequence when altering an existing row in the database. 

**2 Choices:**

### Change Attributes, Then Update
#### Change Attributes
You make some changes to the instance. 

    model_name.attr = foo
{:lang=ruby html_use_syntax=true}

#### Update

Then, you update it in the db.

    model_name.update
{:lang=ruby html_use_syntax=true}

This acts just the same as <tt>model_name.save</tt> (see above), 
saving the changes to the db and returning <tt>true</tt> if validations succeed, 
and returning <tt>false</tt> and making the error messages available in an array by

    model_name.errors
{:lang=ruby html_use_syntax=true}

     
### Change Attributes and Update at Once
If you have a hash of attributes, you can change and update all at once by doing

    model_name.update_attributes(hash)
This acts just like <tt>save</tt> and <tt>update</tt> as explained above. 

### Dirtiness

You can check if an object is "dirty", or has had its attributes changed, by calling

    model_name.dirty?
{:lang=ruby html_use_syntax=true}
    
which will return <tt>true</tt> if it has changed and <tt>false</tt> if it hasn't. 

This is especially useful because the method is smart. If the first <tt>ModelName</tt> in the database has <tt>attr1</tt> of 3, then

     foo = ModelName
     foo.attr1 = 3
     puts foo.dirty? #false
{:lang=ruby html_use_syntax=true}

     
## Destroy

This is really easy, and there's basically one choice of how to do it. 

     foo = ModelName.get(42)
     foo.destroy
{:lang=ruby html_use_syntax=true}

`destroy` will return <tt>true</tt> if it succeeds in deleting <tt>foo</tt> and <tt>false</tt> if it fails. 
