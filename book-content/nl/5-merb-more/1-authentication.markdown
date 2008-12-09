# Authenticatie

* This will become a table of contents (this text will be scraped).
{:toc}

> Het is de verantwoordelijkheid van een Authenticatie systeem te bewijzen dat de identiteit die een gebruiker beweerd te hebben
> wel degelijk zijn echte identiteit is. Er zijn verschillende manieren om dit te bereiken, onder andere
> via trusted hosts, paswoord verificatie, en trust netwerken (zoals ‘Open-ID’).
> Nadat de verificatie heeft plaatstgevonden, zijn de verantwoordelijkheden van het Authenticatie systeem voldaan.
> [Adam French][]{: .quote-author}
{: cite=http://adam.speaksoutofturn.com/post/57615195/entication-vs-orization .lead-quote}

## Merb-auth gems

[merb-auth][] is een meta-gem.
Een meta-gem is een Ruby gem zonder enige code.
Het enige doel is om afhankelijkheden te declareren en de installatie makkelijker te maken.

Vanaf Merb 1.0.x gebruikt merb-auth 3 gems:
* [merb-auth-core][]
* [merb-auth-more][]
* [merb-auth-slice-password][]

### merb-auth-core

[merb-auth-core][] legt niet op wat je moet gebruiken als user model,
of hoe je authenticatie moet doen.
In plaats daarvan focust het op de logica nodig om na te gaan of een object
zich kan authenticeren, en slaat het de sleutels van de geauthenticeerde objecten op 
in de sessie.

Dit is in feite het hoofdprincipe van MerbAuth. 
De sessie wordt gebruikt als plaats voor authenticatie, 
met een beetje hulp van de controller helpers.

Je kan kiezen om een controller actie te beschermen, of een route/groep van routes. 
Dit is de reden waarom je mensen hoort spreken van een geauthenticeerde sessie.

MerbAuth maakt gebruik van Merb's exception handling faciliteiten die 
correcte HTTP status codes terugkeren.
Om een login te laten falen, of een login te forceren op om het even welk punt in je controller code, 
moet je gewoon een Unauthenticated exception gooien, met een optioneel bericht 
en de gebruiker krijgt onmiddellijk de login-pagina te zien. 
De login pagina is in feite de html-weergave voor Extensions#unauthenticated

Het is mogelijk om gebruik te maken van MerbAuth met om het even welk object als een gebruiker object, 
op voorwaarde dat dit object niet als "false" geëvalueerd wordt en 
dat het kan worden geserializeerd "van" en "naar" de sessie.


Ten slotte is merb-auth zeer krachtig vooral vanwege zijn "geketende" strategieën capaciteit. 
Je kan zoveel strategieën toevoegen als je wil en ze zullen worden een na een worden geprobeerd  
totdat er een wordt gevonden die werkt (login), of er geen enkele  de test heeft doorstaan (mislukte poging).

Een authenticatie strategie is gewoon een manier om een request te authenticeren. 
Voorbeelden van strategieën kunnen zijn: 
* salted user (gebruiker login met een paswoord gebruik ,makend van "salted" encryptie)
* openid
* api key/token
* basic http authenticatie


### merb-auth-more

[merb-auth-more][] voegt extra functies toe aan merb-auth-core.
De gem viedt een aantal generische strategieën en "Gebruiker" object mixins.

Strategieën:
* login of email paswoord form (ook gekend als password\_form)
* basic http authenticatie (ook gekend als basic\_auth)
* openid


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

Views and strategies can be customized as exlained in the 
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

[Adam French]:      <http://adam.speaksoutofturn.com>
[merb-auth]:        <http://github.com/wycats/merb/tree/master/merb-auth>
[merb-auth-core]:   <http://github.com/wycats/merb/tree/master/merb-auth/merb-auth-core>
[merb-auth-more]:   <http://github.com/wycats/merb/tree/master/merb-auth/merb-auth-more
[merb-auth-slice-password]: <http://github.com/wycats/merb/tree/master/merb-auth/merb-auth-slice-password>