# Ruby

![Ruby](/images/ruby-header.gif){: .no-border}

**Site source:**
[http://ruby-lang.org](http://ruby-lang.org){: .reference}

* This will become a table of contents (this text will be scraped).
{:toc}


> Coder en Ruby me rend heureux car c'est l'un des plus courts chemins
> entre mon cerveau et un ordinateur.
> Je peux penser à quelque chose et je peux l'exprimer vraiment succinctement
> et typiquement assez élégamment en Ruby
> sans toutes sortes d'étranges fouillis
> que vous avez besoin dans la plupart des autres langages.
> - [Dave Thomas][]{: .quote-author}, auteur de [Programming Ruby][]
{: cite=http://www.infoq.com/interviews/ruby-rails-dave-thomas .lead-quote}

Ce serait un crime de commencer à parler du framework Merb
sans, tout d'abord, parler de la raison même pour laquelle Merb
est si flexible, puissant et rapide: **Ruby**.

## Origine ##{: #origin}
![Yukihiro Matsumoto](/images/Yukihiro_Matsumoto.jpg){: .left}
Ruby est un [Language de programmation][] [Open Source][], [orienté-objet][],
[dynamique][], [réfléchi][],
écrit dans le milieu des années 1990 par un [architecte logiciel][] Japonais
[Yukihiro "Matz" Matsumoto-san ( まつもとゆきひろ)][].

Ruby mets l'accent sur la simplicité et la productivité.
Il possède une syntaxe élégante qui se lit naturellement
et qui est facile à écrire.

Matz a emprunté des idées et idiomes de certains de
ses langages de programmation favoris
([Perl][], [Smalltalk][], [Eiffel][], [Ada][], et [Lisp][])
pour former un nouveau langage
qui s'équilibre entre la [programmation fonctionnelle][]
et la [programmation impérative][].

Le résultat est un langage séduisant qui est très naturel.
Dans la communauté Ruby,
nous nous référons souvent au POLS,
Principle of Least Surprise (Principe de moindre surprise).
Le concept derrière ce terme est très simple:
si vous connaissez un minimum Ruby,
vous ne devriez pas être surpris par la façon dont le langage va réagir.

## Adoption ##{: #adoption}
Selon l'[index TIOBE][],
Ruby se classe dans le top 10 des langages de programmation
les plus utilisés dans le monde.
Une grande partie de cet essor est attribuée à la popularité
de logiciel écrit en Ruby,
en particulier le [framework Web Ruby on Rails][].

## Éléments clés du langage ##{: #key-elements}

> Je voulais un langage de script qui soit plus puissant que Perl,
> et plus orienté objet que Python
> - Matz
{: cite=http://www.linuxdevcenter.com/pub/a/linux/2001/11/29/ruby.html}

* Tout est un objet
* Tout peut être étendu/modifié
* Haute lisibilité du code

Pour en apprendre plus sur le langage Ruby,
rendez-vous sur le [site officiel du langage Ruby][].

## Exemples de Code ##{: #code-examples}

**Affiche la chaîne de caractères "Hello world", 5 fois :**

    5.times do
      print "Hello world!"
    end
    # => "Hello world!Hello world!Hello world!Hello world!Hello world!"
{:lang=ruby html_use_syntax=true}
		
**Test conditionnel:**

    acces_autorise = true if DateTime.now > DateTime.parse("2008-12-01")
{:lang=ruby html_use_syntax=true}

**Opérateur ternaire:**

	classification_age = age > 12 ? "adulte" : "enfant"
{:lang=ruby html_use_syntax=true}

équivalent à:

	if age > 12
		classification_age =  "adulte"
	else
		classification_age = "enfant"
	end
{:lang=ruby html_use_syntax=true}

**Tableau:**

    boissons = ["Coca", "Pepsi", "Orangina", "DrPepper"]
    # => ["Coca,", "Pepsi,", "Orangina,", "DrPepper"]
    # Accès à l'instance du Tableau
    boissons[0]     # => "Coca"
    boissons.first  # => "Coca"
    boissons.last   # => "DrPepper"
    boissons[3]     # => "DrPepper"
    boissons[-1]    # => "DrPepper"
    boissons[boissons.length - 1] # => "DrPepper"
{:lang=ruby html_use_syntax=true}

		
**Test si un élément existe dans l'instance du Tableau:**

    botte_de_foin = ["Mac", "NT", "Irix", "Linux"]
    aiguille = "Windows"
    botte_de_foin.include?(aiguille)	# => false
{:lang=ruby html_use_syntax=true}
	
**Poussez un élément dans une instance de Tableau:**

    botte_de_foin = ["Mac", "NT", "Irix", "Linux"]
    aiguille = "Windows"
    botte_de_foin.push(aiguille)
    # ou comme ceci:
  	botte_de_foin << aiguille
{:lang=ruby html_use_syntax=true}
		
**Définir une méthode:**

    def saluer_visiteur(nom_visiteur)
      "Salut #{nom_visiteur}!"
    end
{:lang=ruby html_use_syntax=true}

## Merb et Ruby ##{: #merb-and-ruby}

Merb tente d'être aussi proche que possible du langage Ruby lui-même.
C'est pourquoi il est important de comprendre ce que les gens
appellent le "Style Ruby".

Durant la RubyConf 2008, Matz a fait une remarque sur Merb:

> Merb a un bel avenir pour les gens qui ne sont pas satisfaits
> par les styles fixés par Rails.
> Je pense que Merb donnera aux utilisateurs plus de liberté
> dans une approche de programmation plus Ruby-iste
> - [Matz][]{: .quote-author},
> auteur du [Langage de programmation Ruby][]
{: cite=http://merbist.com/2008/11/09/merb-1-0-released/}


[Ada]: http://en.wikipedia.org/wiki/Ada_%28programming_language%29)
[architecte logiciel]:   http://en.wikipedia.org/wiki/Software_architect
[Dave Thomas]:          http://pragdave.pragprog.com/
[dynamique]:              http://en.wikipedia.org/wiki/Dynamic
[Eiffel]: http://en.wikipedia.org/wiki/Eiffel_%28programming_language%29
[framework Web Ruby on Rails]: http://rubyonrails.org
[programmation fonctionnelle]: http://en.wikipedia.org/wiki/Functional_programming
[programmation impérative]: http://en.wikipedia.org/wiki/Imperative_programming
[Language de programmation]: http://en.wikipedia.org/wiki/Programming_language
[Langage de programmation Ruby]: http://ruby-lang.org/
[Lisp]: http://en.wikipedia.org/wiki/Lisp_%28programming_language%29
[Matz]:                 http://en.wikipedia.org/wiki/Yukihiro_Matsumoto
[orienté-objet]: http://en.wikipedia.org/wiki/Object-oriented_programming
[Open Source]:          http://en.wikipedia.org/wiki/Open_Source
[Perl]:                 http://en.wikipedia.org/wiki/Perl)
[Programming Ruby]:     http://pragprog.com/titles/ruby/programming-ruby
[réfléchi]: http://en.wikipedia.org/wiki/Reflection_%28computer_science%29
[site officiel du langage Ruby]: http://www.ruby-lang.org/en/about
[Smalltalk]:            http://en.wikipedia.org/wiki/Smalltalk
[index TIOBE]:    http://www.tiobe.com/index.php/content/paperinfo/tpci/index.html
[Yukihiro "Matz" Matsumoto-san ( まつもとゆきひろ)]:  http://en.wikipedia.org/wiki/Yukihiro_Matsumoto


