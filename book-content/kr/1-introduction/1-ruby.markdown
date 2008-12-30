# Ruby 언어

* This will become a table of contents (this text will be scraped).
{:toc}

![Ruby](/images/ruby-header.gif){: .no-border}

**참고 웹사이트:** [http://ruby-lang.org](http://ruby-lang.org){: .reference}

> 내 두뇌와 컴퓨터를 최단거리로 연결해주기 때문에 루비로 코딩하는 것은 즐겁습니다. 
> 대부분의 다른 다른 언어에서 필요로 하는 모든 종류의 시시한 것들 없이, 루비에서는 간결하고 일반적으로 상당히 우아하게 뭔가를 생각하고 표현할 수 있습니다.
> - [Dave Thomas, "Programming Ruby" 저자](http://pragdave.pragprog.com/){: .quote-author}
{: cite=http://www.infoq.com/interviews/ruby-rails-dave-thomas .lead-quote}

Merb가 왜 그렇게 강력하고, 유연하고, 빠른지에 대한 이유를 설명하지 않고 Merb 프레임웍에 대해 이야기를 시작하는 것은 범죄일 것입니다 : **Ruby**.

## 기원 ##{: #origin}
![마쯔모토 유키히로](/images/Yukihiro_Matsumoto.jpg){: .left}
루비는 1990년대 중반에 [소프트웨어 아키텍트인 마쯔모토 유키히로(まつもとゆきひろ, 별명 "Matz")](http://en.wikipedia.org/wiki/Yukihiro_Matsumoto)씨에 의해서 씌여진 [오픈소스](http://en.wikipedia.org/wiki/Open_Source)이고, [동적](http://en.wikipedia.org/wiki/Dynamic)이며, [리플렉티브](http://en.wikipedia.org/wiki/Reflection_%28computer_science%29)한, 범용 [객체지향](http://en.wikipedia.org/wiki/Object-oriented_programming) [프로그래밍 언어](http://en.wikipedia.org/wiki/Programming_language)입니다.

루비는 단순성과 생산성에 초점을 맞추고 있습니다. 
루비는 자연스럽게 읽고 쓰기 쉬운, 우아한 문법을 가지고 있습니다.

마츠는 자신이 좋아하는 프로그래밍 언어([Perl](http://en.wikipedia.org/wiki/Perl), [Smalltalk](http://en.wikipedia.org/wiki/Smalltalk), [Eiffel](http://en.wikipedia.org/wiki/Eiffel_%28programming_language%29), [Ada](http://en.wikipedia.org/wiki/Ada_%28programming_language%29), [Lisp](http://en.wikipedia.org/wiki/Lisp_%28programming_language%29))에서 아이디어와 이디엄을 빌려[functional 프로그래밍](http://en.wikipedia.org/wiki/Functional_programming) 과 [imperatieve 프로그래밍](http://en.wikipedia.org/wiki/Imperative_programming)의 균형을 갖춘 새로운 언어를 만들었습니다.

결과는 매우 자연스럽게 느껴지는 매력적인 언어였습니다. 
루비커뮤니티에서 우리는 종종 POLS(Principle of Least Surprise)를 참조합니다. 
이 원칙의 배경 컨셉은 매우 간단합니다 : 루비를 최소한으로 알고있다면 언어가 어떻게 반응해도 놀라지 마십시오.

## 채택 ##{: #adoption}
[TIOBE index](http://www.tiobe.com/index.php/content/paperinfo/tpci/index.html)에 의하면, 루비는 세계에서 상위 10위 랭킹에 드는 언어입니다. 
성장의 대부분은 [Ruby on Rails 웹프레임웍](http://rubyonrails.org)의 인기로 인한 것으로 볼 수 있습니다.

## 필수요소들 ##{: #key-elements}

> 펄보다 더 강력하고 파이썬보다 더 객체지향적인 스크립팅 언어를 원했다.
> - Matz
{: cite=http://www.linuxdevcenter.com/pub/a/linux/2001/11/29/ruby.html}

* 모든 것은 객체
* 모든 것이 확장/수정 가능
* 높은 코드 가독성

루비에 대해서 좀 더 알기 원하시면 [공식 루비언어 사이트](http://www.ruby-lang.org/en/about)를 참고하시기 바랍니다.

## 코드예제 ##{: #code-examples}

**"Hello world"문자열 5번 프린트하기**

    5.times do
      print "Hello world!"
    end
    # => "Hello world!Hello world!Hello world!Hello world!Hello world!"
{:lang=ruby html_use_syntax=true}

**조건문:**

    access_allowed = true if DateTime.now > DateTime.parse("2008-12-01")
{:lang=ruby html_use_syntax=true}

다음과 동일:

    if DateTime.now > DateTime.parse("2008-12-01")
      access_allowed = true 
    end
{:lang=ruby html_use_syntax=true}

**3항 연산자:**

    age_classification = age > 12 ? "adult" : "child"
{:lang=ruby html_use_syntax=true}

다음과 동일:

    if age > 12
      age_classification =  "adult"
    else
      age_classification = "child"
    end
{:lang=ruby html_use_syntax=true}

**배열:**

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


**배열요소에 아이템이 있는지 확인:**

    haystack = ["Mac", "NT", "Irix", "Linux"]
    needle   = "Windows"
    haystack.include?(needle)	# => false
{:lang=ruby html_use_syntax=true}

**아이템을 배열에 삽입:**

    haystack = ["Mac", "NT", "Irix", "Linux"]
    needle   = "Windows"
    haystack.push(needle)
    # Or do it like this:
    haystack << needle
{:lang=ruby html_use_syntax=true}

**메소드 정의:**

    def greet_visitor(visitor_name)
      "Hi #{visitor_name}!"
    end
{:lang=ruby html_use_syntax=true}

## Merb와 Ruby ##{: #merb-and-ruby}

Merb는 최대한 루비 언어 자체와 가까이 있으려고 합니다. 
그것이 바로 사람들이 부르는 "Ruby Way"를 이해하는데 있어 중요한 이유입니다.

RubyConf 2008에서 Matz가 Merb에 대해 다음과 같은 코멘트를 했습니다:

> Merb는 레일즈의 고정된 방법에 만족하지 않는 사람들에게 밝은 미래를 제시합니다. 
> 저는 Merb가 유저들에게 더 많은 루비스러운 프로그래밍의 자유를 줄 것으로 생각합니다.
> - [Matz, 루비언어의 창시자](http://ruby-lang.org/){: .quote-author}
{: cite=http://merbist.com/2008/11/09/merb-1-0-released/}
