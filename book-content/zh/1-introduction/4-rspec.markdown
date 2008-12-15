# RSpec测试框架

* This will become a table of contents (this text will be scraped).
{:toc}

参考网站:

**Reference website:**
<http://rspec.info>{: .reference}

## 简介 

[RSpec][]是一个专为Ruby编写的行为驱动开发框架。它有两个部分，分别用于编写和执行那些能够说明你的Ruby应用程序应该具有的行为[^rspec]：
 * 一个描述应用程序级别行为的情景框架[^cucumber]
 * 一个描述对象级别行为的代码范例框架

[RSpec][]主要受到[Dan North][]和他的基于Java的BDD测试框架[JBehave][]的影响。 

## 历史 
最初BDD是从[Aslak Hellesøy][]和[Dan North][]在[ThoughtWorks][]的伦敦办事处的一个讨论开始的。[Dave Astels][]加入了谈话并在随后的一篇博客中指出，他认为这些想法可以很容易地由[Smalltalk][]或[Ruby][]来实现。[Steven Baker][]也加入了初步实施，并公布RSpec 0.1 。 2006年晚些时候，维护的工作被移交给[David Chelimsky][].[^rspec-history] 

## 行为驱动开发 
行为驱动开发(Behavior Driven Development)[^BDD]是一个敏捷[Agile][]开发过程，包括[Acceptance Test Driven Planning][], [Domain Driven Design][]和[Test Driven Development][]的各个方面。 


> 行为驱动的开发是一个“外来的”方法。
> 它始于外，确定的业务成果，然后深入到其中的将实现这些成果的系列功能。
> 每个功能就是一个“故事” ，它定义了范围，功能连同其验收标准。
> - [Dan North][]{: .quote-author} 
{: cite=http://dannorth.net/whats-in-a-story}

通过侧重于预期的行为，而不是技术细节，开发人员能更好地和项目所有者和其他利益相关者进行沟通。 

## 实现

RSpec是一个特定领域的语言，它通过可执行的例子来描述一个系统预期的行为。 

这是一个非常简单的RSpec的例子。

    describe "Reader" do
      it "should have a browser" do
        reader = Reader.new
        reader.browser.should_not be_nil
      end
    end
{:lang=ruby html_use_syntax=true}


[^rspec]:       [RSpec website](http://rspec.info)
[^cucumber]:    [Cucumber wiki](http://github.com/aslakhellesoy/cucumber/wikis)
[^BDD]:         [BDD by Dan North](http://dannorth.net/tags/agile/bdd)
[^rspec-history]:  [Nick Sieger: BDD with RSpec](http://blog.nicksieger.com/articles/2007/11/04/rubyconf-day-3-behaviour-driven-development-with-rspec)

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






