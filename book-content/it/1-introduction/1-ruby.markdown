# Il linguaggio Ruby

![Ruby](/images/ruby-header.gif){: .no-border}

**Sito web di riferimento:**
[http://ruby-lang.org](http://ruby-lang.org){: .reference}

* This will become a table of contents (this text will be scraped).
{:toc}


> Scrivere codice in Ruby mi rende felice perché trovo che sia uno dei
> percorsi più brevi tra il mio cervello ed il computer.
> Posso pensare a qualcosa ed esprimerlo succintamente
> e con sufficiente eleganza in Ruby,
> senza l'inutile ridondanza che si trova
> in molti altri linguaggi.
> - [Dave Thomas][]{: .quote-author}, autore di [Programming Ruby][]
{: cite=http://www.infoq.com/interviews/ruby-rails-dave-thomas .lead-quote}

Sarebbe un crimine iniziare a parlare del framework Merb
senza prima discutere della vera ragione per cui Merb
è così flessibile, potente e veloce: **Ruby**.

## Le origini ##{: #origin}
![Yukihiro Matsumoto](/images/Yukihiro_Matsumoto.jpg){: .left}
Ruby è un [linguaggio di programmazione][] [open source][], [dinamico][],
[orientato agli oggetti][], di uso generale e con [riflessione][], scritto durante
la metà degli anni 09 dall'[architetto del software][] giapponese
[Yukihiro "Matz" Matsumoto-san ( まつもとゆきひろ)][].

Ruby si concentra sulla semplicità e la produttività.
Ha un'elegante sintassi, naturale da leggere e facile da scrivere.

Matz ha preso in prestito idee ed idiomi da alcuni dei suoi linguaggi
di programmazione favoriti
([Perl][], [Smalltalk][], [Eiffel][], [Ada][] e il [Lisp][])
per creare un nuovo linguagio che bilanci
la [programmazione funzionale][] e la [programmazione imperativa][]

Il risultato è un linguaggio attraente, che appare molto naturale.
Nella comunità Ruby, facciamo spesso riferimento al termine POLS
(Principle of Least Surprise, "Pincipio della minore sorpresa" NdT).
Il concetto alla base di tale principio è molto semplice:
se conosci un minimo Ruby,
non dovresti essere sorpreso da come il linguaggio si comporterà.

## Adozione ##{: #adoption}
Secondo l'indice [TIOBE][],
Ruby è tra i primi 10 linguaggi di programmazione utilizzati nel mondo.
Buona parte di tale crescita viene attribuita alla popolarità di
applicativi scritti in Ruby, in particolare il [framework web Ruby on Rails][].

## Elementi Chiave del linguaggio ##{: #key-elements}

> Volevo un linguaggio di scripting più potente del Perl,
> e più object-oriented del Python.
> - Matz
{: cite=http://www.linuxdevcenter.com/pub/a/linux/2001/11/29/ruby.html}

* Ogni cosa è un oggetto
* Ogni cosa può essere estesa/modificata
* Elevata leggibilità del codice

Per approfondimenti sul linguaggio,
fate riferimento al [sito web ufficiale di Ruby][].

## Esempi di codice ##{: #code-examples}

**Stampare 5 volte la striga "Hello world":**

    5.times do
      print "Hello world!"
    end
    # => "Hello world!Hello world!Hello world!Hello world!Hello world!"
{:lang=ruby html_use_syntax=true}

**Istruzioni condizionali:**

    access_allowed = true if DateTime.now > DateTime.parse("2008-12-01")
{:lang=ruby html_use_syntax=true}

è equivalente a:

    if DateTime.now > DateTime.parse("2008-12-01")
      access_allowed = true
    end
{:lang=ruby html_use_syntax=true}

**Operatore ternario:**

    age_classification = age > 12 ? "adult" : "child"
{:lang=ruby html_use_syntax=true}

è equivalente a:

    if age > 12
      age_classification = "adult"
    else
      age_classification = "child"
    end
{:lang=ruby html_use_syntax=true}

**Array:**

	drinks = ["Coke", "Pepsi", "Orangina", "DrPepper"]
	#     => ["Coke", "Pepsi", "Orangina", "DrPepper"]
	# Acesso all'istanza di Array
	drinks[0]     # => "Coke"
	drinks.first  # => "Coke"
	drinks.last   # => "DrPepper"
	drinks[3]     # => "DrPepper"
	drinks[-1]    # => "DrPepper"
	drinks[drinks.length - 1] # => "DrPepper"
{:lang=ruby html_use_syntax=true}

**Verificare la presenza di un item in un'istanza di Array:**

	haystack = ["Mac", "NT", "Irix", "Linux"]
	needle   = "Windows"
	haystack.include?(needle) # => false
{:lang=ruby html_use_syntax=true}

**Inserire un item in un'istanza di Array:**

	haystack = ["Mac", "NT", "Irix", "Linux"]
	needle   = "Windows"
	haystack.push(needle)
	# oppure così:
	haystack << needle
{:lang=ruby html_use_syntax=true}

**Definire un metodo:**

    def greet_visitor(visitor_name)
      "Hi #{visitor_name}!"
    end
{:lang=ruby html_use_syntax=true}

## Merb e Ruby ##{: #merb-and-ruby}

Merb cerca di restare il più possibile vicino al linguaggio Ruby stesso.
Per questo è importante capire cosa si intende con il termine "Ruby Way".

Durante l'evento RubyConf 2008, Matz ha fatto il seguente commento su Merb:

> Merb ha un luminoso futuro per chi non è soddisfatto
> delle costrizioni presenti in Rails.
> Credo che Merb offrirà agli utilizzatori una maggiore libertà
> "rubyista" nella programmazione
> - [Matz][]{: .quote-author},
> autore di [Ruby programming language][]
{: cite=http://merbist.com/2008/11/09/merb-1-0-released/}

<!-- Links -->
[Ada]: http://en.wikipedia.org/wiki/Ada_%28programming_language%29)
[Dave Thomas]:          http://pragdave.pragprog.com/
[dinamico]:              http://en.wikipedia.org/wiki/Dynamic
[Eiffel]: http://en.wikipedia.org/wiki/Eiffel_%28programming_language%29
[programmazione funzionale]: http://en.wikipedia.org/wiki/Functional_programming
[programmazione imperativa]: http://en.wikipedia.org/wiki/Imperative_programming
[Lisp]: http://en.wikipedia.org/wiki/Lisp_%28programming_language%29
[Matz]:                 http://en.wikipedia.org/wiki/Yukihiro_Matsumoto
[orientato agli oggetti]: http://en.wikipedia.org/wiki/Object-oriented_programming
[sito web ufficiale di Ruby]: http://www.ruby-lang.org/en/about
[open source]:          http://en.wikipedia.org/wiki/Open_Source
[Perl]:                 http://en.wikipedia.org/wiki/Perl)
[linguaggio di programmazione]: http://en.wikipedia.org/wiki/Programming_language
[Programming Ruby]:     http://pragprog.com/titles/ruby/programming-ruby
[riflessione]: http://en.wikipedia.org/wiki/Reflection_%28computer_science%29
[Ruby programming language]: http://ruby-lang.org/
[framework web Ruby on Rails]: http://rubyonrails.org
[Smalltalk]:            http://en.wikipedia.org/wiki/Smalltalk
[architetto del software]:   http://en.wikipedia.org/wiki/Software_architect
[TIOBE]:  http://www.tiobe.com/index.php/content/paperinfo/tpci/index.html
[Yukihiro "Matz" Matsumoto-san ( まつもとゆきひろ)]:  http://en.wikipedia.org/wiki/Yukihiro_Matsumoto


