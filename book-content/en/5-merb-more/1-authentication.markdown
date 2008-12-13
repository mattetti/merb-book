# Authentication

* This will become a table of contents (this text will be scraped).
{:toc}

> The responsibilities of an Authentication system is to prove a user’s claimed
> identity is indeed his real identity. There’s quite a few approaches an
> Authentication system can go about doing this including trusted hosts,
> password verification, and trust networks (like ‘OpenID’).
> After the verification has occurred, the Authentication’s system responsibilities
> are complete.
> [Adam French][]{: .quote-author}
{: cite=http://adam.speaksoutofturn.com/post/57615195/entication-vs-orization .lead-quote}

## Merb-auth gems

[merb-auth][] is a meta-gem.
A meta-gem is a Ruby gem without any code.
It's sole purpose is to declare dependencies and make installation easier.

As of Merb 1.0.x merb-auth uses 3 gems:
* [merb-auth-core][]
* [merb-auth-more][]
* [merb-auth-slice-password][]

### merb-auth-core

[merb-auth-core][] does not try to dictate what you should use as a user model,
or how it should authenticate.
Instead it focuses on the logic required to check that an object
passes authentication, and store the keys of authenticated objects
in the session.

This is in fact the guiding principle of MerbAuth.
The Session is used as the place for authentication,
with a sprinkling of controller helpers.

You can choose to protect a controller action, or a route/group of routes.
This is why you might hear people refer to an authenticated session.

MerbAuth makes use of Merb’s exception handling facilities which
return correct HTTP status codes.
To fail a login, or to force a login at any point in your controller code,
simply raise an ``Unauthenticated`` exception, with an optional message
and the user will be presented with login page.
The login page is in fact the view template for ``Extensions#unauthenticated``.

It is possible to use MerbAuth with any object as a user object,
provided that object does not evaluate to false and
it can be serialized in and out of the session.

Finally, merb-auth is very powerful mainly because of its chained strategies capacity.
You can add as many strategies as you like and they will be tried one after another
until either one is found that works (login), or none of them have passed (failed attempt).

An authentication strategy is just a way to authenticate a request.
Examples of strategies would be:
* Salted user (user login with a password using a "salted" encryption)
* OpenID
* API key/token
* Basic HTTP Authentication


### merb-auth-more

[merb-auth-more][] adds extra features to merb-auth-core.
The gem offers a series of generic Strategies and "User" object mixins.

Strategies:
* login or email password form (aka password\_form)
* basic HTTP authentication (aka basic\_auth)
* OpenID


Mixins:
* ActiveRecord salted user
* DataMapper salted user
* relaxdb salted user
* sequel salted user

The salted user mixin provides basic salted SHA1 password authentication.
It implements the required User.authenticate method for use with
the default password strategies.

### merb-auth-slice-password

[merb-auth-slice-password][] is a very simple Merb slice.
The slice will provide developers with a basic login and logout function.
By default it also include the form based password logins and basic authentication.

By default the slice will load the password\_form and the basic\_auth strategies

Views and strategies can be customized as explained in the
Authenticated Hello World example.


## Authentication in Merb Stack

When you generate an application with the default merb stack[^merb-stack-app],
merb-auth is already setup for normal usage.

If you don't want to use this, simply comment out the dependency on merb-auth
in config/dependencies.rb


## Authenticated Hello World


### Generate an application

First step is to generate your application using the Merb stack.

    $ merb-gen app hello_world
    $ cd hello_world
{:lang=shell html_use_syntax=true}

This generates an application stub, with authentication already configured.
The basic elements are:

    app/models/user.rb

    merb/merb-auth/setup.rb
    merb/merb-auth/strategies.rb
{:lang=ruby html_use_syntax=true}

The setup for user authentication is taken care of by default using a password
and login.
Of course we need to setup the database and add a user first.


    $ rake db:automigrate
    $ merb -i
    >> u = User.new(:login => "login_name")
    >> u.password = u.password_confirmation = "sekrit"
    >> u.save
{:lang=ruby html_use_syntax=true}


### Generate something to protect

Now we have an application, and a user, we need something to protect.

    $ merb-gen controller hello_world
{:lang=ruby html_use_syntax=true}

Let's put something into the controller.

    class HelloWorld < Application
      def index
        "Hello World"
      end
    end
{:lang=ruby html_use_syntax=true}

If you fire up merb now and head on over to <http://localhost:4000/hello_world>
you'll see the "Hello World" results.

### Protect the route

It's not protected yet, so let's fix that.
We can either protect it in the routes in config/router.rb or in the controller action.
Let's do the router option first.

Open up config/router.rb

    Merb::Router.prepare do
      authenticate do
        match("/hello_world").to(:controller => "hello_world")
      end
    end
{:lang=ruby html_use_syntax=true}

This will cause the user to login.
This is discovered in the router and when it fails, it stops in the router.
Try to hit <http://localhost:4000/hello_world> now.
You'll see that you need to login to access it!

Ok.  Logout, <http://localhost:4000/logout>


### Protect the controller

Now let's remove the code from the router, and put the protection at the
controller level.
This will allow a finer control over resources for example.


    Merb::Router.prepare do
     match("/hello_world").to(:controller => "hello_world")
    end
{:lang=ruby html_use_syntax=true}

Let's now put it into the controller:

    class HelloWorld < Application

      before :ensure_authenticated

      def index
        "Hello World"
      end

    end
{:lang=ruby html_use_syntax=true}


To get access to the currently logged in user inside your controller use:

    session.user
{:lang=ruby html_use_syntax=true}

Really... For a basic Hello World authentication, that's it.


### Overwrite the default views

If you want more customization, you can do:


    rake slices:merb-auth-slice-password:freeze:views
{:lang=ruby html_use_syntax=true}

What that will do is copy the views from the slice to the /slices/ folder
in your application.

Then you need to move/copy them to your /views/.
Editing the copied views in /app/views/ should now be taken into account.




[^merb-stack-app]: merb-gen app hello\_world

## Testing an authenticated request

To test a request that needs to be authenticated, you will first need to login.
The easiest way to login when you are running a request spec is to use a helper.

Here is an example of two helpers added to /spec/spec\_helper.rb

    Merb::Test.add_helpers do

      def create_default_user
        unless User.first(:login => "krusty")
          User.create( :login => "krusty",
                       :password => "klown",
                       :password_confirmation => "klown") or raise "can't create user"
        end
      end

      def login
        create_default_user
        request("/login", {
          :method => "PUT",
          :params => {
            :login => "krusty",
            :password => "klown"
          }
        })
      end

    end
{:lang=ruby html_use_syntax=true}

The first helper creates a default user unless it already exists.
The second helper sends a login request using the default user's attributes.
Note that the login action uses the PUT HTTP verb.

Now that you added these helpers, you just need to slightly modify your examples:

    before(:each) do
      login
      @response = request(resource(:articles))
    end
{:lang=ruby html_use_syntax=true}

In the above example, the request sent to the articles URI will be authenticated.

[Adam French]:      http://adam.speaksoutofturn.com
[merb-auth]:        http://github.com/wycats/merb/tree/master/merb-auth
[merb-auth-core]:   http://github.com/wycats/merb/tree/master/merb-auth/merb-auth-core
[merb-auth-more]:   http://github.com/wycats/merb/tree/master/merb-auth/merb-auth-more
[merb-auth-slice-password]: http://github.com/wycats/merb/tree/master/merb-auth/merb-auth-slice-password

*[API]: Application Programming Interface