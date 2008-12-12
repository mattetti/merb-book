# Generate an application

* This will become a table of contents (this text will be scraped).
{:toc}

Merb comes with a generator (``merb-gen``)
in order to create Merb applications.
The generator can generate different types of Merb applications;
to see all of the available generator options, type

    $ merb-gen -H
{:lang=shell html_use_syntax=true}

For now, let's just stick with the types of Merb applications
that can be generated.

## Types
Merb can be used for anything from very small, quick, single-file applications
to large, complex web services.
Different application structures can be generated,
depending on the developer's needs.
The different application structures you can generate
are ``app``, ``core``, ``flat``, and ``very_flat``.

### App
The opinionated Merb stack.
This generates a full application directory structure
with a full set of configuration files.
It also adds a ``config/dependencies.rb`` file
which includes all of ``merb-more`` and ``DataMapper``.

    $ merb-gen app my-application
{:lang=shell html_use_syntax=true}

This app has everything needed
to start building a first-class web application;
it is the most similar to the default structure of Rails.
Much of this book will work with the assumption
that you have started in this manner.

Run this application by running ``merb``
in the application's root directory.
This will start Merb and bind it to the default port 4000.
To see your application in action, visit <http://localhost:4000/>.

### Core
Core will generate the full application directory structure
with a full set of configuration files.
Unlike the ``app`` -- the opinionated full stack --
no dependencies will be added.

    $ merb-gen core my-application
{:lang=shell html_use_syntax=true}

Start up this application by running ``merb``
in the application's root directory.
Notice that, unlike the other three generated apps,
there is no default content in core.
Visiting <http://localhost:4000/> will generate an error
until content and routing are added.

### Flat
A flat application still keeps all its logic in a single file,
but has separate files for configuration and its own view directory.

    $ merb-gen flat my-application
{:lang=shell html_use_syntax=true}

Flat applications are run, like any other generated merb app,
by running ``merb`` in the application's root directory.
By default, all methods in the ``my-application`` class
will be treated as actions with ``my-application`` as the controller.
e.g.: <http://localhost:4000/my-application/foo>

This will call ``MyApplication#foo``
and render the output from the ``foo.html.*`` template.

### Very Flat
A Very Flat application is similar to other Ruby micro frameworks,
where the entire application is in one file.

    $ merb-gen very_flat my-applcation
{:lang=shell html_use_syntax=true}

To run a very flat application, start up Merb with the following command
(within your application directory):

    $ merb -I my-application.rb
{:lang=shell html_use_syntax=true}

This will start Merb and bind it to the default port (4000).
To see your application in action, visit <http://localhost:4000/>.


