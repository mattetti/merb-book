#Modellen

In grote lijnen zijn modellen zijn de programmatorische vertegenwoordiging 
van de begrippen en gegevens die een applicatie gebruikt. 
In een blog applicatie, zijn dit zaken 
zoals berichten, reacties en gebruikers. 
In een winkel-front applicatie, 
zijn dit producten, klanten, shopping carts, verkoopsdata, enz. .. 
Merb werd ontworpen om ontwikkelaars zo veel mogelijk vrijheid te geven 
in de beschrijving van hun modellen. 
Modellen kunnen alles zijn wat een ontwikkelaar kan voorstellen d.m.v Ruby klassen.

Dit gezegd zijnde zullen de meerderheid van de applicaties
een vorm van [ORM][] (Object Relational Mapper) gebruiken
om data op disk te bewaren tussen de requests.
De meeste apps stockeren hun data onder de vorm van een database.
De standaard Merb Stack gebruikt DataMapper om te communiceren het een SQLite database.
Dit is een uitstekende keuze voor een eenvoudige ontwikkeling van nieuwe projecten.

Eens in productie echter,
is het doorgaans aanbevolen dat developers gebruik maken 
van een van de krachtiger database-engines zoals Postgres of MySQL.
Projecten die overkomen uit de Rails wereld
kunnen nog steeds van ActiveRecord modellen gebruik maken; Merb supporteert ook deze.

De rest van dit hoofdstuk is gericht op het gebruik van DataMapper
om Model klassen aan te maken.

## Attributen

## Associaties

## Callbacks


[ORM]: http://en.wikipedia.org/wiki/Object-relational_mapping