# Ruby

* Esto sera una tabla de contenidos  (este texto sera pegado).
{:toc}

![Ruby](/images/ruby-header.gif){: .no-border}

**Sitio web de Referencia:** [http://ruby-lang.org](http://ruby-lang.org){: .reference}

> Programar en Ruby me hace feliz porque es uno de los caminos mas cortos entre mi cerebro y una computadora. Puedo pensar en algo y expresarlo muy suscintamente y normalmente bastante elegante en Ruby sin todo el tipo de pelusa extraña que se necesita en casi todos los otros lenguajes.
> - [Dave Thomas, autor de "Programming Ruby"](http://pragdave.pragprog.com/){: .quote-author}
{: cite=http://www.infoq.com/interviews/ruby-rails-dave-thomas .lead-quote}

Sería un crimen comenzar a hablar de la plataforma Merb sin antes discutir la verdadera razon de porque es Merb tan flexible, potente y rapido: **Ruby**.

## Origen ##{: #origin}
![Yukihiro Matsumoto](/images/Yukihiro_Matsumoto.jpg){: .left}
Ruby es un lenguaje de programacion orientado a objetos de uso general, de codigo abierto, dinamico y reflexivo escrito a mitad de los '90 por el arquitecto de software Japones [Yukihiro "Matz" Matsumoto-san ( まつもとゆきひろ)](http://en.wikipedia.org/wiki/Yukihiro_Matsumoto).

Ruby se enfoca en la simplicidad y la productividad. Tiene una sintaxis elegante que se lee naturalmente y es facil de escribir.

Matz tomó ideas y construcciones inspiradas en algunos de sus lenguajes favoritos de programacion (Perl, Smalltalk, Eiffel, Ada, y Lisp) para conformar un nuevo lenguaje que logró un balance entre la programacion funcional y la programcion imperativa.

El resultado es un lenguaje atractivo que se siente muy natural. En la comunidad Ruby nos referimos a menudo a los POLS (Principle of Least Surprise) Principio de la Minima Sorpresa. El concepto detras de este principio es muy simple, si sabes un minimo de Ruby, no deberias sorprenderte por como el lenguaje reaccionará.

## Adopcion ##{: #adoption}
De acuerdo con [TIOBE index](http://www.tiobe.com/index.php/content/paperinfo/tpci/index.html), Ruby esta entre los 10  lenguajes de programacion mas usados en el mundo. Mucho de su crecimiento es atribuido a la popularidad del software escrito en Ruby, particularmente la [plataforma web Ruby on Rails](http://rubyonrails.org).

## Elementos Claves del languaje ##{: #key-elements}

> Yo quería un lenguaje de script mas poderoso que Perl, y mas orientado a objetos que Python.
> - Matz
{: cite=http://www.linuxdevcenter.com/pub/a/linux/2001/11/29/ruby.html}

* Todo es un objeto
* Todo puede ser extendido/modificado
* Alta legibilidad del codigo

Para aprender mas sobre el lenguaje Ruby, refierete al [Sitio Oficial del lenguaje Ruby](http://www.ruby-lang.org/en/about).

## Ejemplos de Codigo ##{: #code-examples}

**Imprimir la cadena "Hola mundo" 10 veces:**

		10.times do
		  print "Hola mundo!"
		end
		# => "Hola mundo!Hola mundo!Hola mundo!Hola mundo!Hola mundo!Hola mundo!
		Hola mundo!Hola mundo!Hola mundo!Hola mundo!"
{:lang=ruby html_use_syntax=true}

**Instrucciones conditionales:**

		acceso_permitido = true if DateTime.now > DateTime.parse("2008-12-01")
{:lang=ruby html_use_syntax=true}

**Operador ternario:**

	clasificacion_edad = edad > 12 ? "adulto" : "niño"
{:lang=ruby html_use_syntax=true}

es equivalente a:

	if edad > 12
		clasificacion_edad =  "adulto"
	else
		clasificacion_edad = "niño"
	end
{:lang=ruby html_use_syntax=true}

**Arreglos:**

		bebidas = ["Coke", "Pepsi", "Orangina", "DrPepper"]
		# => ["Coke,", "Pepsi,", "Orangina,", "DrPepper"]
		# Acceder la instancia del Arreglo
		bebidas[0] # => "Coke"
		bebidas.first # => "Coke"
		bebidas.last # => "DrPepper"
		bebidas[3] # => "DrPepper"
		bebidas[bebidas.length - 1] # => "DrPepper"
{:lang=ruby html_use_syntax=true}


**Chequear si un item existe en una instancia de un Arreglo:**

		pajar = ["Mac", "NT", "Irix", "Linux"]
		aguja = "Windows"
		pajar.include?(aguja)	# => false
{:lang=ruby html_use_syntax=true}

**Insetar un item en una instancia de un Arreglo:**

		pajar = ["Mac", "NT", "Irix", "Linux"]
		aguja = "Windows"
		pajar.push(aguja)
		# Or do it like this:
		pajar << aguja
{:lang=ruby html_use_syntax=true}

**Definir un metodo:**

		def saludar_visitante(nombre_visitante)
		  "Hola #{nombre_visitante}!"
		end
{:lang=ruby html_use_syntax=true}

## Merb y Ruby ##{: #merb-and-ruby}

Merb intenta decir tan parecido al lenguaje Ruby como sea posible. Por eso es que es importante entender lo que se ha dado en llamar la "Manera Ruby".

Durante RubyConf 2008, Matz hizo un comentario sobre Merb:

> Merb tiene un futuro brillante para los que no estan satisfechos con las maneras fijas de Rails. Yo pienso que Merb Merb le dará a los usuarios mas libertad haciendolo en una manera de programar más a la manera de Ruby.
> - [Matz, Auto del lenguaje de progración Ruby](http://ruby-lang.org/){: .quote-author}
{: cite=http://merbist.com/2008/11/09/merb-1-0-released/}
