# RSpec okvir za testiranje

* This will become a table of contents (this text will be scraped).
{:toc}

**Referenca:** <http://rspec.info>{: .reference}

## Uvod

[RSpec][] je okvir za Behavior Driven Development (Razvoj vođen ponašanjem) za
Ruby.
On pruža dva okvira za pisanje i izvršavanje primjera ponašanja vaše Ruby
aplikacije[^rspec]:

 * okvir za pisanje scenarija[^cucumber] koji služi za opisivanje ponašanja na
   nivou aplikacije;
 * okvir za primjere kôda koji služi za opisivanje ponašanja na nivou objekata.

Na [RSpec][] je uticao [Dan North][DanNorth] i njegov Java-bazirani okvir za
BDD testiranje po imenu [JBehave][].

## Historija

Inicijalno, BDD je bila samo diskusija između [Aslak Hellesøya][] i
[Dan Northa][DanNorth] u londonskim kancelarijama [ThoughtWorksa][].
[Dave Astels][] se uključio u konverzaciju sa blog postom u kojem je naveo kako
misli da bi se ove ideje mogle jednostavno implementirati u [Smalltalku][] ili
[Rubyju][].
[Steven Baker][] je uskočio sa prvom implementacijom i izdao RSpec 0.1.
Razvoj je kasnije u 2006. godini bio prepušten
[David Chelimskyju][].[^rspec-history]

## Razvoj vođen ponašanjem

Razvoj vođen ponašanjem[^BDD] je [agilni][] razvojni proces koji uključuje
aspekte [Planiranja vođenog testom prihvatanja][] (Acceptance Test Driven
Planning), [Dizajna vođenog domenom][] (Domain Driven Design) i
[Razvoja vođenog testiranjem][] (Test Driven Development).

> Razvoj vođen ponašanjem je "outside-in" ("*s vana-u*" op.prev.) metodologija.
> On počinje s vana, identifikacijom poslovnih ishoda, a onda ulazi dublje
> u skup funkcionalnosti koje će omogućiti te ishode.
> Svaka funkcionalnost je obuhvaćena u jednu "priču" koja definira oblast
> funkcionalnosti uz njen kriterij privatljivosti.
> - [Dan North][DanNorth]{: .quote-author}
{: cite=http://dannorth.net/whats-in-a-story}

Fokusiranjem na očekivana ponašanja umjesto na tehničke detalje, programeri
mogu ostvariti bolju komunikaciju sa vlasnikom projekta i drugim ključnim
licima.

## Implementacija

RSpec je Jezik specifične domene (Domain Specific Language) za opisivanje
očekivanog ponašanja sistema sa primjerima koje je moguće izvršiti.

Slijedi jedan jako jednostavan RSpec primjer.

    describe "Čitač" do
      it "treba imati browser" do
        reader = Reader.new
        reader.browser.should_not be_nil
      end
    end
{:lang=ruby html_use_syntax=true}


[^rspec]:       [RSpec web stranica](http://rspec.info)
[^cucumber]:    [Cucumber wiki](http://github.com/aslakhellesoy/cucumber/wikis)
[^BDD]:         [Dan Northonov BDD](http://dannorth.net/tags/agile/bdd)
[^rspec-history]:  [Nick Sieger: BDD sa RSpecom](http://blog.nicksieger.com/articles/2007/11/04/rubyconf-day-3-behaviour-driven-development-with-rspec)

[agilni]:               http://en.wikipedia.org/wiki/Agile_software_development
[Aslak Hellesøya]:      http://blog.aslakhellesoy.com/
[DanNorth]:             http://dannorth.net
[Dave Astels]:          http://blog.daveastels.com/
[David Chelimskyju]:    http://blog.davidchelimsky.net
[Dizajna vođenog domenom]: http://domaindrivendesign.org/
[JBehave]:              http://jbehave.org/
[Planiranja vođenog testom prihvatanja]: http://testing.thoughtworks.com/node/89
[razvoja vođenog testiranjem]: http://en.wikipedia.org/wiki/Test-driven_development
[RSpec]:                http://rspec.info
[Rubyju]:               http://ruby-lang.org
[Smalltalku]:           http://www.smalltalk.org
[Steven Baker]:         http://blog.lavalamp.ca
[ThoughtWorksa]:        http://www.thoughtworks.com/

*[BDD]: Behavior Driven Development
