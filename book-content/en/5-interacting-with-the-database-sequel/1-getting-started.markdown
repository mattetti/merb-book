#Getting started

[Sequel][] is a full-fledged, mature ORM database toolkit that has support for object models.
It's supported as a drop-in ORM option with Merb using the merb\_sequel plugin.
Sequel also features an easy-to-use plugin syntax to extend default functionality.
The [Sequel documentation][] is very thorough, and has some good usage examples.

##Generating a project with Sequel

To create a core app with Sequel, merb-gen takes a `--orm` flag.

    $ merb-gen core --orm sequel new_app

This will build the desired application, but falls a little short when it comes to bells and whistles.
    
To achieve results similar to merb-gen app, the merb-sequel-stack gem can be used.

    $ git clone git://github.com/jackdempsey/merb-sequel-stack.git
    $ cd merb-sequel-stack/
    $ rake install
    
merb-gen will now include a sequel-app generator.
This will generate an app that uses Sequel, rspec, and the rest of what can be expected from `merb-gen app`.
    
    $merb-gen sequel-app new_app
    
By default, `merb-gen sequel-app` will generate a database.yml file that uses sqlite3.
For more info, check out the [repository][].

[Sequel]:                 http://sequel.rubyforge.org
[Sequel documentation]:   http://sequel.rubyforge.org/documentation.html
[repository]:             http://github.com/jackdempsey/merb-sequel-stack/tree