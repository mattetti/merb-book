# Framework de test RSpec

* This will become a table of contents (this text will be scraped).
{:toc}

**Site source:**
<http://rspec.info>{: .reference}

## Introduction

RSpec est un framework de Behavior Driven Development pour Ruby.
Il fournit 2 frameworks pour l'écriture et l'exécution d'exemples
sur la façon dont votre application Ruby doit se comporter[^rspec]:

 * Un framework de Scénario[^cucumber] pour décrire le comportement au niveau applicatif
 * Un framework d'exemple de code pour décrire le comportement au niveau objet

[RSpec][] a été influencé par [Dan North][] et son framework de test BDD en java appelé [JBehave][].

## Histoire

A l'origine, BDD n'était qu'une discussion entre [Aslak Hellesøy][] et [Dan North][]
dans les bureaux londoniens de [ThoughtWorks][].
[Dave Astels][] s'est joint à la conversation avec un article dans son blog disant qu'il pensait
que ces idées pouvaient être facilement implémentées en [Smalltalk][] ou [Ruby][].
[Steven Baker][] a expérimenté une première implémentation, et a sorti
RSpec 0.1. Plus tard en 2006, la maintenance a été donnée à [David Chelimsky][].[^rspec-history]


## Behavior Driven Development

Behavior Driven Development[^BDD] est un processus de développement [Agile][] qui comprend
des aspects de [Acceptance Test Driven Planning][], [Domain Driven Design][] et
[Test Driven Development][].

> Le développement comportemental est une méthodologie "extérieur-intérieur".
> Cela commence à l'extérieur en identifiant les résultats d'affaires, puis en naviguant
> jusqu'aux fonctionnalités qui amèneront ces résultats.
> Chaque fonctionnalité est enregistrée comme une "histoire", qui défini la portée
> de la fonctionnalité avec ses critères de validation.
> - [Dan North][]{: .quote-author}
{: cite=http://dannorth.net/whats-in-a-story}

En se concentrant sur les comportements attendus plutôt que sur les détails techniques,
les développeurs peuvent avoir une meilleure communication avec le chef de projet et les autres parties prenantes.

## Implémentation

RSpec est un langage dédié (Domain Specific Language) pour décrire les comportements attendus
d'un système avec des exemples exécutables.

Voici un exemple très simple de RSpec.

    describe "Lecteur" do
      it "devrait avoir un navigateur" do
        lecteur = Lecteur.new
        lecteur.navigateur.should_not be_nil
      end
    end
{:lang=ruby html_use_syntax=true}


<!-- References -->
[^rspec]:       [site de RSpec](http://rspec.info)
[^cucumber]:    [wiki Cucumber](http://github.com/aslakhellesoy/cucumber/wikis)
[^BDD]:         [BDD par Dan North](http://dannorth.net/tags/agile/bdd)
[^rspec-history]:  [Nick Sieger: BDD avec RSpec](http://blog.nicksieger.com/articles/2007/11/04/rubyconf-day-3-behaviour-driven-development-with-rspec)

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
