# Controllers

* This will become a table of contents (this text will be scraped).
{:toc}

> A controller is the link between a user and the system. 
> It provides the user with input by  arranging for relevant views to present
> themselves in appropriate places on the screen.<!-- break -->  
> It provides means for user output by presenting the user with menus or other
> means of giving commands and data.<!-- break -->  
> The controller receives such user output, translates it into the appropriate
> messages and pass these messages onto one or more of the views. <!-- break -->  
> - [Trygve Reenskaug][]{: .quote-author}, author of the model-view-controller
> pattern design[^mvc-essay]
{: cite=http://heim.ifi.uio.no/~trygver/1979/mvc-2/1979-12-MVC.pdf .lead-quote}


In the [MVC][] paradigm, controllers represent the glue layer
that connects the business logic (Model) with the View.

Concretely, the controller is responsible for mapping an end-user action
to an application response.

In Merb, technically speaking,
controllers are classes inheriting from ``Merb::Controller``.
In a Merb-stack app, a controller class called ``Application`` is created.
All generated controllers inherit from ``Application``;
therefore, they share the same attributes as ``Application``.

Merb's [Router][] logic examines the details of the incoming request,
comparing them to rules specified in the ``router.rb`` file.
Assuming that a match can be found,
it then sends the request to the appropriate controller and action.

In this chapter, we will look at how to generate and organize controllers.
We will also discuss how to write **actions**,
controller methods that are called on to handle incoming requests.
Finally, we will look at how to extend the functionalities of a controller.

## Generating controllers

You can generate two types of controllers:
a standard controller and a [RESTful][] controller.

### A standard controller

    $ merb-gen controller birds
      [ADDED]  app/controllers/birds.rb
      [ADDED]  app/views/birds/index.html.erb
      [ADDED]  spec/requests/birds_spec.rb
      [ADDED]  app/helpers/birds_helper.rb
{:lang=shell html_use_syntax=true}
  
The command above generates several files.
The controller file (``birds.rb``) will contain methods for each action,
as well as other methods needed by the controller.
The view template file (``index.html.erb``) can be used to generate HTML,
using an ``erb`` (embedded Ruby) processor.
The remaining files (``birds_spec.rb``, ``birds_helper.rb``)
should be used to store test specifications and helper methods.

Let's take a quick look at the generated controller:

    class Birds < Application

      def index
        render
      end

    end
{:lang=ruby html_use_syntax=true}

The generator added a new class called ``Birds``,
inheriting from ``Application``.
The new class has one method called ``index``.
In the context of a controller,
we will often refer to these methods as **controller actions** or simply **actions**.


``Application`` (a subclass of ``Merb::Controller``)
is the class from which controllers usually inherit.
So, it is a convenient place to share code between controllers.<!-- break -->  
(_use with care_)


+-- {: .notes}
If you realize that you made a mistake when generating your controller,
you can delete the generated controller by appending ``-d`` at the
end of the command you just sent:

      $ merb-gen controller birds -d
        [DELETED]  app/controllers/birds.rb
        [DELETED]  app/views/birds/index.html.erb
        [DELETED]  spec/requests/birds_spec.rb
        [DELETED]  app/helpers/birds_helper.rb
  {:lang=shell html_use_syntax=true}
=--

### A REStful controller

    $ merb-gen resource_controller cats
      [ADDED]  spec/requests/cats_spec.rb
      [ADDED]  app/controllers/cats.rb
      [ADDED]  app/views/cats/index.html.erb
      [ADDED]  app/views/cats/show.html.erb
      [ADDED]  app/views/cats/edit.html.erb
      [ADDED]  app/views/cats/new.html.erb
      [ADDED]  app/helpers/cats_helper.rb
{:lang=shell html_use_syntax=true}

If you open the newly generated controller file (``app/controllers/cats.rb``),
you will notice that the generator created a new class called ``Cats``.
As expected, the class inherits from ``Application``.
However, this time, instead of an empty ``index`` action,
we find seven fully-defined actions.

Let's look at the generated file:

    class Cats < Application
      # provides :xml, :yaml, :js

      def index
        @cats = Cat.all
        display @cats
      end

      def show(id)
        @cat = Cat.get(id)
        raise NotFound unless @cat
        display @cat
      end

      def new
        only_provides :html
        @cat = Cat.new
        display @cat
      end

      def edit(id)
        only_provides :html
        @cat = Cat.get(id)
        raise NotFound unless @cat
        display @cat
      end

      def create(cat)
        @cat = Cat.new(cat)
        if @cat.save
          redirect resource(@cat), :message => {:notice => "Cat was successfully created"}
        else
          message[:error] = "Cat failed to be created"
          render :new
        end
      end

      def update(id, cat)
        @cat = Cat.get(id)
        raise NotFound unless @cat
        if @cat.update_attributes(cat)
           redirect resource(@cat)
        else
          display @cat, :edit
        end
      end

      def destroy(id)
        @cat = Cat.get(id)
        raise NotFound unless @cat
        if @cat.destroy
          redirect resource(:cats)
        else
          raise InternalServerError
        end
      end

    end # Cats
{:lang=ruby html_use_syntax=true}


Wow, that's a lot code.
As a rule of thumb,
you should **not** use generated code that you don't understand.
Luckily, the code above is pretty simple to understand
and we'll go through it in great detail.

But before we dig into the code, let's talk about [REST][].

## REST

[REST][] is an acronym for [Representational State Transfer][].
It was first introduced in 2000 by [Roy Fielding][][^rest\_intro].
REST refers to a software architectural style outlining how [resources][]
are defined and addressed.
So, [resources][] are the key components of REST.

**What is a resource, in the context of REST?**

A resource is a source of specific information,
referenced by a URI (global identifier).
In lay terms, it's some information you can access via a specific address.
REST uses the HTTP protocol to communicate data between the different actors.
It's often used for web services,
because its principles apply very well to web resources.

**Here is how people usually map REST web resources:**

**URI:**      http://site.com/cats or http://site.com/cats/1-felix
(global identifier/address)<!-- break -->  
**Format:**  MIME Type or extension (HTML, JSON, XML, YAML, CSV, PDF, ...)<!-- break -->  
**action:**   map the HTTP methods (POST, GET, PUT, and DELETE) to resource methods

If a resource is defined, Merb uses the ``URI`` and the HTTP method
to pick a controller and an action.

----

**TECHNICAL REVIEW IN PROGRESS, PLEASE DO NOT TRANSLATE**


### The Default Routing Style

When a new application is generated, the router contains a single default route
which maps URL Paths <!-- is this the right name --> to Controllers like this:

    /:controller/:action/:id(.:format)

This means that a request for ``http://example.com/posts/display/17``
would cause an instance of the ``Posts`` controller to be created.
The method ``display`` would be called on that instance with an ``:id`` of 17.
It might look something like this:

    Posts < Application
      def display
        #Post is a Model class
        @post = Post.get(params[:id])
        display @post
      end
    end.
{:lang=ruby html_use_syntax=true}

In this style, methods are created to handle different actions.
Each Controller has a method for every action that it can respond to.
There are no limits on the number of actions that can be in a controller.
Particularly in small applications where there are only a couple of controllers,
this style allows the developer to easily add a new feature
by simply adding a method to a controller.

###The RESTful Style

The REST philosophy is to view every web request
as a request to retrieve (GET),
create (POST), change (PUT), or remove (DELETE) some resource
over which the server is keeping track.
There are a number of benefits to this model.
<!-- we need a chapter on resources -->
Among them are clean URI name spaces,
well organized interaction between Models and Controllers,
and performance.
Generally, it is considered to be good practice
to have one resource controller for each Model.

To route to a resource controller, use this line when setting up routes:

    resources :posts

Resources can also be singleton and/or nested.
Please read the [Router][] chapter for more information.

By default, a resource Controller has seven methods.
The routing for these methods is based on the HTTP method
(GET, POST, PUT, and DELETE), as well as the URL.

####Index

routed to by:

    GET /posts
        /posts.index(.:format)

The expectation here is that the user will be presented with a list
of every resource of this type that the server knows about.
In the current example, this might be all of the posts in a blog.

####New

routed to by:

    GET /posts/new

This is the first of three User Interface methods that don't map nicely
onto the HTTP verbs.
It is used to show the use of a form to create a new resource.
The form's content will be sent back to the server
and handled by the ``create`` method.
In the example above,
the page might present the use with a form to write a new blog post.

####Create

routed to by:

    POST /posts

This method receives data from the client
that is used to construct a new resource.
Generally, the system responds by redirecting the client
to the newly created resource, but this is only a convention.

####Show

routed to by:

    GET /posts/:id

This request displays an individual resource identified by ``:id``.
For example, the above might show an single blog posting with all of its
comments.

####Edit

routed to by:

    GET /posts/:id/edit

This is another User Interface method.
It is intended to help a user edit a resource
by displaying a form with that resource's information in it.
In the example above, the user might be presented
with a form to edit an already existing post.
When the form is sent to the server it, it will be handled by the update method.

####Update

routed to by:

    PUT /posts/:id

This method is a request to change an already existing resource.
The method needs to update the model and the return a response to the user.
A common convention is to redirect the user to the modified resource.

Of special interest in this function is the use of the HTTP verb "PUT".
Very few clients can use this verb.
To get around this restriction,
any POST with a method field containing "PUT"
is silently converted to a PUT method by Merb
before the request is routed.

####Delete

routed to by:

    GET /posts/:id/delete

This is the last of the User Interface methods.
It is used to remove a resource from the server.
It presents the user with the information they need
to construct a proper destroy request.
It may also be used to confirm a user's desire to remove the resource.
Requests from this page are routed to the ``destroy`` method.

####Destroy

routed to by:

    DELETE  /posts/:id

This is a request for the server to remove a resource identified by ``:id``.
For example, the user might wish to remove an unwanted blog post.

Like update, this method relies upon an HTTP verb - DELETE -
that is not widely supported.
A POST whose method field contains "DELETE"
is silently converted to a DELETE Request.
This can present issues, as a link tag cannot generate a POST request
without the use of JavaScript.
One way around this is to use the delete page above
with a form or button to confirm the request.
Another way is to use JavaScript to form a proper request.

###Adding and Removing Methods

Although the methods listed above are standard in Merb,
provisions have been made to add others.
It is best if such actions deal with a single resource
and only perform the four basic operations to it.
Examples of good uses for adding functions might be
having multiple ways to view a resource
or needing more than one form to create or edit a resource.
These methods must be passed as options
to the 'resources' declaration in the router.
(Please see the API documentation)

There are also circumstances where it is not necessary
to use all of these methods.
Perhaps no user is allowed to delete a resource,
or the show page already contains a form to edit the resource.
In these cases,
simply not providing the method will prevent it from being called.

##Using merb-gen With Controllers

TODO -- need to mention both normal controllers and resources

##Controller Action Methods

This section will deal with what actually goes on in your controller methods.
Keep in mind that controller methods should be as light as possible.

###Render and Display

In general, the last thing a controller method does is return a value
that is passed on as its portion of the response.
This is different from Rails,
where the framework will always call a view for you.
In Merb, it is perfectly fine to return a string directly from the controller.

For example:

    class Hello < Merb::Controller
      def hello_world
        "Hello World!"
      end
    end
{:lang=ruby html_use_syntax=true}

This would send the text "Hello World!" directly back as the response.

Usually, we do not want to generate output text in the controller.
This is what the [View][] layer is for.
Views are invoked from controllers
using either the ``render`` or ``display`` method.

The ``render`` method does a number of things behind the scenes.
It determines the Layout to use, determines which View file to render,
renders it, and returns the resulting text.
``render`` ensures that all instance variables
(ie, variables that begin with an '@')
which were set in the controller are available to the view and layout.

For example:

    class Posts < Application
      def show(id)
        @post = Post.get(id)
        render
      end
    end
{:lang=ruby html_use_syntax=true}

This might render the ``show.html.erb`` template,
using the ``posts.html.erb`` layout.
Both of these files would have the ``@post`` variable available to them.
Also note that ``render`` was the last item in the method.
Ruby automatically returns the last value in a method
as the return value for that method.
<!-- can anyone be clearer here? -->

The ``display`` method does everything the ``render`` method does,
but goes a step further.
If ``display`` cannot find a valid template to render,
it instead calls a method on the object it was passed based on the format.
If that method returns a value, it is passed to the response.

For example:

    class Posts < Application
      def show(id)
        @post = Post.get(id)
        display @post
      end
    end
{:lang=ruby html_use_syntax=true}

Here, we might render the same templates as before,
in response to a request for HTML.
But, if this method was marked as providing XML
(see format below for details)
and there was no XML template,
then the ``display`` method would instead call ``@post.to_xml``
and return the result.

There are many other options for both of these methods.
Developers should consult the API Documentation for both of them.

###Interaction with Models

Most action methods will want to interact with one or more Models.
How this is done will depend on the ORM used.
Records returned from the model should be stored in instance variables
(these begin with an '@') so they can be used by the Views.

While we cannot anticipate all circumstances,
the need to use more then two or three Model methods is often a sign
that more functionality needs to be added to the Model layer.
If the same Model class is being called repeatedly,
moving that login <!-- (???) --> into a new method for that class
is a good way to refactor.
When more then two or three Model classes are needed by a controller,
ether rework the controller to match your models more closely,
or create a presenter model that encapsulates these relationships.

Using 404 pages,
Merb can handle many of the exceptions thrown by the ORM.
It is a good practice, however, to catch exceptions from the Model layer,
and give the user a better description of the problem.

###Information From the Request: The ``params`` and ``request`` Hashes

The controller has access to two hashes that are formed out of the request.

The ``params`` hash contains:

* The controller and action the router decided on.
* A hash of any Post or Query data sent by the client.
  (this is where the data from forms ends up)
* Other elements from the URI parsing, such as ``:id``
  (please see the [Router][] chapter for more information

The ``request`` hash contains information from the HTML request
and the environment.
Normally, Merb will translate the information here into an easier to use form
for you, but that is not always sufficient.

###Persistant Information About the Client: Sessions and Cookies

HTTP is a stateless protocol.
That means that each request stands on its own,
and there is no way to keep information between calls.
For web applications it is convenient to simulate a persistent state.
Cookies are used to identify clients.
They can be used through the cookies hash in the controller.

However, there is an easier and more flexible way to give an app the illusion
that there is a persistent state that follows a client around.
The ``session`` hash persists between different requests from the same client.
There are a number of different ways to maintain sessions,
but we will not go into these here.
The result is the same, however.
Any object that is stored into the session will still be there the next time
the user makes a request.

Sessions can be use to store user credentials.
Indeed, it is the session that Merb-Auth is authenticating.
Sessions can be used to store error messages after a redirect.
They can also store information about the steps that have been completed
in a multi-step process.

For example:

    class Users < Application
      def login
        if login_was_successful
          # Make sure that when the user reaches the home page,
          # we can remember who they were.
          session[:user] = User.current_user
          redirect url(:home)
        else
          # Provide a message telling the user why they are back
          # at the login screen.
          session[:error_message] = "Could not log you in; please try again."
          redirect url(:login)
        end
      end
    end
{:lang=ruby html_use_syntax=true}

Developers coming from Rails will note
that there is no ``flash` hash in Merb.
Instead, Sessions can be used directly to send messages between pages.

###Redirecting

Instead of sending a page back to the browser,
a server can ask the browser to go to a different page for information.
In Merb, this is often done in response to a request to modify a resource
through a POST, PUT, or DELETE request.

To accomplish this, the server sends the client a specially formatted response,
usually without any body.
Merb will create these responses for you
using the [redirect][] method.

For example:

    class Posts < Application
      def update(id)
        post = Post.get(id)
        if post.update_attributes(params[:post])
          redirect resource(post) # Show the client the updated post.
        else
          session[:errors] = post.errors

          # Send the client back to the edit page so they can fix the errors.
          redirect resource(:edit, post)
        end
      end
    end
    #
    # NOTE: The resource method in the example above returns a URI.
    #       It is similar to the url method.
{:lang=ruby html_use_syntax=true}

###Exceptions and Status Codes

TODO -- How does merb deal with exceptions?

In addition to raising exceptions,
Merb can set the status code directly using the 'status=' method.

For example:

    class Posts < Application
      def update(id)
        unless params[:post]
          status = 401 # Tell the client we could not understand the request.
          return render("We could not seem to find the content of modified post",
              :layout=>'error')
        end
        post = Post.get(id)
        post.update_attributes(params[:post])
        redirect resource(post) # Show the client the updated post.
      end
    end
{:lang=ruby html_use_syntax=true}

##Extending Controllers

In this section, we will look at the Controller classes
and how to use them to fine tune the behavior of an application.

###Formats

TODO - What formats are, How do we determine the format of a
request(.format || accept-format header), using provides, generating different
formats, examples.  Mention the value of RESTful controllers and web services.

###Before and After Filters

TODO -- about filter, creating filters, order of execution, breaking out of
the filter chain, returning or modifying the response in a filter, examples.

###Use of ``Application``

Both the default stack for the merb app and the controller generators
make all of their controllers inherit from ``Application``.
Developers can take advantage of this by putting methods
in the ``Application`` class.
These methods will then be available to all controllers.

The ``Application`` class can also set "before" and "after" filters
that will be run for all controllers.

The ``Application`` class is defined
in the file  ``app/controllers/application.rb``.

###Private Methods

It is best to refactor as much logic out of the controller as possible.
When the controller does need to contain complex logic,
this should be placed in private methods.
This keeps action methods cleaner and easier to test and debug.
It is important to make these methods private,
because public methods can be invoked by the router by default.
This can be a security hole.


<!-- Links -->
[MVC]:              /getting-started/mvc
[redirect]: http://merbivore.com/documentation/1.0/doc/rdoc/merb-core-1.0/index.html?a=M000529&name=redirect
[Representational State Transfer]:         http://en.wikipedia.org/wiki/Representational_State_Transfer
[resources]:  http://en.wikipedia.org/wiki/Representational_State_Transfer#REST.27s_central_principle:_resources
[REST]:             http://en.wikipedia.org/wiki/Representational_State_Transfer
[RESTful]:          http://en.wikipedia.org/wiki/Representational_State_Transfer#RESTful_Web_services
[Router]:           /getting-started/router
[Roy Fielding]:     http://en.wikipedia.org/wiki/Roy_Fielding]
[Trygve Reenskaug]: http://en.wikipedia.org/wiki/Trygve_Reenskaug
[View]:             /getting-started/view

<!-- References -->
[^rest\_intro]: Chapter 5 of Fielding’s dissertation is ["Representational State Transfer (REST)"](http://www.ics.uci.edu/~fielding/pubs/dissertation/rest_arch_style.htm)
[^mvc-essay]:   http://heim.ifi.uio.no/~trygver/1979/mvc-2/1979-12-MVC.pdf

<!-- Abbreviations -->
*[HTTP]:    Hypertext Transfer Protocol
*[REST]:    Representational state transfer
