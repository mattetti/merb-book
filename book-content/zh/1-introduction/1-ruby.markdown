# RUBY语言

![Ruby](/images/ruby-header.gif){: .no-border}

**参考网站：**
[http://ruby-lang.org](http://ruby-lang.org){: .reference}

* This will become a table of contents (this text will be scraped).
{:toc}

> 使用Ruby编程让我很高兴，因为这是一个连接我的大脑和计算机的最短路径。 我可以用它表达我能想到的东西，非常简洁，而且相当优雅。这一点使它能够区别于大多数其他语言。
> - [Dave Thomas][]{: .quote-author}, 作者[Programming Ruby][]
{: cite=http://www.infoq.com/interviews/ruby-rails-dave-thomas .lead-quote}

在开始讨论为什么Merb非常灵活，功能强大，运行速度块，它的根本原因就是**Ruby**.

## Ruby语言 ##{: #origin}
![Yukihiro Matsumoto](/images/Yukihiro_Matsumoto.jpg){: .left}
Ruby语言是一个开放源码，动态，反射，通用，面向对象的编程语言，由日本软件设计师[Yukihiro "Matz" Matsumoto-san (まつもとゆきひろ)](http://en.wikipedia.org/wiki/Yukihiro_Matsumoto)编写于20世纪90年代中期。

Ruby侧重于简单和高效。 它拥有优雅的语法，很容易阅读和编写。

Matz借鉴其他编程语言([Perl][], [Smalltalk][], [Eiffel][], [Ada][], and [Lisp][])优点和语法，逐渐发展形成一个平衡了[functional programming][]和[imperative programming][]的语言.

其结果是语言有吸引力，让人感觉非常自然。 在Ruby社区，我们常常提到POLS - Principle of Least Suprise（不惊奇原则）。 这一原则背后的概念很简单：如果你知道起码的Ruby，你不应该对语言将作出的反应感到惊讶。

## 接纳 ##{: #adoption}
根据TIOBE指数，在全世界使用的编程语言中，Ruby跻身前10名。 其中大部分的增长是由于很多流行的软件都是由Ruby编写，特别是Ruby on Rails。

## 语言的关键要素 ##{: #key-elements}

> 我需要一种脚本语言，它比Perl更强大，比Python更加面向对象。
> - Matz
{: cite=http://www.linuxdevcenter.com/pub/a/linux/2001/11/29/ruby.html}

* 一切都是对象
* 一切都可以扩展/修改
* 更高的可读性

若要了解更多关于Ruby语言，请参考Ruby语言的官方网站。

## 代码范例 ##{: #code-examples}

**打印字符串“Hello World”5次：**

    5.times do
      print "Hello world!"
    end
    # => "Hello world!Hello world!Hello world!Hello world!Hello world!"
{:lang=ruby html_use_syntax=true}

**条件声明:**

    access_allowed = true if DateTime.now > DateTime.parse("2008-12-01")
{:lang=ruby html_use_syntax=true}

相当于：

    if DateTime.now > DateTime.parse("2008-12-01")
      access_allowed = true
    end
{:lang=ruby html_use_syntax=true}

**三元操作符:**

    age_classification = age > 12 ? "adult" : "child"
{:lang=ruby html_use_syntax=true}

相当于：

    if age > 12
      age_classification = "adult"
    else
      age_classification = "child"
    end

{:lang=ruby html_use_syntax=true}

**数组：**

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


**检查一个数组实例中是否包含一个条目:**

	haystack = ["Mac", "NT", "Irix", "Linux"]
	needle   = "Windows"
	haystack.include?(needle) # => false
{:lang=ruby html_use_syntax=true}

**追加一个条目到数组实例中:**

	haystack = ["Mac", "NT", "Irix", "Linux"]
	needle   = "Windows"
	haystack.push(needle)
	# Or do it like this:
	haystack << needle
{:lang=ruby html_use_syntax=true}

**定义一个方法：**

    def greet_visitor(visitor_name)
      "Hi #{visitor_name}!"
    end
{:lang=ruby html_use_syntax=true}

## Merb和Ruby ##{: #merb-and-ruby}

Merb试图保持尽可能接近Ruby语言本身。 这就是为什么要理解被人们称为“Ruby Way”的重要行性。

在Ruby2008年年会上，Matz发表了如下评论：
> 对于那些不太满意Ruby on Rails相对僵化的解决方案的人来说，Merb的前途是光明的。我认为，Merb将让使用者获得更大的自由，就象Ruby语言本身一样 - [Matz][]{: .quote-author}，Ruby编程语言的作者

[Ada]: http://en.wikipedia.org/wiki/Ada_%28programming_language%29)
[Dave Thomas]:          http://pragdave.pragprog.com/
[dynamic]:              http://en.wikipedia.org/wiki/Dynamic
[Eiffel]: http://en.wikipedia.org/wiki/Eiffel_%28programming_language%29
[functional programming]: http://en.wikipedia.org/wiki/Functional_programming
[imperative programming]: http://en.wikipedia.org/wiki/Imperative_programming
[Lisp]: http://en.wikipedia.org/wiki/Lisp_%28programming_language%29
[Matz]:                 http://en.wikipedia.org/wiki/Yukihiro_Matsumoto
[object-oriented]: http://en.wikipedia.org/wiki/Object-oriented_programming
[Official Ruby language website]: http://www.ruby-lang.org/en/about
[Open Source]:          http://en.wikipedia.org/wiki/Open_Source
[Perl]:                 http://en.wikipedia.org/wiki/Perl)
[programming language]: http://en.wikipedia.org/wiki/Programming_language
[Programming Ruby]:     http://pragprog.com/titles/ruby/programming-ruby
[reflective]: http://en.wikipedia.org/wiki/Reflection_%28computer_science%29
[Ruby programming language]: http://ruby-lang.org/
[Ruby on Rails web framework]: http://rubyonrails.org
[Smalltalk]:            http://en.wikipedia.org/wiki/Smalltalk
[software architect]:   http://en.wikipedia.org/wiki/Software_architect
[TIOBE index]:  http://www.tiobe.com/index.php/content/paperinfo/tpci/index.html
[Yukihiro "Matz" Matsumoto-san ( まつもとゆきひろ)]:  http://en.wikipedia.org/wiki/Yukihiro_Matsumoto


