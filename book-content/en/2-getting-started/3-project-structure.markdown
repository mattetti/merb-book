# Project structure
The typical structure of a new Merb app (generated with <tt>merb-gen app</tt>)
will look something like this:

    Application directory (Merb.root)
      - app
        - controllers
        - helpers
        - models
        - views
          - exceptions
          - layout
      - autotest
      - config
        - environments
      - doc
      - gems
      - merb
      - public
        - images
        - javascripts
        - stylesheets
      - spec
      - tasks

Here's a brief rundown of each directory and its purpose.

## app
This directory is where you'll spend most of your time,
as it contains the "guts" of your Merb application.

### controllers
All of your application's controllers are stored here (no surprise there).
Controllers are typically named in pluralized form.
For example, if you have a "<tt>Page</tt>" model,
the controller file would most likely be called <tt>pages.rb</tt>.
This is simply a convention, however;
you're free to name your controllers whatever you like.
See the [controllers][] section for more information.

### models
This directory contains your model classes.
These classes typically serve as your [ORM][]s,
which provide object-oriented access to your database tables.
See the [models][] section for more information.

### views
Any templates will be stored here.
By default, this directory contains <tt>exceptions</tt>
and <tt>layout</tt> subdirectories.
The <tt>exceptions</tt> directory stores templates
which are generally related to HTTP errors.
For example, a fresh Merb app
will contain a <tt>not_found.html.{erb,haml}</tt> file,
which corresponds to the 404 HTTP status code.
The <tt>layout</tt> directory contains overall application templates,
into which action templates can be rendered.
The default application layout file
is called <tt>application.html.{erb,haml}</tt>.
See the [views][] section for more information.

## config
Yep, you guessed it.
Merb configuration files are located here.
The <tt>router.rb</tt> file contains your application's URL [routes][],
which define the structure, order, and appearance of your URLs.
Another important file, <tt>init.rb</tt>, handles the base Merb configuration.
This is where you can configure your ORM, template engine,
and testing framework.
You can also add custom configuration to the <tt>Merb::BootLoader</tt>
in its <tt>before_app_loads</tt> and <tt>after_app_loads</tt> blocks.
Another important file, <tt>dependencies.rb</tt>,
is where you can define your application's dependencies:
other libraries or gems that your application requires.
Any dependency listed in that file will be loaded when your Merb app starts.

### environments
Here is where any environment-specific configuration files are located.
There are a few default (pure Ruby) configuration files;
each corresponds to a specific Merb environment
(development, production, etc.).

## gems
When you get ready to [deploy][] your application,
it's recommended that you [bundle][] all of your dependencies
inside the application directory.
The <tt>gems</tt> directory is where these packaged dependencies
will be stored.
When you start the Merb application,
it will load any gems from this directory, overriding the system-wide gems.

## public
Here is where you can store "static" files,
such as the <tt>favicon.ico</tt> and <tt>robots.txt</tt> files.

### images
Any images that your templates might use should go here.

### javascripts
In the default "Merb stack", this directory contains two files:
<tt>application.js</tt> and <tt>jquery.js</tt>.
The default Merb stack comes packaged
with the wonderful [jQuery][] JavaScript framework.

If you have relatively small amounts of application-specific JavaScript code,
it should go inside the <tt>application.js</tt> file.
If this proves unwieldy, however, you can add subsidiary files as needed.

### stylesheets
In keeping with the separation of concerns,
any visual styling should be placed in a stylesheet.
When you generate a Merb app,
it creates a stylesheet file (called <tt>master.css</tt>),
which you can customize to your heart's content.

## spec
If you're using [RSpec][] as your [testing][] framework,
this directory will contain those tests.
By default, this directory contains two files:
an empty <tt>spec.opts</tt> file,
which you can use to add command-line arguments to rspec
(add colorized output, etc.) and <tt>spec_helper.rb</tt>,
which is where you can customize the actual spec runner (among other things).

## tasks
This directory contains Merb's [thor][] tasks.


[bundle]:           /deployment/bundle
[controllers]:      /getting-started/controllers
[deploy]:           /deployment
[jQuery]:           http://jquery.com/
[models]:           /getting-started/models
[ORM]:              http://en.wikipedia.org/wiki/Object-relational_mapping
[routes]:           /getting-started/router
[RSpec]:            http://rspec.info/
[testing]:          /testing-your-application
[thor]:             http://wiki.merbivore.com/faqs/thor
[views]:            /getting-started/views
