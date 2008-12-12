# Struktura projekta

* This will become a table of contents (this text will be scraped).
{:toc}

Tipična struktura nove Merb aplikacije generisane naredbom ``merb-gen app``
izgleda otprilike ovako:

    Direktorij aplikacije (Merb.root)
      - app
        - controllers
        - helpers
        - models
        - views
          - exceptions
          - layout
      - autotest
      - config
        - environments
      - doc
      - gems
      - merb
      - public
        - images
        - javascripts
        - stylesheets
      - spec
      - tasks

Slijedi kratki opis svakog pojedinačnog direktorija i njegove svrhe.

## app
Ovo je direktorij u kojem ćete provesti najviše vremena, budući da on sadrži
srž vaše Merb aplikacije.

### controllers
Kontroleri vaše aplikacije su pohranjeni ovdje.
Njihova imena su obično zadata u množini.
Naprimjer, ako imate model "``Page``", fajl sa kontrolerom će se
najvjerovatnije zvati ``pages.rb``.
Međutim, ovo je samo konvencija, slobodni ste nazvati vaše kontrolere kako god
vam se to sviđa.
Pogledajte sekciju [kontroleri][] za više informacija.

### models
Ovaj direktorij sadrži klase sa modelima koje često služe kao vaš [ORM][]
koji pruža objektno-orjentisani pristup tabelama vaše baze.
Pogledajte sekciju [modeli][] za više informacija.

### views
Svi predlošci stranica su pohranjeni ovdje.
Obično, ovaj direktorij sadrži ``exceptions`` i ``layouts`` poddirektorije.
Direktorij ``exceptions`` pohranjuje predloške koji su generalno vezani za
HTTP greške.
Naprimjer, svježa Merb aplikacija će imati fajl ``not_found.html.{erb,haml}``
koji odgovara 404 HTTP statusnom kôdu.
Unutar direktorija ``layout`` se nalaze globalni aplikacijski predlošci, kao
dio kojih se prikazuju predlošci za pojedine akcije.
Osnovni globalni predložak se zove ``application.html.{erb,haml}``.
Pogledajte sekciju [prezentacija][] za više informacija.

## config
Pogodili ste.
Ovdje su pohranjeni Merb konfiguracijski fajlovi.
Fajl ``router.rb`` sadrži listu URL [ruta][] koje definišu strutkru,
redoslijed i prikaz vaših URL-ova.
Još jedan važan fajl, ``init.rb``, rukuje osnovnom Merb konfiguracijom.
Ovo je mjesto na kojem možete podesiti vaš ORM, engine za HTML predloške i
okvir za testiranje.
Također, možete dodati i vlastitu konfiguraciju u ``Merb::BootLoader``.
Tačnije, konfiguracija se dodaje u jedan od ``before_app_loads``
ili ``after_app_loads`` blokova, kako bi postavke bile primjenjene
prije, odnosno nakon učitavanja aplikacije.
U fajlu ``dependencies.rb`` možete definisati dependency-biblioteke ili gemove,
tj. biblioteke koje su neophodne za funkcionalnost vaše aplikacije.
Svaki dependency naveden u ovom fajlu će biti učitan pri pokretanju Merb
aplikacije.

### environments
Sve postavke specifične za okruženje se nalaze unutar unutar ovog direktorija.
Postoji nekoliko standardnih konfiguracijskih fajlova
(pisanih u čistom Rubyju), svaki od kojih odgovara jednom od specifičnih
Merb okruženja (razvoj, produkcija, itd.).

## gems
Kada ste spremni [ispostaviti][] vašu aplikaciju, preporučeno je da
[zapakujete][] sve dependency-biblioteke zajedno sa vašom aplikacijom.
Direktorij ``gems`` je pravo mjesto za njih.
Kada pokrenete Merb aplikaciju, ona ća učitati sve gemove iz ovog direktorija
ignorišući ekvivalentne gemove instalirane na sistemskom nivou.

## public
Ovdje možete pohraniti vaše "statiče" fajlove kao što su ``favicon.ico`` i
``robots.txt``.

### images
I ponovo pogađate: sve slike koje koriste vaši predlošci idu ovdje.

### javascripts
U standardnom "Merb stacku", ovaj direktorij sadrži dva fajla:
``application.js`` i ``jquery.js``.
Osnovni Merb stack dolazi u paketu sa fantastičnim [jQuery][] okvirom
za JavaScript.

Ukoliko imate relativno malo JavaScript kôda, onda bi on trebao ići unutar
``application.js`` fajla.
Ukoliko se, ipak, ovo pokaže kao neodrživo, možete dodati i dodatne fajlove.

### stylesheets
Kako bismo poštovali razdvajanje zaduženja, svi vizuelni stilovi trebaju biti
pohranjeni u CSS fajlove.
Pri generisanju Merb aplikacije dobijate ``master.css`` fajl koji možete
prilagođavati po vlastitom ukusu.

## spec
Ukoliko koristite [RSpec][] kao vaš okvir za [testiranje][] ovaj direktorij
će sadržavati te testove. Po standardnim postavkama ćete ovdje naći
dva fajla: prazan ``spec.opts``, koji možete koristiti da dodate argumente za
rspec (npr. obojeni output) i ``spec_helper.rb`` u kojem,
između ostalog, možete podesiti i to kako će testovi biti izvršeni.

## tasks
Ovaj direktorij sadrži Merbove [thor][] zadatke.

[ispostaviti]:          /bs/deployment
[jQuery]:               http://jquery.com/
[kontroleri]:           /bs/getting-started/controllers
[modeli]:               /bs/getting-started/models
[ORM]:                  http://en.wikipedia.org/wiki/Object-relational_mapping
[prezentacija]:         /bs/getting-started/views
[RSpec]:                http://rspec.info/
[ruta]:                 /bs/getting-started/router
[testiranje]:           /bs/testing-your-application
[thor]:                 http://wiki.merbivore.com/faqs/thor
[zapakujete]:           /bs/deployment/bundle
