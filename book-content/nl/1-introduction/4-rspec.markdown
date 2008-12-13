# RSpec test framework

* This will become a table of contents (this text will be scraped).
{:toc}

**Referentie website:**
<http://rspec.info>{: .reference}

## Introductie

[RSpec][] is een Behavior Driven Development framework voor Ruby.
It voorziet twee frameworks voor het schrijven en uitvoeren van voorbeelden van hoe je Ruby 
applicatie zich zou moeten gedragen[^rspec]:

 * een scenario framework[^cucumber] voor het beschrijven van behavior op  applicatie niveau
 * a code voorbeeld framework voor het beschrijven van behavior op object niveau
 
[RSpec][] werd beïnvloed door [Dan North][] en zijn Java-based BDD test framework [JBehave][].

## Historiek

Aanvankelijk was BDD gewoon een discussie tussen [Aslak Hellesøy][] and [Dan North][]
in het ThoughtWorks kantoor in Londen . 
[Dave Astels][] voegde zich bij in het gesprek met een blogpost waarin hij stelde dat hij dacht 
dat deze ideeën gemakkelijk konden worden geïmplementeerd in [Smalltalk][] of [Ruby][]. 
[Steven Baker][] sprong bij met een eerste uitvoering, en bracht 
RSpec 0.1 uit. Later in 2006, werd het onderhoud doorgegeven aan [David Chelimsky][].[^rspec-history]


## Behavior Driven Development 

Behavior Driven Development[^BDD] is een [Agile][] development proces dat bestaat uit 
aspecten van de [Acceptance Test Driven Planning][], [Domain Driven Design][] en
[Test Driven Development][].

> Behaviour-driven development is een “van-buiten-naar-binnen” methodologie.
> Het start van buiten door identificatie van business resultaten, en verdiept zich vervolgens in de functie set die worden bereikt door deze resultaten.
> Elke functie wordt vastgelegd als een "verhaal", waarin zowel de reikwijdte (scope) van de functie als acceptatie criteria worden beschreven.
> - [Dan North][]{: .quote-author}
{: cite=http://dannorth.net/whats-in-a-story}

Door zich te concentreren op het te verwachten gedrag in plaats van de technische details, 
krijgen developers een betere communicatie met de project eigenaar en andere belanghebbenden.

## Implementatie

RSpec is een Domain Specific Language voor de beschrijving van het te verwachten gedrag 
van een systeem met uitvoerbare voorbeelden.

Hier is een heel eenvoudig RSpec voorbeeld.

    describe "Reader" do
      it "should have a browser" do
        reader = Reader.new
        reader.browser.should_not be_nil
      end
    end
{:lang=ruby html_use_syntax=true}


[^rspec]:       [RSpec website](http://rspec.info)
[^cucumber]:    [Cucumber wiki](http://github.com/aslakhellesoy/cucumber/wikis)
[^BDD]:         [BDD door Dan North](http://dannorth.net/tags/agile/bdd)
[^rspec-history]:  [Nick Sieger: BDD met RSpec](http://blog.nicksieger.com/articles/2007/11/04/rubyconf-day-3-behaviour-driven-development-with-rspec)

[Acceptance Test Driven Planning]: http://testing.thoughtworks.com/node/89
[Agile]: http://en.wikipedia.org/wiki/Agile_software_development
[Aslak Hellesøy]: http://blog.aslakhellesoy.com/
[Dan North]: http://dannorth.net
[Dave Astels]: http://blog.daveastels.com/
[David Chelimsky]: http://blog.davidchelimsky.net
[Domain Driven Design]: http://domaindrivendesign.org/
[JBehave]: http://jbehave.org/
[RSpec]: http://rspec.info
[Ruby]: http://ruby-lang.org
[Smalltalk]: http://www.smalltalk.org
[Steven Baker]: http://blog.lavalamp.ca
[Test Driven Development]: http://en.wikipedia.org/wiki/Test-driven_development
[ThoughtWorks]: http://www.thoughtworks.com/

*[TDD]: Test Driven Development
*[BDD]: Behavior Driven Development