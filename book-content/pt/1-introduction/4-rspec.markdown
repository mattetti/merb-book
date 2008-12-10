# Framework de testes RSpec

* Isto irá se tornar um índice (este texto será apagado).
{:toc}

**Referência:**
<http://rspec.info>{: .reference}

## Introdução

[RSpec][] é um framework de Behavior Driven Development para Ruby.
Ele possui dois frameworks par para escrever e executar exemplos de como suas aplicações Ruby
devem se comportar[^rspec]:

 * um framework de Scenario[^cucumber] para descrever comportamentos à nível de aplicação
 * um framework de Code Example para descrever comportamento à nível de objetos

[RSpec][] foi influenciado por [Dan North][] e seu framework de testes BDD chamado [JBehave][].

## History

Inicialmente, BDD era só uma discussão entre [Aslak Hellesøy][] e [Dan North][]
no escritório da [ThoughtWorks][] em Londres.
[Dave Astels][] se juntou à conversa com um post em seu blog declarando que ele achava
que estas ideias poderiam ser facilmente implementadas em [Smalltalk][] ou [Ruby][].
[Steven Baker][] apareceu com uma implementação inicial, e lançou o
RSpec 0.1. Depois, em 2006, a manutenção foi passada para [David Chelimsky][].[^rspec-history]


## Behavior Driven Development

Behavior Driven Development[^BDD] é um processo de desenvolvimento [Ágil][] que engloba
alguns aspectos de [Acceptance Test Driven Planning][], [Domain Driven Design][] e
[Test Driven Development][].

> Behaviour-driven development é uma metodologia “de fora para dentro”.
> Ela começa do lado de fora identificando os resultados das empresas, e em seguida, desce
> até as características que permitem alcançar estes resultados.
> Cada característica é capturada como uma “estória”, que define o escopo da característica
> juntamente com os seus critérios de aceitação.
> - [Dan North][]{: .quote-author}
{: cite=http://dannorth.net/whats-in-a-story}

Focando nos comportamentos esperados ao invés dos detalhes técnicos,
os desenvolvedores podem ter uma melhor comunicação com o líder do projeto e as outras partes interessadas.

## Implementação

O RSpec é uma Domain Specific Language para descrever o comportamente esperado
de um sistema com exemplos executáveis.

A seguir um exemplo bem simples do RSpec.

    describe "Reader" do
      it "should have a browser" do
        reader = Reader.new
        reader.browser.should_not be_nil
      end
    end
{:lang=ruby html_use_syntax=true}


[^rspec]:       [RSpec website](http://rspec.info)
[^cucumber]:    [Cucumber wiki](http://github.com/aslakhellesoy/cucumber/wikis)
[^BDD]:         [BDD by Dan North](http://dannorth.net/tags/agile/bdd)
[^rspec-history]:  [Nick Sieger: BDD with RSpec](http://blog.nicksieger.com/articles/2007/11/04/rubyconf-day-3-behaviour-driven-development-with-rspec)

[Acceptance Test Driven Planning]: http://testing.thoughtworks.com/node/89
[Ágil]: http://en.wikipedia.org/wiki/Agile_software_development
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