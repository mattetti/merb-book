# A Linguagem Ruby

![Ruby](/images/ruby-header.gif){: .no-border}

**Referência:**
[http://ruby-lang.org](http://ruby-lang.org){: .reference}

* Isto irá se tornar um índice (este texto será apagado).
{:toc}


> Escrever código em Ruby me faz feliz porque é um dos caminhos mais curtos
> entre meu cérebro e um computador.
> Eu posso pensar em algo e expressar isso de uma forma muito sucinta
> e tipicamente muito elegante em Ruby
> sem todo tipo de bobagens
> que você precisa na maioria das outras linguagens.
> - [Dave Thomas][]{: .quote-author}, author do ["Programming Ruby"][]
{: cite=http://www.infoq.com/interviews/ruby-rails-dave-thomas .lead-quote}

Seria um crime começar a falar sobre o framework Merb
sem antes discutirmos sobre a principal razão do Merb
ser tão flexível, poderoso e rápido: **Ruby**.

## Origem ##{: #origin}
![Yukihiro Matsumoto](/images/Yukihiro_Matsumoto.jpg){: .left}
Ruby é uma [linguagem de programação][] [Open Source][], [dinâmica][], [reflexiva][], de propósito geral
e [orientada a objetos][]
escrita em meados de 1990 pelo [arquiteto de software][] japonês
[Yukihiro "Matz" Matsumoto-san ( まつもとゆきひろ)][].

Ruby tem como foco a simplicidade e a produtividade.
Ela tem uma sintaxe elegante que é natural de ler e fácil de escrever.

Matz pegou idéias e idiomas de algumas das suas linguagens de programação favoritas
([Perl][], [Smalltalk][], [Eiffel][], [Ada][], e [Lisp][])
para formar uma nova linguagem
que equilibra [programação funcional][] com [programação imperativa][].

O resultado é uma linguagem atraente que soa muito natural.
Na comunidade Ruby,
nós frequentemente nos referimos ao POLS, Principle of Least Surprise (Princípio da Menor Surpresa).
O conceito por trás desse princípio é muito simples:
se você sabe o mínimo de Ruby,
você não deverá se surpreender sobre a forma que a linguagem irá reagir.

## Adoção ##{: #adoption}
De acordo com o [índice TIOBE][],
Ruby se encontra entre as 10 linguagens de programação mais usadas no mundo.
A maior parte do crescimento é atribuído a popularidade de softwares
escritos em Ruby, especialmente o [framework web Ruby on Rails][].

## Elementos-chave da linguagem ##{: #key-elements}

> Eu queria uma linguagem de script que fosse mais poderosa que Perl,
> e mais orientada a objetos que Python
> - Matz
{: cite=http://www.linuxdevcenter.com/pub/a/linux/2001/11/29/ruby.html}

* Tudo é um objeto
* Tudo pode ser extendido / modificado
* Código altamente legível

Para aprender mais sobre a linguagem Ruby,
verifique o [website oficial da linguagem Ruby][].

## Exemplos de código ##{: #code-examples}

**Imprima a *string* "Hello world" 5 vezes:**

		5.times do
		  print "Hello world!"
		end
    # => "Hello world!Hello world!Hello world!Hello world!Hello world!"
{:lang=ruby html_use_syntax=true}

**Declaração condicional:**

	  access_allowed = true if DateTime.now > DateTime.parse("2008-12-01")
{:lang=ruby html_use_syntax=true}

é equivalente a:

		if DateTime.now > DateTime.parse("2008-12-01")
		  access_allowed = true 
		end
{:lang=ruby html_use_syntax=true}

**Operador ternário:**

	  age_classification = age > 12 ? "adult" : "child"
{:lang=ruby html_use_syntax=true}

é equivalente a:

	  if age > 12
		  age_classification =  "adult"
	  else
		  age_classification = "child"
	  end
{:lang=ruby html_use_syntax=true}

**Array:**

		drinks = ["Coke", "Pepsi", "Orangina", "DrPepper"]
	  #     => ["Coke", "Pepsi", "Orangina", "DrPepper"]
		# Accessando a instância do Array
  	drinks[0]     # => "Coke"
  	drinks.first  # => "Coke"
  	drinks.last   # => "DrPepper"
  	drinks[3]     # => "DrPepper"
  	drinks[-1]    # => "DrPepper"
  	drinks[drinks.length - 1] # => "DrPepper"
{:lang=ruby html_use_syntax=true}


**Verifica se um item existe em uma instância de um Array:**

		haystack = ["Mac", "NT", "Irix", "Linux"]
		needle = "Windows"
		haystack.include?(needle)	# => false
{:lang=ruby html_use_syntax=true}

**Adiciona um item em uma instância de um Array:**

		haystack = ["Mac", "NT", "Irix", "Linux"]
		needle = "Windows"
		haystack.push(needle)
	  # Ou então, faça assim:
		haystack << needle
{:lang=ruby html_use_syntax=true}

**Define um método:**

		def greet_visitor(visitor_name)
		  "Hi #{visitor_name}!"
		end
{:lang=ruby html_use_syntax=true}

## Merb e Ruby ##{: #merb-and-ruby}

Merb tenta ficar o mais próximo possível da linguagem Ruby em si.
É por isso que é importante entender o que as pessoas chamam de "Ruby Way" (o Jeito Ruby).

Durante a RubyConf 2008, Matz fez um comentário sobre Merb:

> Merb tem um futuro brilhante para as pessoas que não estão satisfeitas
> com o jeito padrão do Rails.
> Eu acho que o Merb trará mais liberdade ao usuários
> em uma maneira Ruby de se programar
> - [Matz][]{: .quote-author},
> autor da [linguagem de programação Ruby][]
{: cite=http://merbist.com/2008/11/09/merb-1-0-released/}


[Ada]: http://en.wikipedia.org/wiki/Ada_%28programming_language%29)
[Dave Thomas]:          http://pragdave.pragprog.com/
[dinâmica]:             http://en.wikipedia.org/wiki/Dynamic
[Eiffel]: http://en.wikipedia.org/wiki/Eiffel_%28programming_language%29
[programação funcional]:  http://en.wikipedia.org/wiki/Functional_programming
[programação imperativa]: http://en.wikipedia.org/wiki/Imperative_programming
[Lisp]: http://en.wikipedia.org/wiki/Lisp_%28programming_language%29
[Matz]:                http://en.wikipedia.org/wiki/Yukihiro_Matsumoto
[orientada a objetos]: http://en.wikipedia.org/wiki/Object-oriented_programming
[website oficial da linguagem Ruby]: http://www.ruby-lang.org/en/about
[Open Source]:         http://en.wikipedia.org/wiki/Open_Source
[Perl]:                http://en.wikipedia.org/wiki/Perl)
[linguagem de programação]: http://en.wikipedia.org/wiki/Programming_language
["Programming Ruby"]:     http://pragprog.com/titles/ruby/programming-ruby
[reflexiva]: http://en.wikipedia.org/wiki/Reflection_%28computer_science%29
[linguagem de programação Ruby]: http://ruby-lang.org/
[framework web Ruby on Rails]: http://rubyonrails.org
[Smalltalk]:            http://en.wikipedia.org/wiki/Smalltalk
[arquiteto de software]:   http://en.wikipedia.org/wiki/Software_architect
[índice TIOBE]:  http://www.tiobe.com/index.php/content/paperinfo/tpci/index.html
[Yukihiro "Matz" Matsumoto-san ( まつもとゆきひろ)]:  http://en.wikipedia.org/wiki/Yukihiro_Matsumoto


