# Generisanje aplikacije

* This will become a table of contents (this text will be scraped).
{:toc}

Merb dolazi sa skriptom ``merb-gen`` koja može da generiše osnovni skelet
aplikacije.
Generator može pripremiti različite tipove Merb aplikacija. Kako biste vidjeli
sve dostupne opcije, unesite:

    $ merb-gen -h
{:lang=shell html_use_syntax=true}

Pogledajmo zasad samo kakve tipove Merb aplikacija možemo generisati.

## Tipovi
Merb može biti korište za bilo šta od jako malih, brzih aplikacija sadržanih
u jednom jedinom fajlu do kompleksnih web servisa.
U skladu sa potrebama programer možete jednostavno generisati različite
tipove aplikacija.
Ovi tipovi su: ``app``, ``core``, ``flat`` i ``very_flat``.

### App
Opcija generatora ``app`` generiše aplikaciju baziranu na dogmatičnom Merb
stacku.
Tako kreirana kreirana aplikacija sadrži poptunu strukturu direktorija
aplikacije sa svim konfiguracijskim fajlovima.
U ovom slučaju se, također, dodaje i fajl ``config/dependencis.rb`` koji
uključuje sve biblioteke iz gema ``merb-more`` i ``DataMapper``.

    $ merb-gen app moja-aplikacija
{:lang=shell html_use_syntax=true}

Ovako generisana aplikacija sadrži sve što je neophodno za kreiranje web
aplikacije prve klase, te je najviše slična osnovnoj strukturi Rails projekta.
Veći dio ove knjige će podrazumijevati da ste počeli na ovaj način.

Pokrenite ovu aplikaciju izvršavanjem naredbe ``merb`` u vašem terminalu dok
se nalazite u korijenskom direktoriju aplikacije.
Ovo će pokrenuti Merb i po standardnim postavkama ga dodijeliti na port 4000.
Kako biste vidjeli novokreiranu aplikaciju, otvorite u vašem browseru
<http://localhost:4000/>.

### Core
Kao i aplikacijame tipa ``app``, ``core`` opcija će generisati aplikaciju
sa svim standardnim direktorijima i konfiguracijskim fajlovima.
Ipak, za razliku od pootnjeg, dependency biblioteke neće biti automatski
dodate.

    $ merb-gen core moja-aplikacija
{:lang=shell html_use_syntax=true}

Kako biste pokrenuli aplikaciju, kao i ranije izvršite naredbu ``merb`` u
terminalu unutar korijenskog direktorija aplikacije.
Primjetite da, za razliku od ostale tri vrste generisanih aplikacija, core
aplikacija nema standardnog sadržaja.
Otvaranje adrese <http://localhost:4000/> će proizvoditi grešku sve dok se
ne doda sadržaj i podesi rutiranje.

### Flat
"Pljosnate" aplikacije čuvaju svu svoju logiku u jednom fjalu, ali imaju
posebne fajlove za konfiguraciju i poseban direktorij za predloške.

    $ merb-gen flat moja-aplikacija
{:lang=shell html_use_syntax=true}

Aplikacije ovog tipa se pokreću kao i sve ostale Merb aplikacije: izvršavanjem
naredbe ``merb``.
Po generisanim postavkama, sve metode klase ``moja-aplikacija`` 'e biti
tretirane kao akcije kontrolera ``moja-aplikacija``.
Naprimjer, <http://localhost:4000/moja-aplikacija/foo> će pozvati metodu
``foo`` i prikazati pripremljen predložak ``foo.html.{erb,haml}``.

### Very Flat
Minimalistički paket koji dobijete korištenjem opcije ``very flat`` je jako
sličan drugim mikro-okvirima baziranim na Rubyju, gdje je čitava unutar jednog
fajla.

    $ merb-gen very_flat moja-aplikacija
{:lang=shell html_use_syntax=true}

Kako biste pokrenuli ovu vrstu aplikacije, neophodno je da pokrenete Merb
sljedećom komandom u direktoriju u kjem se nalazi vaš aplikacijski fajl:

    $ merb -I moja-aplikacija.rb
{:lang=shell html_use_syntax=true}

Ovo će pokrenuti Merb i vezati ga za standardni port (4000).
Kako biste pogledali vašu aplikaciju u akciji, posjetite
<http://localhost:4000/>.
