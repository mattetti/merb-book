# La plataforma de pruebas RSpec

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

**Sitio web de Referencia:**
<http://rspec.info>{: .reference}

## Introducción

[RSpec][] es una plataforma de Desarrollo Dirigido por Comportamiento[^BDD] para Ruby.
Esta provee, a su vez, dos plataformas para escribir y ejecutar ejemplos
de como su aplicación Ruby debería comportarse[^rspec]:

 * una plataforma de Escenarios[^cucumber] para describir comportamientos a nivel de aplicación 
 * una plataforma de Ejemplos de Codigo para describir comportamientos a nivel de objeto.

[RSpec][] fue influenciado por [Dan North][]
y su plataforma de pruebas DDC llamada [JBehave][] para el lenguaje [Java][].

## Historia

Inicialmente, el Desarrollo Dirigido por Comportamiento nació de una conversación entre 
[Aslak Hellesøy][] y [Dan North][] que tuvo lugar en la oficina londinense de [ThoughtWorks][].
[Dave Astels][] se unió a la conversación publicando un articulo en su blog,
sugiriendo que estas ideas podrían ser fácilmente implementadas 
en [Smalltalk][] o [Ruby][].
[Steven Baker][] fue quien realizo la primera implementación, 
conocida como RSpec 0.1.
A fines del 2006,
[David Chelimsky][] fue nombrado responsable del mantenimiento de [RSpec][].[^rspec-history]

## Desarrollo Dirigido por Comportamiento

Desarrollo Dirigido por Comportamiento es un proceso de desarrollo [Agil][]
que incorpora aspectos de la [Planificación Dirigida por Pruebas de Aceptación][],
el [Diseño Dirigido por Dominios][], y el [Desarrollo Dirigido por Pruebas][].

> El Desarrollo Dirigido por Comportamiento es una metodología "de afuera hacia adentro".
> Este comienza en el exterior identificando los resultados de negocios, 
> y luego se enfoca hacia la característica que se encargara de generar esos resultados.
> Cada característica es capturada como una "historia",
> la cual define el alcance de la misma junto con su criterio de aceptación.
> - [Dan North][]{: .quote-author}
{: cite=http://dannorth.net/whats-in-a-story}

Al enfocarse en los comportamientos esperados y no en los detalles técnicos,
los programadores pueden entablar una mejor comunicación 
con el dueño del proyecto y otras personas involucradas en el mismo.

## Implementación

RSpec es un [Lenguaje Especifico del Dominio][] 
que describe el comportamiento esperado de un sistema,
usando una colección de ejemplos ejecutables.

Aquí se le presenta un ejemplo simple de RSpec.

    describe "Lector" do
      it "deberia tener un navegador web." do
        lector = Lector.new
        lector.navegador_web.should_not be_nil
      end
    end
{:lang=ruby html_use_syntax=true}


<!-- References -->
[^rspec]: [sitio web de RSpec](http://rspec.info)
[^cucumber]: [Cucumber wiki](http://github.com/aslakhellesoy/cucumber/wikis)
[^BDD]: [Desarrollo Dirigido por Comportamiento por Dan North](http://dannorth.net/tags/agile/bdd)
[^rspec-history]: [Desarrollo Dirigido por Comportamiento con RSpec por Nick Sieger](http://blog.nicksieger.com/articles/2007/11/04/rubyconf-day-3-behaviour-driven-development-with-rspec)

<!-- Links -->
[Planificación Dirigida por Pruebas de Aceptación]: http://testing.thoughtworks.com/node/89
[Agil]: http://en.wikipedia.org/wiki/Agile_software_development
[Aslak Hellesøy]: http://blog.aslakhellesoy.com/
[Dan North]: http://dannorth.net
[Dave Astels]: http://blog.daveastels.com/
[David Chelimsky]: http://blog.davidchelimsky.net
[Diseño Dirigido por Dominios]: http://domaindrivendesign.org/
[Lenguaje Especifico del Dominio]: http://en.wikipedia.org/wiki/Domain_Specific_Language
[Java]: http://en.wikipedia.org/wiki/Java_(programming_language)
[JBehave]: http://jbehave.org/
[RSpec]: http://rspec.info
[Ruby]: http://ruby-lang.org
[Smalltalk]: http://www.smalltalk.org
[Steven Baker]: http://blog.lavalamp.ca
[Desarrollo Dirigido por Pruebas]: http://en.wikipedia.org/wiki/Test-driven_development
[ThoughtWorks]: http://www.thoughtworks.com/

<!-- Abbreviations -->
*[BDD]: Behavior Driven Development
*[DSL]: Domain Specific Language
*[TDD]: Test Driven Development
