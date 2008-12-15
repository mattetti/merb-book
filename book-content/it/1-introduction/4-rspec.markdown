# Il framework di testing RSpec

* This will become a table of contents (this text will be scraped).
{:toc}

**Sito web di riferimento:**
<http://rspec.info>{: .reference}

## Introduzione

[RSpec][] è un framework per il Behavior Driven Development[^BDD] (BDD) in Ruby
(sviluppo basato sul "comportamento" del sistema, NdT).
Esso mette a disposizione due framework per scrivere ed eseguire esempi
su come la vostra applicazione Ruby si dovrebbe comportare[^rspec]:

 * un framework per gli Scenari[^cucumber], per descrivere il comportamento
   a livello dell'applicazione
 * un framework per gli esempi di codice, per descrivere il comportamento
   a livello di oggetti

[RSpec][] è stato influenzato da [Dan North][]
ed il suo framework su Java per il BDD chiamato [JBehave][].

## Storia

Inizialmente il BDD emerse da una discussione tra [Aslak Hellesøy][]
e [Dan North][] nell'ufficio londinese della [ThoughtWorks][].
[Dave Astels][] si unì alla conversazione con un post,
suggerendo che tali idee potevano essere facilmente implementate
in [Smalltalk][] oppure in [Ruby][].
[Steven Baker][] entrò in scena con una implementazione iniziale,
rilasciata come RSpec 0.1.
Più tardi, nel 2006,
la gestione passò a [David Chelimsky][].[^rspec-history]

## Behavior Driven Development

Il BDD è un processo di sviluppo [agile][]
che include gli aspetti dell'[Acceptance Test Driven Planning][],
del [Domain Driven Design][] e del [Test Driven Development][].

> Il BDD è una metodologia "rovesciata".
> Essa parte dall'esterno identificando i risultati del problema,
> quindi discende all'interno delle funzionalità che porteranno a tali risultati.
> Ogni funzionalità viene raccolta come una "story",
> la quale definisce la portata (scope) della funzionalità stessa
> insieme ad i suoi criteri di accettazione.
> - [Dan North][]{: .quote-author}
{: cite=http://dannorth.net/whats-in-a-story}

Concentrandosi sugli aspetti del "comportamento" piuttosto che sui dettagli tecnici,
gli sviluppatori posso ottenere una migliore comunicazione
con il responsabile del progetto e con tutti gli altri stakeholder.

## Implementazione

RSpec è un [Domain-Specific Language][] (DSL)
per descrivere il comportamento atteso di un sistema
attraverso un insieme di esempi eseguibili.

Ecco un semplice esempio in RSpec:

    describe "Reader" do
      it "should have a browser" do
        reader = Reader.new
        reader.browser.should_not be_nil
      end
    end
{:lang=ruby html_use_syntax=true}


<!-- References -->
[^rspec]:       [RSpec website](http://rspec.info)
[^cucumber]:    [Cucumber wiki](http://github.com/aslakhellesoy/cucumber/wikis)
[^BDD]:         [BDD by Dan North](http://dannorth.net/tags/agile/bdd)
[^rspec-history]:  [Nick Sieger: BDD with RSpec](http://blog.nicksieger.com/articles/2007/11/04/rubyconf-day-3-behaviour-driven-development-with-rspec)

<!-- Links -->
[Acceptance Test Driven Planning]: http://testing.thoughtworks.com/node/89
[agile]:                http://en.wikipedia.org/wiki/Agile_software_development
[Aslak Hellesøy]:       http://blog.aslakhellesoy.com/
[Dan North]:            http://dannorth.net
[Dave Astels]:          http://blog.daveastels.com/
[David Chelimsky]:      http://blog.davidchelimsky.net
[Domain Driven Design]: http://domaindrivendesign.org/
[Domain-Specific Language]: http://en.wikipedia.org/wiki/Domain_Specific_Language
[JBehave]:              http://jbehave.org/
[RSpec]:                http://rspec.info
[Ruby]:                 http://ruby-lang.org
[Smalltalk]:            http://www.smalltalk.org
[Steven Baker]:         http://blog.lavalamp.ca
[Test Driven Development]: http://en.wikipedia.org/wiki/Test-driven_development
[ThoughtWorks]:         http://www.thoughtworks.com/

<!-- Abbreviations -->
*[BDD]: Behavior Driven Development
*[DSL]: Domain Specific Language
*[TDD]: Test Driven Development


