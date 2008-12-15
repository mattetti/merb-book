#Test di integrazione con Cucumber

* This will become a table of contents (this text will be scraped).
{:toc}

[Cucumber][] è il metodo preferito per i test di integrazione nelle vostre
applicazioni Merb.
Cucumber è uno strumento che può eseguire specifiche di funzionalità scritte
in testo semplice.
Nel seguito un esempio tipico di una funzionalità (feature, NdT) in Cucumber:

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

## Merb e Cucumber

Per poter utilizzare Cucumber con Merb è necessario installare il
plugin [merb\_cucumber][].
Per farlo è necessario lanciare il comando

    $ sudo gem install merb_cucumber

oppure, se utilizzare il gem repository locale

    $ thor merb:gem:install merb_cucumber

quindi, all'interno della root del vostro progetto merb lanciare il comando

    $ merb-gen cucumber

Oppure, per installarlo attraverso il supporto di [Webrat][]

    $ merb-gen cucumber --session-type webrat

che installa anche la funzionalità di login suesposta, la quale dovrebbe
passare se state utilizzando merb-auth.

Potete eseguire le specifiche delle vostre funzionalità semplicemente con

    $ rake features

## Creare nuove funzinalità

Per aggiungere una nuova specifica di funzionalità alla vostra applicazione Merb
è sufficiente eseguire

    $ merb-gen feature FEATURE_NAME

Che creerà una nuova funzionalità chiamata FEATURE\_NAME.feature nella
directory delle funzionalità. Essa sarà simile al testo che segue:

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

Se eseguite le vostre funzionalità dalla linea di comando, vedrete che Cucumber
vi fornirà dei suggerimenti su come implementare ogni passo.
Ulteriori informazioni su come scrivere funzionalità in Cucumber posso essere
consultate sul [wiki di Cucumber][].

<!-- Links -->
[Cucumber]:         http://github.com/aslakhellesoy/cucumber/wikis/home
[merb\_cucumber]:   http://github.com/david/merb_cucumber/tree/master
[Webrat]:           http://github.com/brynary/webrat/wikis
[wiki di Cucumber]:	http://github.com/aslakhellesoy/cucumber/wikis/home
