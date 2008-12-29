# RSpec 테스팅 프레임웍

* This will become a table of contents (this text will be scraped).
{:toc}

**참고 웹사이트:**
<http://rspec.info>{: .reference}

## 소개{: #introduction}

[RSpec][]은 루비의 Behavior Driven Development[^BDD](BDD) 프레임웍입니다. 이 프레임웍은 여러분의 어플리케이션이 어떻게 행동해야 하는지에 대해 2개의 쓰기, 실행 예제 프레임웍을 제공합니다[^rspec]:

 * 어플리케이션 레벨의 행동기술을 하기위한 시나리오 프레임웍[^cucumber]
 * 객체레벨의 행동기술을 위한 코드예제 프레임웍
 
[RSpec][]은 [Dan North][]와 그의 [JBehave][]이라고 불리는 자바기반 BDD 테스팅 프레임웍에 영향을 받았습니다.

## 역사{: #history}
[Aslak Hellesøy][]와 [Dan North][]가 런던의 [ThoughtWorks](http://www.thoughtworks.com/) 사무실에서 논의한 것이 처음이었습니다. [Dave Astels][]가 그러한 아이디어들이 [Smalltalk][] 나 [Ruby][]로 쉽게 구현될 수 있다고 블로그 글을 통해 제안하면서 대화에 합류하게 되었습니다. [Steven Baker][]는 초기 구현을 도왔고, 차후 2006년에 RSpec 0.1로 발표했습니다. 유지보수는 [David Chelimsky][]가 넘겨받았습니다.[^rspec-history]

## Behavior Driven Development{: #behavior_driven_development}

Behavior Driven Development[^BDD]는 [Acceptance Test Driven Planning][], [Domain Driven Design][] 그리고[Test Driven Development][]의 관점을 혼합한 [Agile][] 개발 프로세스입니다.

> Behaviour-driven development는"아웃사이드인" 방법입니다.
> 먼저 밖에서 비즈니스 결과물들을 식별하는 것에서 부터 출발하고 그러한 결과물들을 달성하는 기능들을 찾아내려 갑니다. 각 기능들은 기능의 범위와 수용기준을 정의하는 "스토리"로 묶어냅니다.
> - [Dan North][]{: .quote-author}
{: cite=http://dannorth.net/whats-in-a-story}

기술적인 세부사항보다 예상되는 동작들에 대해 집중함으로써, 개발자들은 프로젝트 소유자와 다른 이해 관계자들과 보다 나은 커뮤니케이션을 할 수 있습니다.

## 구현{: #implematation}

RSpec은 구체적인 실행사례의 모음을 통해 예상되는 시스템의 동작을 설명하기 위한 [Domain-Specific Language](http://en.wikipedia.org/wiki/Domain_Specific_Language) (DSL) 입니다.

Hier is een heel eenvoudig RSpec voorbeeld.

    describe "Reader" do
      it "should have a browser" do
        reader = Reader.new
        reader.browser.should_not be_nil
      end
    end
{:lang=ruby html_use_syntax=true}


[^rspec]:       [RSpec website](http://rspec.info)
[^cucumber]:    [Cucumber wiki](http://github.com/aslakhellesoy/cucumber/wikis)
[^BDD]:         [BDD door Dan North](http://dannorth.net/tags/agile/bdd)
[^rspec-history]:  [Nick Sieger: BDD met RSpec](http://blog.nicksieger.com/articles/2007/11/04/rubyconf-day-3-behaviour-driven-development-with-rspec)

[Acceptance Test Driven Planning]: http://testing.thoughtworks.com/node/89
[Agile]: http://en.wikipedia.org/wiki/Agile_software_development
[Aslak Hellesøy]: http://blog.aslakhellesoy.com/
[Dan North]: http://dannorth.net
[Dave Astels]: http://blog.daveastels.com/
[David Chelimsky]: http://blog.davidchelimsky.net
[Domain Driven Design]: http://domaindrivendesign.org/
[JBehave]: http://jbehave.org/
[RSpec]: http://rspec.info
[Ruby]: http://ruby-lang.org
[Smalltalk]: http://www.smalltalk.org
[Steven Baker]: http://blog.lavalamp.ca
[Test Driven Development]: http://en.wikipedia.org/wiki/Test-driven_development
[ThoughtWorks]: http://www.thoughtworks.com/

*[TDD]: Test Driven Development
*[BDD]: Behavior Driven Development
