#MVC

* This will become a table of contents (this text will be scraped).
{:toc}

MVC is een acronym dat staat voor Model, View, Controller.
Het beschrijft een soort web-applicatie structuur 
die makkelijk te testen en te onderhouden is 
door onderscheid te maken tussen de business logica, server logica, en content generatie.
Dit is de structuur van de standaard Merb app 
die is gegenereerd door het '``merb-gen app``' commando.
Dit is tevens de structuur gebruikt door [Rails][], [CakePHP][], [Django][], 
en vele ander populaire web-development frameworks.

Om doeltreffend te ontwikkelen in Merb, 
is het belangrijk dat men begrijpt hoe de MVC structuur werkt, 
en wat de meest doeltreffende weg is om hiermee te werken.
Dit hoofdstuk bespreekt het algemeen framerk.  
In de volgende drie hoofdstukken zal worden ingegaan op elk onderdeel in detail.

[Modellen][] vormen de kern van het framework.  
Zij zijn verantwoordelijk voor de business logica van uw applicatie, 
en in Merb, zijn ze meestal geassocieerd met database-toegang 
via een ORM zoals DataMapper of Active Record.
Soms worden modellen gebruikt in een ORM, 
puur als wrapper voor een database tabel. 
Maar meestal wordt een 'fat' model  beschouwd als een van de beste praktijken. 
Dat betekent dat de model-klassen de plaats zijn waar zaken 
zoals data relaties worden bijgehouden en de methodes 
om elk niet-triviaal stukje informatie terug te vinden of te manipuleren. 
De modellen vormen de kern van het framework. 
Zij zijn verantwoordelijk voor de business logica van uw applicatie. 
In Merb, zijn ze meestal geassocieerd met database-toegang 
via een ORM zoals ActiveRecord of DataMapper.

[Views][] vormen de attractieve buitenste schil van de applicatie.
Views zijn verantwoordelijk voor het genereren van de eigenlijke inhoud (HTML, XML, JSON) 
terug te keren als antwoord (response) op een vraag (request).
Meestal zijn views geschreven in een template formaat 
zoals [Erb][] (embedded Ruby) of [Haml][].
Slimme developers proberen om zo weinig mogelijk code 
in hun views te zetten.

[Controllers][] zijn er om een binnenkomende request aan te nemen 
en een response hiervoor terug te keren.
Zij zijn verantwoordelijk voor de interpretatie van de binnenkomende request, 
het verkrijgen van instances van de nodige modellen, 
en het terug passeren van deze informatie  naar de View. 

In de standaard Merb application, 
is de code voor alle drie deze delen terug te vinden 
in folders met dezelfde naam onder de '``app``' directory.
In de volgende hoofdstukken, zien we hoe Merb elk van deze delen implementeert.  

Beginnende gebruikers zijn vaak geneigd te veel code toe te voegen in de controller laag, 
maar dit leidt tot broze en moeilijk te testen code. 
In plaats daarvan worden developers geadviseerd 
om hun controllers zo 'mager' mogelijk te maken 
door code die niet rechtstreeks betrekking hebben op de vraag/antwoord-cyclus 
(of het verzamelen van gegevens) naar het model te verhuizen.


<!-- Links -->
[CakePHP]:              http://www.cakephp.org/
[Controllers]:          /nl/getting-started/controllers
[Django]:               http://www.djangoproject.com/
[Erb]:                  http://en.wikipedia.org/wiki/ERuby
[Haml]:                 http://haml.hamptoncatlin.com/
[Modellen]:             /nl/getting-started/models
[Rails]:                http://rubyonrails.org
[Views]:                /nl/getting-started/views


