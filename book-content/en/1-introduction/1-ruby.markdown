# Ruby Language

![Ruby](/images/ruby-header.gif){: .no-border}

**Reference website:**
[http://ruby-lang.org](http://ruby-lang.org){: .reference}

* This will become a table of contents (this text will be scraped).
{:toc}


> Coding in Ruby makes me happy because it’s one of the shortest paths
> between my brain and a computer.
> I can think of something and I can express it very succinctly
> and typically fairly elegantly in Ruby
> without all the kind of extraneous fluff
> that you need in most other languages.
> - [Dave Thomas][]{: .quote-author}, author of [Programming Ruby][]
{: cite=http://www.infoq.com/interviews/ruby-rails-dave-thomas .lead-quote}

It would be a crime to start talking about the Merb framework
without first discussing the very reason why Merb
is so flexible, powerful, and fast: **Ruby**.

## Origin ##{: #origin}
![Yukihiro Matsumoto](/images/Yukihiro_Matsumoto.jpg){: .left}
Ruby is an [Open Source][], [dynamic][], [reflective][], general-purpose,
[object-oriented][] [programming language][],
written in the mid-1990s by Japanese [software architect][]
[Yukihiro "Matz" Matsumoto-san ( まつもとゆきひろ)][].

Ruby focuses on simplicity and productivity.
It has an elegant syntax that is natural to read and easy to write.

Matz borrowed ideas and idioms from some of his favorite programming languages
([Perl][], [Smalltalk][], [Eiffel][], [Ada][], and [Lisp][])
to form a new language
that balances [functional programming][] with [imperative programming][].

The result is an attractive language which feels very natural.
In the Ruby community,
we often refer to the POLS (Principle of Least Surprise).
The concept behind this principle is very simple:
if you know a minimum of Ruby,
you should not be surprised by how the language will react.

## Adoption ##{: #adoption}
According to the [TIOBE index][],
Ruby ranks in the top 10 programming languages used worldwide.
Much of the growth is attributed to the popularity of software
written in Ruby, particularly the [Ruby on Rails web framework][].

## Key Elements of the language ##{: #key-elements}

> I wanted a scripting language that was more powerful than Perl,
> and more object-oriented than Python.
> - Matz
{: cite=http://www.linuxdevcenter.com/pub/a/linux/2001/11/29/ruby.html}

* Everything is an object
* Everything can be extended/modified
* High code readability

To learn more about the Ruby language,
check the [Official Ruby language website][].

## Code Examples ##{: #code-examples}

**Print the string "Hello world" 5 times:**

    5.times do
      print "Hello world!"
    end
    # => "Hello world!Hello world!Hello world!Hello world!Hello world!"
{:lang=ruby html_use_syntax=true}

**Conditional statement:**

    access_allowed = true if DateTime.now > DateTime.parse("2008-12-01")
{:lang=ruby html_use_syntax=true}

equivalent to:

    if DateTime.now > DateTime.parse("2008-12-01")
      access_allowed = true
    end
{:lang=ruby html_use_syntax=true}

**Ternary operator:**

    age_classification = age > 12 ? "adult" : "child"
{:lang=ruby html_use_syntax=true}

equivalent to:

    if age > 12
      age_classification = "adult"
    else
      age_classification = "child"
    end
{:lang=ruby html_use_syntax=true}

**Array:**

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


**Check if an item exists in an Array instance:**

	haystack = ["Mac", "NT", "Irix", "Linux"]
	needle   = "Windows"
	haystack.include?(needle) # => false
{:lang=ruby html_use_syntax=true}

**Push an item into an Array instance:**

	haystack = ["Mac", "NT", "Irix", "Linux"]
	needle   = "Windows"
	haystack.push(needle)
	# Or do it like this:
	haystack << needle
{:lang=ruby html_use_syntax=true}

**Define a method:**

    def greet_visitor(visitor_name)
      "Hi #{visitor_name}!"
    end
{:lang=ruby html_use_syntax=true}

## Merb and Ruby ##{: #merb-and-ruby}

Merb tries to stay as close as possible to the Ruby language itself.
That's why it's important to understand what people call the "Ruby Way".

During RubyConf 2008, Matz made a comment about Merb:

> Merb has a bright future for the people who are not satisfied
> by the fixed ways in Rails.
> I think that Merb will give users more freedom
> in a Ruby-ish way of programming
> - [Matz][]{: .quote-author},
> author of the [Ruby programming language][]
{: cite=http://merbist.com/2008/11/09/merb-1-0-released/}


[Ada]:                  http://en.wikipedia.org/wiki/Ada_%28programming_language%29)
[Dave Thomas]:          http://pragdave.pragprog.com/
[dynamic]:              http://en.wikipedia.org/wiki/Dynamic
[Eiffel]:               http://en.wikipedia.org/wiki/Eiffel_%28programming_language%29
[functional programming]: http://en.wikipedia.org/wiki/Functional_programming
[imperative programming]: http://en.wikipedia.org/wiki/Imperative_programming
[Lisp]:                 http://en.wikipedia.org/wiki/Lisp_%28programming_language%29
[Matz]:                 http://en.wikipedia.org/wiki/Yukihiro_Matsumoto
[object-oriented]:      http://en.wikipedia.org/wiki/Object-oriented_programming
[Official Ruby language website]: http://www.ruby-lang.org/en/about
[Open Source]:          http://en.wikipedia.org/wiki/Open_Source
[Perl]:                 http://en.wikipedia.org/wiki/Perl)
[programming language]: http://en.wikipedia.org/wiki/Programming_language
[Programming Ruby]:     http://pragprog.com/titles/ruby/programming-ruby
[reflective]:           http://en.wikipedia.org/wiki/Reflection_%28computer_science%29
[Ruby programming language]: http://ruby-lang.org/
[Ruby on Rails web framework]: http://rubyonrails.org
[Smalltalk]:            http://en.wikipedia.org/wiki/Smalltalk
[software architect]:   http://en.wikipedia.org/wiki/Software_architect
[TIOBE index]:          http://www.tiobe.com/index.php/content/paperinfo/tpci/index.html
[Yukihiro "Matz" Matsumoto-san ( まつもとゆきひろ)]:  http://en.wikipedia.org/wiki/Yukihiro_Matsumoto


