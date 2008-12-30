#Database Schema

* This will become a table of contents (this text will be scraped).
{:toc}

## Model

### Make the Model
    merb-gen model ModelName

### Open the Model

Open the model file found at <tt>MERB_ROOT/app/models/model_name.rb</tt>. 

### Define the Properties

In DataMapper, you don't need annoying migrations to create the table or add columns. (Though for more advanced tasks, they are available.) 

Default Model (with comments): 
    
    class Person
      include DataMapper::Resource
      
      #You can change this if you want
      property :id, Serial
      
      #more properties here
      # in format: 
      #property :name, Type, :option => value, :option2 => value2
      ... 
      
    end

### Types you can have:
As stolen from [http://datamapper.org](http://datamapper.org/):

* * * * *

DM-Core supports the following 'primitive' data-types.

<ul>
<li class="level1"><div class="li"> TrueClass, Boolean</div>
</li>
<li class="level1"><div class="li"> String</div>
</li>
<li class="level1"><div class="li"> Text</div>

</li>
<li class="level1"><div class="li"> Float</div>
</li>
<li class="level1"><div class="li"> Fixnum, Integer</div>
</li>
<li class="level1"><div class="li"> BigDecimal,</div>
</li>
<li class="level1"><div class="li"> DateTime, Date, Time</div>
</li>

<li class="level1"><div class="li"> Object, (marshalled)</div>
</li>
<li class="level1"><div class="li"> Discriminator (all you need for Single Table Inheritance, actually)</div>
</li>
</ul>


If you include DM-Types, the following data-types are supported:

<ul>
<li class="level1"><div class="li"> Csv</div>

</li>
<li class="level1"><div class="li"> Enum</div>
</li>
<li class="level1"><div class="li"> EpochTime</div>
</li>
<li class="level1"><div class="li"> FilePath</div>
</li>
<li class="level1"><div class="li"> Flag</div>
</li>

<li class="level1"><div class="li"> IPAddress</div>
</li>
<li class="level1"><div class="li"> <acronym title="Uniform Resource Identifier">URI</acronym></div>
</li>
<li class="level1"><div class="li"> Yaml</div>
</li>
<li class="level1"><div class="li"> Json</div>
</li>
<li class="level1"><div class="li"> BCryptHash</div>

</li>
<li class="level1"><div class="li"> Regex</div>
</li>
</ul>

Find out more about these types <a href="http://datamapper.org/doku.php?id=dm-more:dm-types" class="wikilink1" title="dm-more:dm-types">here</a>

* * * * *

More specifics on properties are found here:
[http://datamapper.org/doku.php?id=docs:properties](http://datamapper.org/doku.php?id=docs:properties)

### Migrate

Obviously, you must finish defining the properties first. 
The short story is that you run

    rake db:create
and then

    rake db:automigrate
And you should have the db all happy. 
For more info on migrations, see the [migrations page](/interacting-with-the-database/dm-migrations)