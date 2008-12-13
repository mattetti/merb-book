# Ruby programski jezik

![Ruby](/images/ruby-header.gif){: .no-border}

**Referenca:** <http://ruby-lang.org>{: .reference}

* This will become a table of contents (this text will be scraped).
{:toc}

> Pisanje kôda u Rubyju me čini sretnim jer je to jedan od najbržih puteva
> između mog uma i kompjutera.
> Mogu zamisliti nešto i odmah to koncizno i elegantno izraziti u
> Rubyju, bez svih suvšnih zavrzlama koje vam trebaju u većini jezika.
> - [Dave Thomas][]{: .quote-author}, autor knjige [Programming Ruby][]
{: cite=http://www.infoq.com/interviews/ruby-rails-dave-thomas .lead-quote}

Bio bi zločin početi pričati o Merb okviru bez da prethodno diskutujemo o samom
razlogu Merbove fleksibilnosti, moći i brzine: **Rubyju**.

## Porijeklo ##{: #origin}
![Yukihiro Matsumoto](/images/Yukihiro_Matsumoto.jpg){: .left}
Ruby je [dinamični][], [refleksivni][], [objektno orijentisani][]
[programski jezik][] opšte namjene i [otvorenog izvora][] napisan sredinom
1990-ih godina.
Potpisuje ga japanski [softverski arhitekt][]
[Yukihiro "Matz" Matsumoto-san (まつもとゆきひろ)][].

Ruby se fokusira na jednostavnost i produktivnost. Odlikuje ga elegantna
sintaksa koja je prirodna za čitanje i pisanje.

Matz je posudio ideje i idiome iz nekih od njegovih omiljenih programskih
jezika ([Perl][], [Smalltalk][], [Eiffel][], [Ada][] i [Lisp][]) kako bi
formirao novi jezik koji balansira [funkcionalno][] i
[imperativno programiranje][].

Rezultat je atraktivan jezik, korištenje kojeg, daje jako prirodan osjećaj.
U Ruby zajednici često spominjemo POLS, Principle of Least Surprise (Princip
najmanjeg iznenađenja).
Koncept ovoga je jako jednostavan: ako znate minimum Rubyja, ne biste trebali
biti iznenađeni reakcijom jezika.

## Usvajanje ##{: #adoption}
Po [TIOBE indeksu][], Ruby je rangiran među prvih deset najkorištenijih
programskih jezika širom svijeta.
Većina ovog rasta se pripisuje popularnosti softvera napisanog u Rubyju, a
posebno [Ruby on Rails web okviru][].

## Ključni elementi jezika ##{: #key-elements}

> Želio sam skriptni jezik koji je bio moćniji od Perla, a više
> objektno-orijentisan od Pythona.
> - Matz
{: cite=http://www.linuxdevcenter.com/pub/a/linux/2001/11/29/ruby.html}

* Sve je objekat
* Sve može biti prošireno/izmijenjeno
* Visok nivo čitljivosti kôda

Kako biste naučili više o samom Ruby jeziku, provjerite
[oficijelnu web stranicu Ruby jezika][].

## Primjeri programskog kôda ##{: #code-examples}

**Ispisati string "Zdravo, svijete!" deset puta:**

    5.times do
      print "Zdravo, svijete!"
    end
    # => "Zdravo, svijete!Zdravo, svijete!Zdravo, svijete!Zdravo, svijete!Zdravo, svijete!"
{:lang=ruby html_use_syntax=true}

**Uslovni iskazi:**

    access_allowed = true if DateTime.now > DateTime.parse("2008-12-01")
{:lang=ruby html_use_syntax=true}

**Ternarni operator:**

    age_classification = age > 12 ? "odrasli" : "djeca"
{:lang=ruby html_use_syntax=true}

je isto što i:

    if age > 12
      age_classification =  "odrasli"
    else
      age_classification = "djeca"
    end
{:lang=ruby html_use_syntax=true}

**Nizovi:**

    drinks = ["Coca Cola", "Pepsi", "Orangina", "Cockta"]
    # => ["Coca Cola", "Pepsi", "Orangina", "Cockta"]
    # Pristup elementima niza
    drinks[0] # => "Coca Cola"
    drinks.first # => "Coca Cola"
    drinks.last # => "Cockta"
    drinks[3] # => "Cockta"
    drinks[drinks.length - 1] # => "Cockta"
{:lang=ruby html_use_syntax=true}


**Provjera da li element postoji u nizu:**

    haystack = ["Mac", "NT", "Irix", "Linux"]
    needle = "Windows"
    haystack.include?(needle)  # => false
{:lang=ruby html_use_syntax=true}

**Dodavanje elementa na kraj niza:**

    haystack = ["Mac", "NT", "Irix", "Linux"]
    needle = "Windows"
    haystack.push(needle)
    # Ili isto uradite ovako:
    haystack << needle
{:lang=ruby html_use_syntax=true}

**Definisanje metode:**

    def greet_visitor(visitor_name)
      "Ćao #{visitor_name}!"
    end
{:lang=ruby html_use_syntax=true}

## Merb i Ruby ##{: #merb-and-ruby}

Merb pokušava ostati koliko je to moguće blizu samom Ruby jeziku.
Zbog toga je jako važno razumjeti šta je to što ljudi zovu "Ruby način".

Tokom konferencije RubyConf 2008, Matz je dao sljedeći komentar o Merbu:

> Merb ima svijetlu budućnost za ljude koji nisu zadovoljni fiksiranim putem
> Railsa.
> Mislim da će Merb dati korisnicima više slobode u Rubyjevskom načinu
> programiranja
> - [Matz][]{: .quote-author}, autor [Ruby programskog jezika][]
{: cite=http://merbist.com/2008/11/09/merb-1-0-released/}

[Ada]:                  http://en.wikipedia.org/wiki/Ada_%28programming_language%29)
[Dave Thomas]:          http://pragdave.pragprog.com/
[dinamični]:            http://en.wikipedia.org/wiki/Dynamic
[Eiffel]:               http://en.wikipedia.org/wiki/Eiffel_%28programming_language%29
[funkcionalno]:         http://bs.wikipedia.org/wiki/Funkcionalno_programiranje
[imperativno programiranje]: http://bs.wikipedia.org/wiki/Imperativno_programiranje
[Lisp]:                 http://bs.wikipedia.org/wiki/Lisp_programski_jezik
[Matz]:                 http://en.wikipedia.org/wiki/Yukihiro_Matsumoto
[objektno orijentisani]: hhttp://bs.wikipedia.org/wiki/Objektno_orijentisano_programiranje
[oficijelnu web stranicu Ruby jezika]: http://www.ruby-lang.org/en/about
[otvorenog izvora]:     http://bs.wikipedia.org/wiki/Otvoreni_softver
[Perl]:                 http://bs.wikipedia.org/wiki/Perl
[Programming Ruby]:     http://pragprog.com/titles/ruby/programming-ruby
[programski jezik]:     http://bs.wikipedia.org/wiki/Programski_jezik
[refleksivni]:          http://en.wikipedia.org/wiki/Reflection_%28computer_science%29
[Ruby on Rails web okviru]: http://rubyonrails.org
[Ruby programskog jezika]:  http://ruby-lang.org/
[Smalltalk]:            http://en.wikipedia.org/wiki/Smalltalk
[softverski arhitekt]:  http://en.wikipedia.org/wiki/Software_architect
[TIOBE indeksu]:        http://www.tiobe.com/index.php/content/paperinfo/tpci/index.html
[Yukihiro "Matz" Matsumoto-san (まつもとゆきひろ)]: http://en.wikipedia.org/wiki/Yukihiro_Matsumoto
