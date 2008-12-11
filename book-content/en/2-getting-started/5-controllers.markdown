# Controllers

* This will become a table of contents (this text will be scraped).
{:toc}

**TECHNICAL REVIEW IN PROGRESS, PLEASE DO NOT TRANSLATE**

In the [MVC][] paradign, controllers are the glue layer that connects the
business logic of the Model with the View.

In Merb, controllers are classes inheriting from ``Merb::Controller``.
In a Merb stack app, a controller class called ``Application`` is created.
All generated controllers will inherit from ``Application`` and therefore
share the same attributes as ``Application``.

The [Router][] logic in Merb finds a controller and an action to send the
request to based on the incoming request details.

In this chapter we will look at how to organize controllers.
We will also discuss how to write **actions**;
the methods that are called on a controller.
Finally, we will look at how to extend the functionalities of a controller.

## RESTful controllers

You can generate two types of controllers.
An normal controller and a [RESTful][] controller.

    $ merb-gen controller birds
      [ADDED]  app/controllers/birds.rb
      [ADDED]  app/views/birds/index.html.erb
      [ADDED]  spec/requests/birds_spec.rb
      [ADDED]  app/helpers/birds_helper.rb
{:lang=shell html_use_syntax=true}
  
or

    $ merb-gen resource_controller 
{:lang=shell html_use_syntax=true}


The first command will generate a controller with an ``index action`` and 
an ``index view``(template).
    
+-- {: .notes}
  If you realized you made a mistake when generating your controller,
  You can delete the generated controller by appending ``-d`` at the
  end of the command you just sent:

      $ merb-gen controller cats -d
        [DELETED]  app/controllers/birds.rb
        [DELETED]  app/views/birds/index.html.erb
        [DELETED]  spec/requests/birds_spec.rb
        [DELETED]  app/helpers/birds_helper.rb
  {:lang=shell html_use_syntax=true}
=--


### The Default Routing Style

When a new application is generated, the router contains a single default route
which maps URL Paths <!-- is this the right name --> to Controllers like this:

    /:controller/:action/:id(.:format)

This means that a request for 'http://example.com/posts/display/17' would cause
an in instance of the Posts controller to be created,
and the method 'display' to be called on that instance with the :id of 17.
It might look something like this:

    Posts < Application
      def display
        #Post is a Model class
        @post = Post.git(params[:id])
        display @post
      end
    end.
{:lang=ruby html_use_syntax=true}

In this style methods are created to handle different actions.
Each Controller has a method for every action that it can respond to.
There are no limits on the number of actions that can be in a controller.
Particularly in small applications where there are only a couple of controllers,
this style allows the developer to easily add a new feature
by simply adding a method to a controller.

###The RESTful Style

The REST philosophy is to view every web request as a request to retrieve(GET),
create (POST), change(PUT), or remove(DELETE) some resource
over which the server is keeping track.
There are a number of benefits to this model.
<!-- we need a chapter on resources -->
Among them are clean URI name spaces,
well organized interaction between Models and Controllers,
and performance.
Generally, it is considered to be good practice
to have one resource controller for each Model.

To route to a resource controller use this line when setting up routes:

    resources :posts

Resources can also be singleton and/or nested.
Please read the [Router][] chapter for more information.

By default a resource Controller has seven methods.
These methods are routed to based on the HTTP method (GET, POST, PUT and DELETE)
as well as the URL.

####Index

routed to by:

    GET /posts
        /posts.index(.:format)

The expectation here is that the user will be presented with a list of all the
Resources of this type the server knows about.
In this case all the Posts in a blog perhaps.

####New

routed to by:

    GET /posts/new

This is the first of three User Interface methods that don't map nicely onto
the HTTP verbs.
It is used to show the use a form to create a new resource.
The form's content will be sent back to the server
and handled by the 'create' method.
In the example above the page might present the use with a form to write a new
blog post.

####Create

routed to by:

    POST /posts

This method receives data from the client that is used to construct a new
resource.
Generally, the system responds by redirecting the client to the newly created
resource, but that only a convention.

####Show

routed to by:
    GET /posts/:id

This request displays an individual resource identified by ':id'.
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

Of special interest in this function is the use of the HTTP verb 'PUT'.
Very few clients can use this verb.
To get around this restriction,
any POST with a method field containing 'PUT'
is silently converted to a PUT method by Merb
before the request is routed.

####Delete

routed to by:

    GET /posts/:id/delete

This is the last of the User Interface methods.
It is used to remove a resource from the server.
It presents the user with the information they need
to construct a proper destroy request.
It may also be used to confirm a users desire to remove the resource.
Request from this page are routed to the'destroy' method.

####Destroy

routed to by:
    DELETE  /posts/:id

This is a request for the server to remove a resource identified by :id.
For example the user might wish to remove an unwanted post from their blog.

Like update, this method relies upon an HTTP verb - DELETE - that is not widely
supported.
A Post with the a method field containing 'DELETE'
is silently converted to a DELETE Request.
This can present issues as a link tag cannot generate a post request
without the use of JavaScript.
One way around this is to use the delete page above
with a form or button to confirm the request.
Another is to use JavaScript to form a proper request.

###Adding and Removing Methods

While the above methods are standard, there are provisions made to add others.
It is best if such actions deal with a single resource,
and only doing the four basic operations to it.
Examples of good uses for adding functions might be
having multiple ways to view a resource
or needing more then one form to create or edit a resource.
These methods must be passed as option to the 'resources' declaration in the
router.
(Please seeAPI documentation)

There are also circumstances where it is not necessary to use all the methods.
Perhaps no on is allowed to delete a resource,
or the show page contains a form to edit the resource already.
In these cases,
simply not providing the method will prevent it from being called.

##Using merb-gen With Controllers

TODO -- need to mention both normal controllers and resources

##Controller Action Methods

This section will deal with what actually goes on in your controller methods.
Keep in mind that controller methods should be as light as possible.

###Render and Display

The most important thing a controller method does it return a value that is
passed on to the response.
This is different from Rails where the framework will always call a view for you.
In Merb is it perfectly fine to return a string directly in the controller.
eg:

    class Hello < Merb::Controller
      def hello_world
        "Hello World!"
      end
    end
{:lang=ruby html_use_syntax=true}

This would send the text "Hello World!" directly back as the response.

Usually, we do not want to put the text in the controller.
This is what the [View][] layer is for.
Views are invoked from controllers using either the 'render' or 'display'
methods.

The render method does a number of thing behind the seen.  It determines the
Layout to use, determines which View file to render, renders it and returns the
resulting text.
Render ensures that all instance variable
(ie variables that begin with an '@')
which were set in the controller are available to the view and layout.
eg:

    class Posts < Application
      def show(id)
        @post = Post.get(id)
        render
      end
    end
{:lang=ruby html_use_syntax=true}

This might render the 'show.html.erb template using the posts.html.erb layout.
Both of these file would have the @post variable available to them.
Also note that render was the last item in the method.
Ruby automatically returns the last value in a method
as the return value for that method.
<!-- can anyone be clearer here? -->

The 'display' method does everything the render method does
but goes a step further.
If display cannot find a valid template to render,
it instead calls a method on the object it was passed based on the format.
If that method returns a value it is passed to the response.
eg:

    class Posts < Application
      def show(id)
        @post = Post.get(id)
        display @post
      end
    end
{:lang=ruby html_use_syntax=true}

Here, we might render the same templates as before, in response to a request
for HTML.
But, if this method was marked as providing XML(see format below for how)
and there was no XML template,
then the display method would instead call ``@post.to_xml``
and return the result.

There are many other options for both of these methods.
Developers should consult the API Documentation for both of them.

###Interaction with Model

Most action methods will want to interact with Model.
How this is done will depend on the ORM used.
Records returned from the model should be stored in instance variables
(these begin with an '@') so they can be used by the Views.

While we cannot antisipate all circumstances,
the need to use more then two or three Model methods is often a sign
that more functionality need to be added to the model layer.
If the same Model class is being called repeatedly,
moving that login into a new method for that class is a good way to refactor.
When more then two or three Model classes are needed by a controller,
ether rework the controller to match your models more closely,
or create a presentor model that encapisolates these relationships.

Merb can handle many of the exceptions thrown by ORM with 404 pages.
It is a good practice howevever to catch exceptions from the Model layer,
and give the user a better discription of the problem.

###Information From the Request: The 'params' and 'request' Hashes

The controller has access to two hashes that are formed out of the request.

The params hash contains:

* The controller and action the router decided on.
* A hash of any Post or Query data sent by the client.
  (this is where the data from forms ends up)
* Other elements from the URI parsing, such as :id
  (please see the chapter on the [Router][] for more information

The request hash contains information from the HTML request and the envrionment.
Normally, Merb will translate the infromation here into an easier to use form
for you, but that is not always sufficient.

###Persistant Information About the Client: Sessions and Cookies

HTTP is a stateless protocol.
That means that each request stands on its own,
and there is no way to keep information between calls.
For web applications it is convient to simulate a persistant state.
Cookies are used to idintify clients.
They can be used through the cookies hash in the controller.

However, there is an easier and more flexible way to give an app the illusion
that there is a persistant state that follows a client around.
The session hash persists between different requests from the same client.
There are a number of different ways to maintain sessions,
which we will not go into here.
The result is the same however.
Any object that is stored into the session will still be there the next time
the user makes a request.

Sessions can be use to store user credentials.
Indeed it is the session that Merb-Auth is authintication.
Sessions can be used to store error messages after a redirect.
It can also store information about the steps completed in a multi-step
process.
eg.

    class Users < Application
      def login
        if login_was_successful
          #make sure that when the user reaches the home page we can remember
          #who they were.
          session[:user] = User.current_user
          redirect url(:home)
        else
          #Provide a message telling the user why ther are back at the login
          #screen.
          session[:error_message] = "Could not log you in please try again."
          redirect url(:login)
        end
      end
    end
{:lang=ruby html_use_syntax=true}

Developers coming from rails will note that there is not 'flash' hash in merb.
Instead Sessions can be used directly to send messages between pages.

###Redirecting

Instead of sending a page back to the browser,
a server can ask the browser to go to a different page for information.
In Merb, this is often done in response to a request to modify a resource
through a POST, PUT, or DELETE request.

To accomplish this the server sends the client a specially formatted response,
usually without any body.
Merb will create these responses for you with the [redirect][] function.
eg.

    class Posts < Application
      def update(id)
        post = Post.get(id)
        if post.update_attributes(params[:post])
          redirect resource(post) #show the client the updated post
        else
          session[:errors] = post.errors

          #send the client back to the edit page so they can fix the errors.
          redirect resource(:edit, post)
        end
      end
    end
    #
    #NOTE: The resource method in the example above returns a URI.  It is
    #      simular to the url method.
{:lang=ruby html_use_syntax=true}



###Exceptions and Status Codes

TODO -- How does merb deal with exceptions

In addation to raising exceptions,
Merb can set the status code directly using the 'status=' method.
eg.

    class Posts < Application
      def update(id)
        unless params[:post]
          status = 401 #tell the client we could not understand the request.
          return render("We could not seem to find the content of modified post",
              :layout=>'error')
        end
        post = Post.get(id)
        post.update_attributes(params[:post])
        redirect resource(post) #show the client the updated post
      end
    end
{:lang=ruby html_use_syntax=true}

##Extending Controllers

In this section, we will look at the Controller classes
and how to use them to fine tune the behavior of an application.

###Formats

TODO - What formats are, How do we determin the format of a
request(.format || accept-format header), using provides, generating differnt
formats, examples.  Mention the value of RESTful controllers and web services.

###Before and After Filters

TODO -- about filter, creating filters, order of exicution, breaking out of
the filter chain, returning or modifying the responce in a filter, examples.

###Use of 'Application'

The default stack for the merb app as well as the controller generators make
all their controllers inherit from Application.
Developers can take advantage of this by putting methods
in the application class.
These methods will then be availible to all controllers.

The application class can also set before and after filters that will be run
for all controllers.

The Application class is defined in the file, "app/controllers/application.rb"

###Private Methods

It is best to refactor as much logic out of the controller as possible.
When the controller does need to have more complex logig in it,
it should be placed in private methods.
This keeps action methods cleaner and easier to test an debug.
It is important to make these methods private
because public methods can be invoked by the router by default.
This can be a security hole.

[MVC]:      /getting-started/mvc
[Router]:   /getting-started/router
[redirect]: http://merbivore.com/documentation/1.0/doc/rdoc/merb-core-1.0/index.html?a=M000529&name=redirect
[RESTful]:  http://en.wikipedia.org/wiki/Representational_State_Transfer#RESTful_Web_services
[View]:     /getting-started/view
