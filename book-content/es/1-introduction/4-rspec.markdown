# La plataforma de pruebas RSpec

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

**Sitio web de Referencia:**
<http://rspec.info>{: .reference}

## Introducción

[RSpec][] es una plataforma de Desarrollo Dirigido por Comportamiento (Behavior
Driven Development) para Ruby.
RSpec provee dos plataformas para escribir y ejecutar ejemplos de como tu
aplicación debe comportarse[^rspec]:

 * una Plataforma de Escenarios[^cucumber] para describir comportamiento a nivel
de aplicación
 * una Plataforma de Ejemplos de Código para describir comportamiento a nivel de
objetos

[RSpec][] fue influenciado by [Dan North][] y su plataforma de pruebas BDD en
Java llamada [JBehave][].

## Historia

Inicialmente BDD era solo una discusión entre [Aslak Hellesøy][] y [Dan North][]
en la oficina de [ThoughtWorks][] en Londres.
[Dave Astels][] se unió a la conversación con un post en su blog exponiendo que
él creía que estas ideas podrían ser facilmente implementadas en [Smalltalk][] o
[Ruby][].
[Steven Baker][] se unió con una implementación inicial, y liberó RSpec 0.1.
Más  tarde en 2006, el mantenimiento fue transferido a [David Chelimsky][].
[^rspec-history]


## Desarrollo Dirigido por Comportamiento (BDD)

Desarrollo Dirigido por Comportamiento (Behavior Driven Development) [^BDD] es
un proceso de desarrollo [Agil][] que contiene aspectos del Planeo dirigido por
Test de Aceptación ([Acceptance Test Driven Planning][]), Diseño Dirigido por
Dominios [Domain Driven Design][] y Desarrollo Dirigido por Pruebas
[Test Driven Development][].

> El Desarrollo Dirigido por Comportamiento es una metodología “de afuera hacia
> adentro” (“outside-in”).
> Comienza en el exterior identificando resultados de negocio, y entonces se
> enfoca en el conjunto de características que posibilitarán obtener estos
> resultados.
> Cada característica es capturada como una “historia”, que define el alcance de
> la característica junto a su criterios de aceptación.
> - [Dan North][]{: .quote-author}
{: cite=http://dannorth.net/whats-in-a-story}

Concentrandose en el comportamiento esperado más que en los detalles técnicos,
los desarrolladores pueden tener una mejor comunicación con el cliente y otros
inversores.

## Implementación

RSpec es un Lenguaje Específico de Dominio (Domain Specific Language) para
describir el comportamiento esperado de un sistema mediante ejemplos
ejecutables.

Aquí está un ejemplo muy simple de RSpec.

    describe "Lector" do
      it "debe tener un browser" do
        lector = Lector.new
        lector.browser.should_not be_nil
      end
    end
{:lang=ruby html_use_syntax=true}


[^rspec]:       [RSpec website](http://rspec.info)
[^cucumber]:    [Cucumber wiki](http://github.com/aslakhellesoy/cucumber/wikis)
[^BDD]:         [BDD by Dan North](http://dannorth.net/tags/agile/bdd)
[^rspec-history]:  [Nick Sieger: BDD with RSpec](http://blog.nicksieger.com/articles/2007/11/04/rubyconf-day-3-behaviour-driven-development-with-rspec)

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