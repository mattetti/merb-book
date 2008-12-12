# RSpec testing framework

* This will become a table of contents (this text will be scraped).
{:toc}

**Reference website:**
<http://rspec.info>{: .reference}

## Introduction

[RSpec][] is a Behavior Driven Development framework for Ruby.
It provides two frameworks for writing and executing examples of how your Ruby
application should behave[^rspec]:

 * a Scenario Framework[^cucumber] for describing behavior at the application level
 * a Code Example Framework for describing behavior at the object level

[RSpec][] was influenced by [Dan North][] and his Java-based BDD testing framework called [JBehave][].

## History

Initially BDD was just a discussion between [Aslak Hellesøy][] and [Dan North][]
in the [ThoughtWorks][] London office.
[Dave Astels][] joined the conversation with a blog post stating that he thought
these ideas could be easily implemented in [Smalltalk][] or [Ruby][].
[Steven Baker][] jumped in with an initial implementation, and released
RSpec 0.1. Later in 2006, maintenance was handed over to [David Chelimsky][].[^rspec-history]


## Behavior Driven Development

Behavior Driven Development[^BDD] is an [Agile][] development process that comprises
aspects of [Acceptance Test Driven Planning][], [Domain Driven Design][] and
[Test Driven Development][].

> Behaviour-driven development is an “outside-in” methodology.
> It starts at the outside by identifying business outcomes, and then drills down
> into the feature set that will achieve those outcomes.
> Each feature is captured as a “story”, which defines the scope of the feature
> along with its acceptance criteria.
> - [Dan North][]{: .quote-author}
{: cite=http://dannorth.net/whats-in-a-story}

By focusing on the expected behaviors rather than the technical details,
developers can have better communication with the project owner and other stakeholders.

## Implementation

RSpec is a Domain Specific Language for describing the expected behavior
of a system with executable examples.

Here is a very simple RSpec example.

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