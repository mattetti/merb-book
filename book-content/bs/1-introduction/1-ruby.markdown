# Ruby programski jezik

* This will become a table of contents (this text will be scraped).
{:toc}

![Ruby](/images/ruby-header.gif){: .no-border}

**Referenca:** <http://ruby-lang.org>{: .reference}

> Pisanje kôda u Rubyju me čini sretnim jer je to jedan od najbržih puteva
> između mog uma i kompjutera.
> Mogu zamisliti nešto i odmah to koncizno i elegantno izraziti u
> Rubyju, bez svih suvšnih zavrzlama koje vam trebaju u većini jezika.
> -
> [Dave Thomas, autor knjige "Programming Ruby"][dt]{: .quote-author}
{: cite=http://www.infoq.com/interviews/ruby-rails-dave-thomas .lead-quote}

Bio bi zločin početi pričati o Merb okviru bez da prethodno diskutujemo o samom
razlogu Merbove fleksibilnosti, moći i brzine: **Rubyju**.

## Porijeklo ##{: #origin}
![Yukihiro Matsumoto](/images/Yukihiro_Matsumoto.jpg){: .left}
Ruby je dinamični, refleksivni, objektno orijentisani programski jezik opšte
namjene i otvorenog izvora napisan sredinom 1990-ih godina.
Potpisuje ga japanski softverski arhitekt
[Yukihiro "Matz" Matsumoto-san (まつもとゆきひろ)][matz].

Ruby se fokusira na jednostavnost i produktivnost. Odlikuje ga elegantna
sintaksa koja je prirodna za čitanje i pisanje.

Matz je posudio ideje i idiome iz nekih od njegovih omiljenih programskih
jezika (Perl, Smalltalk, Eiffel, Ada i List) kako bi formirao novi jezik koji
balansira funkcionalno i imperativno programiranje.

Rezultat je atraktivan jezik koji ima jako prirodan osjećaj.
U Ruby zajednici se često spominje POLS, Principle of Least Surprise (Princip
najmanjeg iznenađenja).
Koncept iza ovoga je jako jednostavan: ako znate minimum Rubyja, ne biste
trebali biti iznenađeni reakcijom jezika.

## Usvajanje ##{: #adoption}
Po [TIOBE indeksu][tiobe], Ruby je rangiran među prvih deset programskih jezika
širom svijeta.
Većina ovog rasta se pripisuje popularnosti softvera napisanog u Rubyju, a
posebno [Ruby on Rails web okviru][rails].

## Ključni elementi jezika ##{: #key-elements}

> Želio sam skriptni jezik koji je bio moćniji od Perla, a više
> objektno-orijentisan od Pythona.
> - Matz
{: cite=http://www.linuxdevcenter.com/pub/a/linux/2001/11/29/ruby.html}

* Sve je objekat
* Sve može biti prošireno/izmijenjeno
* Visok nivo čitljivosti kôda

Kako biste naučili više o samom Ruby jeziku, provjerite
[oficijelnu web stranicu Ruby jezika][rubylang-about].

## Primjeri programskog kôda ##{: #code-examples}

**Ispisati string "Zdravo, svijete!" deset puta:**

    10.times do
      print "Zdravo, svijete!"
    end
    # => "Zdravo, svijete!Zdravo, svijete!Zdravo, svijete!Zdravo, svijete!Zdravo, svijete!
    Zdravo, svijete!Zdravo, svijete!Zdravo, svijete!Zdravo, svijete!Zdravo, svijete!"
{:lang=ruby html_use_syntax=true}

**Uslovni iskazi:**

    access_allowed = true if DateTime.now > DateTime.parse("2008-12-01")
{:lang=ruby html_use_syntax=true}

**Ternarni operator:**

    age_classification = age > 18 ? "odrasla osoba" : "dijete"
{:lang=ruby html_use_syntax=true}

je isto što i:

    if age > 18
      age_classification =  "odrasla osoba"
    else
      age_classification = "dijete"
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
> - [Matz, autor Ruby programskog jezika][rubylang]{: .quote-author}
{: cite=http://merbist.com/2008/11/09/merb-1-0-released/}

[dt]: http://pragdave.pragprog.com/
[matz]: http://en.wikipedia.org/wiki/Yukihiro_Matsumoto
[tiobe]: http://www.tiobe.com/index.php/content/paperinfo/tpci/index.html
[rails]: http://rubyonrails.org
[rubylang-about]: http://www.ruby-lang.org/en/about
[rubylang]: http://ruby-lang.org/
