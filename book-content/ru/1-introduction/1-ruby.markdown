# Язык Ruby

![Ruby](/images/ruby-header.gif){: .no-border}

**Сайты к ознакомлению:**
[http://ruby-lang.org](http://ruby-lang.org){: .reference}

{:toc}

> Писать на Ruby делает меня счастливым потому, что это кратчайший путь между
> моим мозгом и компьютером.
> Я могу подумать о чем-то и выразить это очень кратко и обычно 
> достаточно элегантно в Ruby без всякой шелухи, которая нужна в большинстве 
> других языков.
> - [Дэйв Томас][]{: .quote-author}, автор книги [Programming Ruby][]
{: cite=http://www.infoq.com/interviews/ruby-rails-dave-thomas .lead-quote}

Было бы преступлением говорить о фреймворке Merb, не упомянув о самой причине
его гибкости, силы и скорости: **Ruby**.

## Исток ##{: #origin}
![Юкихиро Мацумото](/images/Yukihiro_Matsumoto.jpg){: .left}
Ruby - [открытый][Open-Source], [динамичный][dynamic], [рефлексивный][reflective], универсальный,
[объектно-ориентированный][object-oriented] [язык программирования][programming-language],
написанный в середине 1990хх японским [архитектором программного обеспечения][software-architect]
[Юкихиро "Matz" Мацумото (まつもとゆきひろ)][].

Ruby сосредоточен на простоте и продуктивности.
Он обладает элегантным синтаксисом, естественным для чтения и простым для написания.

Matz позаимствовал идеи и идиомы из некоторых его любимых языков программирования
([Perl][], [Smalltalk][], [Eiffel][], [Ada][], и [Lisp][])
чтобы создать новый язык, который уравновешивает 
[функциональное программирование][functional-programming] с 
[императивным программированием][imperative-programming].

Результатом стал привлекательный язык, кажущийся очень естественным.
В сообществе Ruby часто упоминается POLS (Principle of Least Surprise - 
правило наименьшего удивления).
Идея этого правила очень проста:
если вы знаете минимум Ruby,
вы не должны быть удивлены поведением языка.

## Распространение ##{: #adoption}
Согласно [индексу TIOBE][TIOBE-index],
Ruby находится на десятом месте среди языков программирования, 
используемых во всем мире.
В большой степени это обусловнео популярностью программного обеспечения 
написанного на Ruby, в частности [вэб-фреймворку Ruby on Rails][Ruby-on-Rails].

## Ключевые элементы языка ##{: #key-elements}

> Я хотел скриптовый язык, более мощьный, чем Perl 
> и более объектно-ориентированный, чем Python.
> - Matz
{: cite=http://www.linuxdevcenter.com/pub/a/linux/2001/11/29/ruby.html}

* Все - объект
* Все может быть расширено/модифицировано
* Высокая читабельность кода

Чтобы узнать больше о языке Ruby смотрите
[официальный сайт Ruby][ruby-website].

## Примеры кода ##{: #code-examples}

**Вывести строку "Здравствуй, Мир!" 3 раза:**

    3.times do
      print "Здравствуй, Мир!"
    end
    # => "Здравствуй, Мир!Здравствуй, Мир!Здравствуй, Мир!"
{:lang=ruby html_use_syntax=true}

**Условные инструкции:**

    access_allowed = true if DateTime.now > DateTime.parse("2008-12-01")
{:lang=ruby html_use_syntax=true}

Тоже самое, что и:

    if DateTime.now > DateTime.parse("2008-12-01")
      access_allowed = true
    end
{:lang=ruby html_use_syntax=true}

**Тернарный оператор:**

    age_classification = age > 12 ? "adult" : "child"
{:lang=ruby html_use_syntax=true}

Эквивалентно:

    if age > 12
      age_classification = "adult"
    else
      age_classification = "child"
    end
{:lang=ruby html_use_syntax=true}

**Массивы:**

	drinks = ["Coke", "Pepsi", "Orangina", "DrPepper"]
	#     => ["Coke", "Pepsi", "Orangina", "DrPepper"]
	# Access the Array instance
	drinks[0]     # => "Coke"
	drinks.first  # => "Coke"
	drinks.last   # => "DrPepper"
	drinks[3]     # => "DrPepper"
	drinks[-1]    # => "DrPepper"
	drinks[drinks.length - 1] # => "DrPepper"
{:lang=ruby html_use_syntax=true}


**Проверка существования элемента в массиве:**

	haystack = ["Mac", "NT", "Irix", "Linux"]
	needle   = "Windows"
	haystack.include?(needle) # => false
{:lang=ruby html_use_syntax=true}

**Добавление элемента в массив:**

	haystack = ["Mac", "NT", "Irix", "Linux"]
	needle   = "Windows"
	haystack.push(needle)
	# Or do it like this:
	haystack << needle
{:lang=ruby html_use_syntax=true}

**Методы:**

    def greet_visitor(visitor_name)
      "Hi #{visitor_name}!"
    end
{:lang=ruby html_use_syntax=true}

## Merb и Ruby ##{: #merb-and-ruby}

Merb пытается оставаться как можно ближе к самому языку Ruby.
Поэтому важно понимать, что люди называют "Ruby Way" (Путь Ruby, по-рубистски).

Во время RubyConf 2008, Matz сделал комментарий относительно Merb:

> У Merb предлагает светлое будущее людям, которые не удовлетворены
> заранее определенными приемами в Rails.
> Я думаю, что Merb даст пользователям больше свободы в программировании
> по-рубистски.
> - [Matz][]{: .quote-author}, автор [языка программирования Ruby][ruby]
{: cite=http://merbist.com/2008/11/09/merb-1-0-released/}



[Ada]:                      http://ru.wikipedia.org/wiki/%D0%90%D0%B4%D0%B0_(%D1%8F%D0%B7%D1%8B%D0%BA_%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F)
[Дэйв Томас]:               http://pragdave.pragprog.com/
[dynamic]:                  http://ru.wikipedia.org/wiki/%D0%94%D0%B8%D0%BD%D0%B0%D0%BC%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%BE%D0%B5_%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5
[Eiffel]:                   http://ru.wikipedia.org/wiki/%D0%AD%D0%B9%D1%84%D0%B5%D0%BB%D1%8C_(%D1%8F%D0%B7%D1%8B%D0%BA_%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F)
[functional-programming]:   http://ru.wikipedia.org/wiki/%D0%A4%D1%83%D0%BD%D0%BA%D1%86%D0%B8%D0%BE%D0%BD%D0%B0%D0%BB%D1%8C%D0%BD%D0%BE%D0%B5_%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5
[imperative-programming]:   http://ru.wikipedia.org/wiki/%D0%98%D0%BC%D0%BF%D0%B5%D1%80%D0%B0%D1%82%D0%B8%D0%B2%D0%BD%D0%BE%D0%B5_%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5
[Lisp]:                     http://ru.wikipedia.org/wiki/%D0%9B%D0%B8%D1%81%D0%BF
[Matz]:                     http://ru.wikipedia.org/wiki/%D0%9C%D0%B0%D1%86%D1%83%D0%BC%D0%BE%D1%82%D0%BE,_%D0%AE%D0%BA%D0%B8%D1%85%D0%B8%D1%80%D0%BE
[object-oriented]:          http://ru.wikipedia.org/wiki/%D0%9E%D0%B1%D1%8A%D0%B5%D0%BA%D1%82%D0%BD%D0%BE-%D0%BE%D1%80%D0%B8%D0%B5%D0%BD%D1%82%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%BD%D0%BE%D0%B5_%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5
[ruby-website]:             http://www.ruby-lang.org/en/about
[Open-Source]:              http://ru.wikipedia.org/wiki/%D0%9E%D1%82%D0%BA%D1%80%D1%8B%D1%82%D0%BE%D0%B5_%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%BD%D0%BE%D0%B5_%D0%BE%D0%B1%D0%B5%D1%81%D0%BF%D0%B5%D1%87%D0%B5%D0%BD%D0%B8%D0%B5
[Perl]:                     http://ru.wikipedia.org/wiki/Perl
[programming-language]:     http://ru.wikipedia.org/wiki/%D0%AF%D0%B7%D1%8B%D0%BA_%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F
[Programming Ruby]:         http://pragprog.com/titles/ruby/programming-ruby
[reflective]:               http://ru.wikipedia.org/wiki/%D0%9E%D1%82%D1%80%D0%B0%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5_(%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5)
[ruby]:                     http://ruby-lang.org/
[Ruby-on-Rails]:            http://rubyonrails.org
[Smalltalk]:                http://ru.wikipedia.org/wiki/Smalltalk
[software-architect]:       http://ru.wikipedia.org/wiki/%D0%90%D1%80%D1%85%D0%B8%D1%82%D0%B5%D0%BA%D1%82%D0%BE%D1%80_%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%BD%D0%BE%D0%B3%D0%BE_%D0%BE%D0%B1%D0%B5%D1%81%D0%BF%D0%B5%D1%87%D0%B5%D0%BD%D0%B8%D1%8F
[TIOBE-index]:              http://www.tiobe.com/index.php/content/paperinfo/tpci/index.html
[Юкихиро "Matz" Мацумото (まつもとゆきひろ)]:  http://ru.wikipedia.org/wiki/%D0%9C%D0%B0%D1%86%D1%83%D0%BC%D0%BE%D1%82%D0%BE,_%D0%AE%D0%BA%D0%B8%D1%85%D0%B8%D1%80%D0%BE


