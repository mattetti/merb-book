# Request Path

* This will become a table of contents (this text will be scraped).
{:toc}

Alle web applicaties reageren als antwoord (response) op een HTTP request door een client.
Elke actie eindigt met een antwoord van een HTTP server.
In dit hoofdstuk, volgen we de programma flow 
van client request tot aan de response.

## Van de client tot onze dorpel

De interne werking van het internet valt buiten de scope van dit boek.
Het is helpt echter wel te weten 
dat daar ergens een client is (bvb web browser) 
en dat de request die deze genereert passeert door een aantal
entiteiten (bvb proxies,cachen, firewalls) om onze servers te bereiken.
Elk van deze entiteiten kunnen naar de request kijken, deze wijzigen
en mogelijk stockeren wat we terugsturen.
Als alles goed gaat, is dit tranparant voor de gebruiker
en van geen belang voor de server.

Er zijn echter situaties (in het bijzonder met dynamische sites),
waar deze activiteiten toch moeten worden bekeken.
Er zijn ook mogelijkheden om voordeel te nemen van de infrastructuur van het internet
om de belasting vn de server te reduceren.
Dit kan zowel besparen op brandbreedte als op uitrustingskosten.

## Reverse Proxy (optioneel)

De eerste stop van een request in een live applicatie
is gewoonljk een reverse proxy zoals [NginX][] of [Apache][]'s [mod\_proxy][].
Afhankeljk van de setup, kunnen deze proxies statische files behandelen
(bvb. abeeldingen, CSS style sheets, JavaScript code, videos).
Dikwijls laten we een proxy ook gecachte pagina's terugsturen
zonder zelfs met onze applicatie te interageren.

[Phusion Passenger][] is  _in zichzelf_ geen reverse proxy.
Laten we nu echter even doen alsof dit wel zo is.
(Meer specifiek, dat het de request via Apache zal ontvangen
en een [Rack][] request zal doorsturen naar de server applicatie.)

## Web server

Indien de request nog niet door de reverse proxy werd teruggekeerd, 
of geen reverse proxy wordt gebruikt,
wordt de request doorgestuurd naar een **web server**.
[Mongrel][], [Thin][], [Ebb][], en een aantal minder gekende programma's 
vervullen deze rol.

Indien de response wordt ontvangen door de webserver,
wordt deze geparsed en verzonden naar [Rack][] via een handler.


## Rack en Merb

Merb ontvangt de request als een [Rack][] omgeving.
Een Rack omgeving omvat alle CGI-stijl headers voor de request.
Omdat Merb Rack gebruikt als abstractie laag,
is het wijzigen van web servers echt eenvoudig.
Mogelijk hoor je mensen refereren naar deze web servers als adapters.

Vooraleer Merb de request doorheen de stack dispatched, 
kan iemand "Rack middlewares" toevoegen.
Rack middlewares kan de request processen voordat deze doorheen Merb wordt gestuurd.
Als alternatief kan de request ook worden "gewrapped",
om zo de uitvoering van custom code toe te laten en dit zowel voor- als nadat de request 
door de stack gaat.
Rack middlewares kan een heel krachtige toolset zijn, die je toelaat om
custom logging te doen, caching, profiling, enz.

We gaan het gebruik van Rack hier niet uitgebreid behandelen,
maar je kan de Merb Rack setup vinden in de ``config/rack.rb`` file
(in de full stack app).

## Router

Op het ogenblik dat de request wordt doorgegeven naar de stack,
vraagt de request aan de router naar waar te gaan.
De request stuurt zichzelf daarna naar de controller.

Het is de taak van de router om parameters te maken uit de request informatie
en de request te vertellen waarheen te gaan.
In de meeste gevallen mapt de router een een request op een controller methode (actie)
en extraheet ook de parameters van de request.

Achter de schermen heeft het Merb framework reeds een deel van het werk gedaan voor jou.
Op het ogenblik dat een request de controller bereikt, heeft Merb :

* het request URI path geëxtract.
* elke post geparsed of data gequeried die door de client werd verzonden,
  en deze in de ``params`` hash gestopt.
* de toegang opgezet om cookies te vragen en de huidige sessie.

De developer kan al deze informatie gebruiken om de request te routen.
Bekijk hiervoorhet hoofdstuk over routing <!-- (???) --> voor meer informatie.

## Controller actie

De request wordt nu gedispatched naar een controller methode.
Bijvoorbeeld: de ``show`` methode/actie van de ``Articles`` controller.
De actie kan een view renderen of eenvoudig een string terugkeren.
De teruggekeerde waarde van de methode zal gebruikt worden om een Rack response te maken.
Een Rack response is gewoon een eenvoudige tuple die \[status, headers, body\] bevat.

## Buiten de deur

Uiteindelijk stuurt Merb een well-formed Rack response terug naar de web server.
De web server, op zijn beurt, formatteert een HTTP response
die wordt teruggestuurd over de draad.
De client ontvangt de response en interpreteert deze, bijvoorbeeld door
een web pagina te renderen.


## Caching

Indien de caching nu wordt enabled,
gaat de request mogelijk niet doorheen het hele process zoals hierboven beschreven.
Caching kan gebeuren binnen Merb, een Rack Middleware, een Proxy server,
of de client web browser.


<!-- Links -->
[Apache]:             http://httpd.apache.org/
[GlassFish]:          /nl/deployment/jruby
[mod\_proxy]:         http://httpd.apache.org/docs/2.0/mod/mod_proxy.html
[Mongrel]:            http://mongrel.rubyforge.org/
[MVC]:                /nl/getting-started/mvc
[NginX]:              /nl/deployment/nginx
[Phusion Passenger]:  /nl/deployment/passenger
[Rack]:               http://rack.rubyforge.org/
[Thin]:               http://code.macournoyer.com/thin/
[Ebb]:                http://ebb.rubyforge.org/