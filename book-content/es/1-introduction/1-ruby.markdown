# Ruby

* Esto será una tabla de contenidos  (este texto será pegado).
{:toc}

![Ruby](/images/ruby-header.gif){: .no-border}

**Sitio web de Referencia:** [http://ruby-lang.org](http://ruby-lang.org){: .reference}

> Programar en Ruby me hace feliz porque es uno de los caminos más cortos entre mi cerebro y una computadora. Puedo pensar en algo y expresarlo de manera sucinta y elegante en Ruby sin utilizar ningún tipo de artilugios extraños que serian requeridos en casi todos los otros lenguajes.
> - [Dave Thomas, autor de "Programming Ruby"](http://pragdave.pragprog.com/){: .quote-author}
{: cite=http://www.infoq.com/interviews/ruby-rails-dave-thomas .lead-quote}

Sería un crimen comenzar a hablar de la plataforma Merb sin antes discutir la verdadera razón del porque es Merb tan flexible, potente y rápido: **Ruby**.

## Origen ##{: #origin}
![Yukihiro Matsumoto](/images/Yukihiro_Matsumoto.jpg){: .left}
Ruby es un lenguaje de programación orientado a objetos de uso general, de código abierto, dinámico y reflexivo escrito a mitad de los '90 por el arquitecto de software japonés [Yukihiro "Matz" Matsumoto-san ( まつもとゆきひろ)](http://en.wikipedia.org/wiki/Yukihiro_Matsumoto).

Ruby se enfoca en la simplicidad y en la productividad. Tiene una sintaxis elegante que es natural para leer y fácil para escribir.

Matz tomó prestadas ideas y construcciones inspiradas en algunos de sus lenguajes de programación favoritos (Perl, Smalltalk, Eiffel, Ada, y Lisp) para conformar un nuevo lenguaje que balancea la programación funcional con la programación imperativa.

El resultado es un lenguaje atractivo que se siente muy natural. En la comunidad Ruby nos referimos a menudo al Principio de la Mínima Sorpresa. El concepto detrás de este principio es muy simple, si uno sabe un mínimo de Ruby, no debería sorprender la manera en que el lenguaje reaccionará.

## Adopción ##{: #adoption}
De acuerdo con el [indice TIOBE](http://www.tiobe.com/index.php/content/paperinfo/tpci/index.html), Ruby se ubica entre los 10 lenguajes de programación mas usados en el mundo. Mucho de su crecimiento es atribuido a la popularidad del software escrito en Ruby, particularmente la [plataforma web Ruby on Rails](http://rubyonrails.org).

## Elementos Claves del lenguaje ##{: #key-elements}

> Yo quería un lenguaje de script más poderoso que Perl, y más orientado a objetos que Python.
> - Matz
{: cite=http://www.linuxdevcenter.com/pub/a/linux/2001/11/29/ruby.html}

* Todo es un objeto
* Todo puede ser extendido/modificado
* Alta legibilidad del código

Para aprender más sobre el lenguaje Ruby, referirse al [Sitio Oficial del lenguaje Ruby](http://www.ruby-lang.org/en/about).

## Ejemplos de Código ##{: #code-examples}

**Imprimir la cadena "Hola mundo" 10 veces:**

		10.times do
		  print "Hola mundo!"
		end
		# => "Hola mundo!Hola mundo!Hola mundo!Hola mundo!Hola mundo!Hola mundo!
		Hola mundo!Hola mundo!Hola mundo!Hola mundo!"
{:lang=ruby html_use_syntax=true}

**Instrucciones condicionales:**

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


**Verificar si un item existe en una instancia de un Arreglo:**

		pajar = ["Mac", "NT", "Irix", "Linux"]
		aguja = "Windows"
		pajar.include?(aguja)	# => false
{:lang=ruby html_use_syntax=true}

**Insertar un item en una instancia de un Arreglo:**

		pajar = ["Mac", "NT", "Irix", "Linux"]
		aguja = "Windows"
		pajar.push(aguja)
		# Or do it like this:
		pajar << aguja
{:lang=ruby html_use_syntax=true}

**Definir un método:**

		def saludar_visitante(nombre_visitante)
		  "Hola #{nombre_visitante}!"
		end
{:lang=ruby html_use_syntax=true}

## Merb y Ruby ##{: #merb-and-ruby}

Merb intenta de ser tan parecido al lenguaje Ruby como sea posible. Por eso es que es importante entender lo que se ha dado en llamar la "Manera Ruby".

Durante RubyConf 2008, Matz hizo un comentario sobre Merb:

> Merb tiene un futuro brillante para aquellos que no están satisfechos con las pautas fijadas por Rails. Yo pienso que Merb le dará a los usuarios más libertad permitiendoles programar de una manera similar a la manera de Ruby.
> - [Matz, Autor del lenguaje de programación Ruby](http://ruby-lang.org/){: .quote-author}
{: cite=http://merbist.com/2008/11/09/merb-1-0-released/}
