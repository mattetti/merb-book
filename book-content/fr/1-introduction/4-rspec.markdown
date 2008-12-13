# Framework de test RSpec

* This will become a table of contents (this text will be scraped).
{:toc}

**Site source:**
<http://rspec.info>{: .reference}

## Introduction

RSpec est un framwork de Développement Comportemental (Behavior Driven Development, BDD) pour Ruby.
Il fournit 2 frameworks pour l'écriture et l'exécution d'exemples
sur la façon que votre application Ruby 

 * Un framework de Scenario[^cucumber] pour décrire le comportement au niveau applicatif
 * Un framework d'exemple de code pour décrire le comportemment au niveau objet

[RSpec][] a été influencé par [Dan North][] et son framework de test BDD en java appelé [JBehave][].

## Histoire

A l'origine, BDD n'était qu'une discussion entre [Aslak Hellesøy][] et [Dan North][]
dans les bureaux londoniens de [ThoughtWorks][].
[Dave Astels][] s'est joint à la conversation avec un article dans son blog disant qu'il pensait
que ces idées pouvaient être facilement implentées en [Smalltalk][] ou [Ruby][].
[Steven Baker][] a expérimenté une implémentation initiales, a sorti
RSpec 0.1. Plus tard en 2006, la maintenance a été donnée à [David Chelimsky][].[^rspec-history]


## Behavior Driven Development

Behavior Driven Development[^BDD] is an [Agile][] development process that comprises
aspects of [Acceptance Test Driven Planning][], [Domain Driven Design][] and
[Test Driven Development][].

> Behaviour-driven development is an “outside-in” methodology.
> It starts at the outside by identifying business outcomes, and then drills down
> into the feature set that will achieve those outcomes.
> Each feature is captured as a “story”, which defines the scope of the feature
> along with its acceptance criteria.
> - [Dan North][]{: .quote-author}
{: cite=http://dannorth.net/whats-in-a-story}

By focusing on the expected behaviors rather than the technical details,
developers can have better communication with the project owner and other stakeholders.

## Implementation

RSpec is a Domain Specific Language for describing the expected behavior
of a system with executable examples.

Here is a very simple RSpec example.

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

<!-- Abbreviations -->
*[TDD]: Test Driven Development
*[BDD]: Behavior Driven Development