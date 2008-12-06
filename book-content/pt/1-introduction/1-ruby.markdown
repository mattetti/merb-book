# Ruby

* Isto irá se tornar um índice (este texto será apagado).
{:toc}

![Ruby](/images/ruby-header.gif){: .no-border}

**Referência:** [http://ruby-lang.org](http://ruby-lang.org){: .reference}

> Escrever código em Ruby me faz feliz porque é um dos caminhos mais curtos entre meu cérebro e um computador. Eu posso pensar em algo e expressar isso de uma forma muito sucinta e elegante em Ruby sem todo tipo de bobagens que você precisa na maioria das outras linguagens.
> [Dave Thomas, autor do "Programming Ruby"](http://pragdave.pragprog.com/){: .quote-author}
{: cite=http://www.infoq.com/interviews/ruby-rails-dave-thomas .lead-quote}

Seria um crime começar a falar sobre o framework Merb sem antes discutirmos sobre a principal razão do Merb ser tão flexível, poderoso e rápido: **Ruby**.

## Origem ##{: #origin}
![Yukihiro Matsumoto](/images/Yukihiro_Matsumoto.jpg){: .left}
Ruby é uma linguagem open source, dinâmica, reflexiva, de propósito geral e orientada a objetos escrita em meados de 1990 pelo arquiteto de software japonês [Yukihiro "Matz" Matsumoto-san ( まつもとゆきひろ)](http://en.wikipedia.org/wiki/Yukihiro_Matsumoto).

Ruby tem como foco a simplicidade e a produtividade. Ela tem uma sintaxe elegante que é natural de ler e fácil de escrever.

Matz pegou idéias e idiomas de algumas das suas linguagens de programação favoritas (Perl, Smalltalk, Eiffel, Ada, e Lisp) para formar uma nova linguagem que equilibra programação funcional e programação imperativa.

O resultado é uma linguagem atraente que soa muito natural. Na comunidade Ruby nós frequentemente nos referimos ao POLS, Principle of Least Surprise (Princípio da Menor Surpresa). O conceito por trás desse princípio é muito simples: se você sabe o mínimo de Ruby, você não deverá se surpreender sobre a forma que a linguagem irá reagir.

## Adoção ##{: #adoption}
De acordo com o [índice TIOBE](http://www.tiobe.com/index.php/content/paperinfo/tpci/index.html), Ruby se encontra entre as 10 linguagens de programação mais usadas no mundo. A maior parte do crescimento é atribuído a popularidade de softwares escritos em Ruby, especialmente o [framework web Ruby on Rails](http://rubyonrails.org).

## Elementos-chave da linguagem ##{: #key-elements}

> Eu queria uma linguagem de script que fosse mais poderosa que Perl e mais orientada a objetos que Python
> - Matz
{: cite=http://www.linuxdevcenter.com/pub/a/linux/2001/11/29/ruby.html}

* Tudo é um objeto
* Tudo pode ser extendido / modificado
* Código altamente legível

Para aprender mais sobre a linguagem Ruby, verifique o [website oficial da linguagem Ruby](http://www.ruby-lang.org/en/about)

## Exemplos de código ##{: #code-examples}

**Imprima a *string* "Hello world" 10 vezes:**

	10.times do
	  print "Hello world!"
	end
	# => "Hello world!Hello world!Hello world!Hello world!Hello world!Hello, world!
	Hello world!Hello world!Hello world!Hello world!"
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
	# => ["Coke,", "Pepsi,", "Orangina,", "DrPepper"]
	# Accessando a instância do Array
	drinks[0] # => "Coke"
	drinks.first # => "Coke"
	drinks.last # => "DrPepper"
	drinks[3] # => "DrPepper"
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
	# Or do it like this:
	haystack << needle
{:lang=ruby html_use_syntax=true}

**Define um método:**

	def greet_visitor(visitor_name)
	  "Hi #{visitor_name}!"
	end
{:lang=ruby html_use_syntax=true}

## Merb e Ruby ##{: #merb-and-ruby}

Merb tenta ficar o mais próximo possível da linguagem Ruby em si. É por isso que é importante entender o que as pessoas chamam de "Ruby Way" (o Jeito Ruby).

Durante a RubyConf 2008, Matz fez um comentário sobre Merb:

> Merb tem um futuro brilhante para as pessoas que não estão satisfeitas com o jeito padrão do Rails. Eu acho que o Merb trará mais liberdade ao usuários em uma maneira Ruby de se programar
> - [Matz, Autor da linguagem de programação Ruby](http://ruby-lang.org/){: .quote-author}
{: cite=http://merbist.com/2008/11/09/merb-1-0-released/}
