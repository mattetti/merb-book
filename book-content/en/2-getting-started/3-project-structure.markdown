# Project structure
The typical structure of a new Merb app (generated with <tt>merb-gen app</tt>) will look something like this:

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

Here's a brief rundown of each 'important' directory's purpose.

## app
This directory is where you'll spend most of your time, as it contains the 'guts' of your Merb application.

### controllers
All of your application's controllers are stored here (no surprise there).  Controllers are typically named in pluralized form.  For example, if you have a '<tt>Page</tt>' model, the controller file would most likely be called <tt>pages.rb</tt>.  This is simply a convention, however, and you're free to name your controllers whatever you like.

### models
This directory contains your model classes.  These classes typically serve as your [ORM](http://en.wikipedia.org/wiki/Object-relational_mapping), which are front-ends to your database tables.

### views
Any templates will be stored here.  By default, this directory contains <tt>exceptions</tt> and <tt>layout</tt> subdirectories.  The <tt>exceptions</tt> directory stores templates which are generally related to HTTP errors.  For example, a fresh Merb app will contain a <tt>not_found.html.{erb,haml}</tt>, which corresponds to the 404 HTTP status code.  The <tt>layout</tt> directory contains the over-all application template, from which all other templates will be included into.  By default, the application layout file is called <tt>application.html.{erb,haml}</tt>.

## config
Yep, you guessed it.  Merb configuration files are located here.  The <tt>router.rb</tt> file contains your applications URL [routes](/getting-started/router), which define the structure, order, and appearance of your URLs.  Another important file is <tt>init.rb</tt>.  This file handles the base Merb configuration.  This is where you can configure your ORM, template engine, and testing framework.  You can also add custom configuration to the <tt>Merb::BootLoader</tt> in it's <tt>before_app_loads</tt> and <tt>after_app_loads</tt> blocks.  Another important file is <tt>dependencies.rb</tt>.  Here is where you can define your application's dependencies; other libraries or gems that your application requires.  Any dependency listed in that file will be loaded when your Merb app starts.

## public
Here is where you can store 'static' files, such as the favicon.ico and robots.txt files.

### images
Any images that your templates might use should go here.

### javascripts
In the default 'Merb stack', this directory contains two files: <tt>application.js</tt> and <tt>jquery.js</tt>.  The default Merb stack comes packaged with the wonderful [jQuery](http://jquery.com/) Javascript framework.  You should put all of your application specific Javascript code inside the <tt>application.js</tt> file.

### stylesheets
Keeping with the separation of concerns, any visual styling should be placed in a stylesheet.  When you generate a Merb app, it creates a stylesheet file (called <tt>master.css</tt>).

## spec
If you're using [rspec](http://rspec.info/) as your [testing](/testing-your-application) framework, this directory will contain those tests.  By default, this directory contains two files: an empty <tt>spec.opts</tt> file, which you can use to add command-line arguments to rspec (add colorized output, etc.) and <tt>spec_helper.rb</tt>, which is where you can customize the actual spec runner (among other things).

## tasks
This directory contains Merb's [thor](http://wiki.merbivore.com/faqs/thor) tasks.