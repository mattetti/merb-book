#Integration testing with Cucumber

* This will become a table of contents (this text will be scraped).
{:toc}

[Cucumber][] is the preferred method for integration testing your Merb
applications.
Cucumber is a tool that can execute "feature documentation"
written in plain text.
Here is an example of a typical Cucumber feature:

    Feature: Login
      To ensure the safety of the application
      A regular user of the system
      Must authenticate before using the app

      Scenario: Failed Login
        Given I am not authenticated
        When I go to /login
        And I fill in "login" with "i_dont_exist"
        And I fill in "password" with "and_i_dont_have_a_password"
        And I press "Log In"
        Then the login request should fail
        Then I should see an error message

## Merb and Cucumber

In order to use Cucumber with Merb,
you need to install the [merb\_cucumber][] plugin.
To install the plugin, run the command

    $ sudo gem install merb_cucumber

or, if you're using the local gems directory, run

    $ thor merb:gem:install merb_cucumber

Then, inside of your merb project root, run

    $ merb-gen cucumber

Or, to install with [Webrat][] support, run

    $ merb-gen cucumber --session-type webrat

This will also install the login feature shown above.
This should pass if you’re using merb-auth.

Running your features is then as simple as running

    $ rake features

## Creating new features

To add a new feature definition to your Merb application, run

    $ merb-gen feature FEATURE_NAME

This will create a new feature named FEATURE\_NAME.feature in the features
directory that looks like this:

    Feature: add comment
      To [accomplish some goal]
      A [role]
      Does [something]

      Scenario: [first scenario]
        Given [precondition]
            And [another precondition]
        When [event happens]
        And [another event happens]
        Then [outcome]
        And [another outcome]

        Scenario: [other scenario]
          Given [precondition]
            And [another precondition]
          When [event happens]
          And [another event happens]
          Then [outcome]
          And [another outcome]

If you then run your features from the command line,
you'll see that Cucumber gives you hints about how to implement each step.
More information about implementing Cucumber features can be found
on the [Cucumber wiki].

<!-- Links -->
[Cucumber]:         http://github.com/aslakhellesoy/cucumber/wikis/home
[Cucumber wiki]:    http://github.com/aslakhellesoy/cucumber/wikis/home
[merb\_cucumber]:   http://github.com/david/merb_cucumber/tree/master
[Webrat]:           http://github.com/brynary/webrat/wikis
