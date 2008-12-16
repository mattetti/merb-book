# Generisanje aplikacije

* This will become a table of contents (this text will be scraped).
{:toc}

Merb dolazi sa skriptom ``merb-gen`` koja generiše osnovni skelet aplikacije.
Generator može jako brzo pripremiti različite tipove Merb aplikacija. Kako
biste vidjeli sve dostupne opcije, unesite sljedeću naredbu vaš terminal:

    $ merb-gen -H
{:lang=shell html_use_syntax=true}

Zasad se fokusirajmo na to kakve tipove Merb aplikacija možemo generisati.

## Tipovi
Merb može biti korišten u više svrha: od jako malih i brzih aplikacija
sadržanih u jednom fajlu do kompleksnih web servisa.
U skladu s vašim potrebama, možete generisati aplikaciju jednog od nekoliko
ponuđenih tipova: ``app``, ``core``, ``flat`` i ``very_flat``.

### App
Opcija generatora ``app`` generiše aplikaciju baziranu na dogmatičnom Merb
stacku.
Ovako kreirana kreirana aplikacija sadrži poptunu strukturu direktorija
i sve konfiguracijske fajlove.
U ovom slučaju se, također, dodaje i fajl ``config/dependencis.rb`` koji
uključuje sve biblioteke iz gema ``merb-more`` i ``DataMapper``.

    $ merb-gen app moja-aplikacija
{:lang=shell html_use_syntax=true}

Kostur generisana prethodnom naredbom sadrži sve što je neophodno za kreiranje
prvoklasne web aplikacije.
Možete primjetiti da je osnovna generisana struktura jako slična strukturi
tipičnog Rails projekta.
Veći dio ove knjige će podrazumijevati da ste počeli upravo na ovaj način.

Pokrenite aplikaciju izvršavanjem naredbe ``merb`` u vašem terminalu dok
se nalazite u njenom korijenskom direktoriju.
Ova će naredba startati Merb i, po standardnim postavkama, vezati proces na
port 4000.
Kako biste vidjeli novokreiranu aplikaciju, otvorite u vašem browseru
[http://localhost:4000/][localhost].

### Core
Kao što je slučaj i sa aplikacijame generisanim naredbom ``app``, ``core``
opcija će generisati aplikaciju sa svim standardnim direktorijima i
konfiguracijskim fajlovima.
Razliku je u tome da dependency biblioteke neće biti automatski dodate.

    $ merb-gen core moja-aplikacija
{:lang=shell html_use_syntax=true}

Kako biste pokrenuli aplikaciju, kao i ranije izvršite naredbu ``merb`` u
terminalu unutar korijenskog direktorija aplikacije.
Primjetite da, za razliku od ostale tri vrste generisanih aplikacija, core
aplikacija nema standardnog sadržaja.
Otvaranje adrese [http://localhost:4000/][localhost] će proizvoditi grešku sve
dok se ne doda sadržaj i ne podesi rutiranje.

### Flat
"Pljosnate" aplikacije čuvaju svu svoju logiku u jednom fjalu, ali imaju
posebne fajlove za konfiguraciju i poseban direktorij za predloške
prezentacije.

    $ merb-gen flat moja-aplikacija
{:lang=shell html_use_syntax=true}

Aplikacije ovog tipa se pokreću kao i sve ostale Merb aplikacije: izvršavanjem
naredbe ``merb``.
Po generisanim postavkama, sve metode klase ``MojaAplikacija`` će biti
tretirane kao akcije kontrolera ``moja-aplikacija``.
Naprimjer,
[http://localhost:4000/moja-aplikacija/foo][localhost-my-app-foo] će pozvati
metodu ``foo`` i prikazati pripremljeni predložak ``foo.html.{erb,haml}``.

### Very Flat
Minimalistički paket koji dobijete korištenjem opcije ``very_flat`` je jako
sličan drugim mikro-okvirima baziranim na Rubyju, gdje je čitava aplikacija
jedan fajl.

    $ merb-gen very_flat moja-aplikacija
{:lang=shell html_use_syntax=true}

Kako biste pokrenuli ovu vrstu aplikacije, neophodno je da pokrenete Merb
sljedećom komandom u direktoriju u kjem se nalazi vaš aplikacijski fajl:

    $ merb -I moja-aplikacija.rb
{:lang=shell html_use_syntax=true}

Ovo će pokrenuti Merb i vezati ga za standardni port (4000).
Da vidite vašu mini-aplikaciju u akciji, posjetite
[http://localhost:4000/][localhost].

[localhost]:              http://localhost:4000/
[localhost-my-app-foo]:   http://localhost:4000/