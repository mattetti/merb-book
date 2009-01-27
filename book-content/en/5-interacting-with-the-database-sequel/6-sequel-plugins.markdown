#Sequel Plugins

Sequel::Model may seem like the minimal set of functionality for an ORM, but it is easy to extend its capabilities.
Sequel Plugins are libraries packaged as gems which can add useful functionality to your models.
Plugins are named like `sequel_pluginname`.
They're used in models by declaring `is :pluginname`.
Plugins for Sequel are painless to use, and are easy to write.
These are just a few examples.
Jeremy Evans maintains a more [complete list of plugins][].


##Useful Plugins

###sequel\_timestamped

As the name would indicate, sequel\_timestamped will update standard timestamp columns in your model.

    class Note < Sequel::Model
      is :timestamped
    end
{:lang=ruby html_use_syntax=true}

If the model has `created_at` and `updated_at` timestamp columns, they will be updated as expected.

Here's the [sequel\_timestamped source][].

###sequel\_notnaughty

The sequel\_notnaughty plugin replaces standard Sequel::Model validation with not-naughty validation.
Not-naughty is a gem that provides an easily extensible validation framework.
    
    class User < Sequel::Model
      is :notnaughty
      
      #now use the not-naughty syntax for validation
      validates do
        presence_of :login
        length_of :login, :minimum => 5
      end
    end
{:lang=ruby html_use_syntax=true}

Here's the [sequel\_notnaughty source][], and the [not-naughty source][].


###sequel\_polymorphic

Sequel\_polymorphic takes the hard work of setting up polymorphic relationships out of your hands.
The plugin adds functionality to Sequel's associations to handle these situations.

    class Note < Sequel::Model
      is :polymorphic
      one_to_many :assets, :as => :attachable
    end

    class Asset < Sequel::Model
      is :polymorphic
      many_to_one :attachable, :polymorphic => true
    end
{:lang=ruby html_use_syntax=true}

This will create a transparent polymorphic relationship between the Note and its Assets.

Here's the [sequel\_polymorphic source][].

###sequel\_taggable

Sequel taggable is another plugin developed by Jack Dempsey while working with Merb.
It just adds simple tagging methods to a model.
As of right now, there are no tasks with the plugin to generate a Tag table.
There is, however, a migration included in the plugin source.

    class Article < Sequel::Model
      is :taggable
    end
    
    a = Article.create(:title => "My first article")
    t = Tag.create(:name => "a tag")
    a.add_tag(t)

Sequel\_taggable depends on the sequel\_polymophic plugin.
Here's the [sequel\_taggable source][].

[complete list of plugins]:   http://sequel.rubyforge.org/plugins.html

[sequel_timestamped source]:    http://github.com/bricooke/sequel_timestamped/tree/master

[sequel_notnaughty source]:     http://github.com/boof/sequel_notnaughty/tree/master

[not-naughty source]:           http://github.com/boof/not-naughty/tree/master

[sequel_polymorphic source]:    http://github.com/jackdempsey/sequel_polymorphic/tree/master

[sequel_taggable source]: http://github.com/jackdempsey/sequel_taggable/tree/master
