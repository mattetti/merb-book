#Controllers

In the [MVC][] Framework controllers are the glue layer that connects the
business logic of the Model with the appropriate View templates to respond to
generate a response.
In Merb controllers are implemented classes that inherit form Merb::Controller.
In most applications a single class called 'Application' is created
as a place to hold application wide setup.
Controllers are then formed as child classes of Application.

Controllers are instantiated directly by the Merb Framework.
The [Router][] logic in Merb chooses a controller and an action
based on the information about the incoming request.
An instance of the controller is created for each request
and a method is called based on the action.
The return value of this call becomes the body of the HTML Response.
(c.f. Rack)

In this chapter we will look at
how organize controllers using two of thecommon controller styles,
discuss how to write the methods that are called be the framework on a controller,
and how to extend the functionality of a controller
using filter, inheritance and private methods.

##Controller Styles

There are two standard ways to create controllers.
The first is based on the default Merb routing.
The second is based on a RESTful (#need reference) Resource model.

###The Default Routing Style

When a new application is generated, the router contains a single default route
which maps URL Paths (#is this the right name) to Controllers like this:

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
(#we need achapter on resources)
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
(#can anyone be clearer here?)

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

Here, we might render the same templates as before, in responce to a request
for HTML.
But, if this method was marked as providing XML(see format below for how)
and there was no XML template,
then the display method would instead call @post.to_xml
and return the result.

There are many other options for both of these methods.
Developers should consult the API Documentation for both of them.

###Interaction with Model

###The Three Hashes: params, session and request

###Redirecting

###Exceptions and Status Codes

###Cookies

##Extending Controllers

###Formats

###Before and After Filters

###Use of 'Application'

###Private Methods

[MVC]:    /getting-started/mvc
[Router]: /getting-started/router
[MVC]:    /getting-started/view
