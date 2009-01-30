# Authenticatie

* This will become a table of contents (this text will be scraped).
{:toc}

> Het is de verantwoordelijkheid van een authenticatie systeem om te bewijzen dat de identiteit die een gebruiker beweerd te hebben
> wel degelijk zijn echte identiteit is. Er zijn verschillende manieren om dit te bereiken, onder andere
> via trusted hosts, paswoord verificatie, en trust netwerken (zoals ‘Open-ID’).
> Nadat de verificatie heeft plaatstgevonden, zijn de verantwoordelijkheden van het authenticatie systeem voldaan.
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
In plaats daarvan focust het op de logica nodig 
om na te gaan of een object zich kan authenticeren, 
en slaat het de sleutels van de geauthenticeerde objecten op in de sessie.

Dit is in feite het hoofdprincipe van MerbAuth. 
De sessie wordt gebruikt als plaats voor authenticatie, 
met een beetje hulp van de controller helpers.

Je kan kiezen om een controller actie te beschermen, of een route/groep van routes. 
Dit is de reden waarom je mensen hoort spreken van een geauthenticeerde sessie.

MerbAuth maakt gebruik van Merb's exception handling faciliteiten die 
correcte HTTP status codes terugkeren.
Om een login te laten falen, of een login te forceren op om het even welk punt in je controller code, 
moet je gewoon een ``Unauthenticated`` exception gooien, met een optioneel bericht 
en de gebruiker krijgt onmiddellijk de login-pagina te zien. 
De login pagina is in feite 
de view template voor ``Extensions#unauthenticated``

Het is mogelijk om gebruik te maken van MerbAuth met om het even welk object als een gebruiker object, 
op voorwaarde dat dit object niet als "false" geëvalueerd wordt 
en dat het kan worden geserializeerd "van" en "naar" de sessie.

Ten slotte is merb-auth zeer krachtig vooral vanwege zijn "geketende" strategieën capaciteit. 
Je kan zoveel strategieën toevoegen als je wil en 
ze zullen één na één worden geprobeerd totdat er één wordt gevonden die werkt (login), 
of er geen enkele  de test heeft doorstaan (mislukte poging).

Een authenticatie strategie is gewoon een manier om een request te authenticeren. 
Voorbeelden van strategieën kunnen zijn: 

* salted user (gebruiker login met een paswoord gebruik ,makend van "salted" encryptie)
* openid
* api key/token
* basic http authenticatie


### merb-auth-more

[merb-auth-more][] voegt extra functies toe aan merb-auth-core.
De gem biedt een aantal generische strategieën en "Gebruiker" object mixins.

Strategieën:

* login of email paswoord form (ook gekend als password\_form)
* basic HTTP authenticatie (ook gekend als basic\_auth)
* OpenId

Mixins:

* ActiveRecord salted gebruiker
* DataMapper salted gebruiker
* relaxdb salted gebruiker
* sequel salted gebruiker

De salted gebruiker mixin biedt basic salted SHA1 password authenticatie.
Dit implementeert de vereiste ``User.authenticate methode`` te gebruiken met 
de standaard paswoord strategieën.

### merb-auth-slice-password

[merb-auth-slice-password][] is een heel eenvoudige Merb slice.
De slice voorziet developers van een basic login en logout functie.
Standaard bevat het ook de form based paswoord logins en basic authenticatie.

Standaard laadt de slice de ``password\_form`` 
en de ``basic\_auth`` strategieën.

Views en strategieën kunnen worden aangepast 
zoals wordt uitgelegd in het "Authenticated Hello World" voorbeeld.


## Authenticatie in Merb Stack

Wanneer je een applicatie genereert met de standaard merb stack [^ merb-stack-app], 
is merb-auth reeds ingesteld voor normaal gebruik. 

Als je hiervan geen gebruik wilt maken, 
zet dan de ``merb-auth`` dependency  
in ``config/dependencies.rb`` gewoon in commentaar.


## Authenticated Hello World


### Genereer een application

De eerste stap is je applicatie te genereren m.b.v. de Merb stack.

    $ merb-gen app hello_world
    $ cd hello_world
{:lang=shell html_use_syntax=true}

Dit genereert een application stub, met de authenticatie reeds geconfigureerd.
De elementen aan de basis zijn:

    app/models/user.rb

    merb/merb-auth/setup.rb
    merb/merb-auth/strategies.rb
{:lang=ruby html_use_syntax=true}

De standaard setup voor user authenticatie wordt gedaan 
met een paswoord en login.
Uiteraard moeten we eerst ook een database opzetten en een gebruiker toevoegen.


    $ rake db:automigrate
    $ merb -i
    >> u = User.new(:login => "login_name")
    >> u.password = u.password_confirmation = "sekrit"
    >> u.save
{:lang=ruby html_use_syntax=true}


### Genereer iets om te beschermen 

Nu we een applicatie hebben, en een gebruiker, hebben we iets nodig om te beschermen.

    $ merb-gen controller hello_world
{:lang=ruby html_use_syntax=true}

Laat ons iets in de controller stoppen.

    class HelloWorld < Application
      def index
        "Hello World"
      end
    end
{:lang=ruby html_use_syntax=true}

Indien je nu merb opstart en in je browser gaat naar <http://localhost:4000/hello_world>
zie je de "Hello World" resultaten.

### Bescherm de route

Dit is nog niet beschermd, dus laat ons dit even in orde brengen.
We kunnen dit zowel in de routes in ``config/router.rb`` 
als in de controller actie zelf.
We proberen eerst de router optie.

Open het bestand ``config/router.rb`` 

    Merb::Router.prepare do
      authenticate do
        match("/hello_world").to(:controller => "hello_world")
      end
    end
{:lang=ruby html_use_syntax=true}

Dit zorgt ervoor dat de gebruiker moet aanloggen.
Dit wordt ontdekt tijdens de routering and wanneer aanloggen niet lukt, dan stopt de routering. (???)
Probeer nu even  <http://localhost:4000/hello_world> uit.
Je zal zien dat je deze keer moet aanloggen om dezelfde pagina te krijgen.

Ok.  
Logout, <http://localhost:4000/logout>


### Bescherm de controller

Laat ons nu de code van de router terug verwijderen, 
en de bescherming op controller niveau plaatsen.
Dit laat bivoorbeeld een fijnere controle over toe over de resources. 


    Merb::Router.prepare do
     match("/hello_world").to(:controller => "hello_world")
    end
{:lang=ruby html_use_syntax=true}

Laat het ons nu in de controller zetten: 

    class HelloWorld < Application

      before :ensure_authenticated

      def index
        "Hello World"
      end

    end
{:lang=ruby html_use_syntax=true}


Om toegang te krijgen tot de momenteel aangelogde gebruiker binnen de controller gebruik je: 

    session.user
{:lang=ruby html_use_syntax=true}

Echt ... 
Voor een basis Hello World authenticatie is dit alles.  


### Overschrijf de standaard views

Indien je meer aanpassingen wenst, kan je ook:


    rake slices:merb-auth-slice-password:freeze:views
{:lang=ruby html_use_syntax=true}

Dit zal de views van de slice copiëren 
naar de ``slices`` directory in je applicatie.

Nadien moet je ze verplaatsen/copiëren naar je ``app/views``
en deze views te editeren. (???)


[^merb-stack-app]: merb-gen app hello\_world

## Testen van een authenticated request

Om een request te testen die moet geauthenticeerd worden, moet je eerst aanloggen.
De eenvoudigste wijze om aan te loggen wanneer je een request spec runt, is om een helper te gebruiken.

Hier is een voorbeeld van twee helpers toegevoegd aan ``spec/spec\_helper.rb``.

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

De eerste helper creëert een standaard gebruiker tenzij deze reeds bestaat.
De tweede helper stuurt een login request, gebruik makend van de attributen van de standaard gebruiker.
Merk op dat de login actie gebruik maakt van het PUT HTTP werkwoord.

Nu je deze helpers hebt toegevoegd, moet je enkel je voorbeelden lichtjes wijzigen:

    before(:each) do
      login
      @response = request(resource(:articles))
    end
{:lang=ruby html_use_syntax=true}

In het bovenstaand voorbeeld, zal de request naar de articles URI worden geauthenticeerd.

<!-- Links -->
[Adam French]:      http://adam.speaksoutofturn.com
[merb-auth]:        http://github.com/wycats/merb/tree/master/merb-auth
[merb-auth-core]:   http://github.com/wycats/merb/tree/master/merb-auth/merb-auth-core
[merb-auth-more]:   http://github.com/wycats/merb/tree/master/merb-auth/merb-auth-more
[merb-auth-slice-password]: http://github.com/wycats/merb/tree/master/merb-auth/merb-auth-slice-password

*[API]: Application Programming Interface
