#Testez l’intégration avec RSpec Cucumber

* This will become a table of contents (this text will be scraped).
{:toc}

[Cucumber][] est la meilleure méthode pour tester l'intégration de votre
application Merb.
Cucumber est un outils qui peu exécuter de la documentation de fonctionnalités écrite
en texte seulement.
Voici un exemple d'une fonctionnalité typique avec Cucumber:

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

## Merb et Cucumber

Afin de pouvoir utiliser Cucumber avec Merb, vous devez installer le plugin
[merb\_cucumber][]
Pour installer ce plugin, lancez la commande:

    $ sudo gem install merb_cucumber

ou, si vous utilisez le dossier local pour les gems, lancez:

    $ thor merb:gem:install merb_cucumber

Puis, à l'intérieur de la racine de votre projet Merb, lancez:

    $ merb-gen cucumber

Ou, pour activer le support [Webrat][], lancez:

    $ merb-gen cucumber --session-type webrat

Cela installera aussi la fonctionnalité de Login vue au dessus, qui devrait
réussir si vous utilisez merb-auth.

Exécuter vos fonctionnalités avec la simple commande suivante:

    $ rake features

## Créer de nouvelles fonctionnalités

Pour ajouter une nouvelle définition de fonctionnalité, lancez:

    $ merb-gen feature FEATURE_NAME

Cela créera une nouvelle fonctionnalité nommée FEATURE\_NAME.feature dans
le dossiers des fonctionnalités. Celle-ci devrait ressembler à ça:

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

Si vous exécuter alors vos fonctionnalités depuis la ligne de commande,
vous verrez que Cucumber donne des conseils sur la façon d'implémenter
chaque étape.
Pour plus d'information sur l'implémentation des fonctionnalités de
Cucumber, veuillez vous référer au [wiki Cucumber][].

[Cucumber]:         http://github.com/aslakhellesoy/cucumber/wikis/home
[merb\_cucumber]:   http://github.com/david/merb_cucumber/tree/master
[Webrat]:           http://github.com/brynary/webrat/wikis
[wiki Cucumber]:    http://github.com/aslakhellesoy/cucumber/wikis/home
