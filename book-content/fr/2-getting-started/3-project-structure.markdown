# La Structure d'un Projet

* This will become a table of contents (this text will be scraped).
{:toc}

La structure typique d'une nouvelle application Merb (générée avec ``merb-gen app``)
ressemble à quelque chose comme ça:

    Dossier de l'application (Merb.root)
      - app
        - controllers
        - helpers
        - models
        - views
          - exceptions
          - layout
      - autotest
      - config
        - environments
      - doc
      - gems
      - merb
      - public
        - images
        - javascripts
        - stylesheets
      - spec
      - tasks

Voici une brève description de chaque dossier et de son rôle.

## app
C'est le dossier dans lequel vous passerez le plus de temps,
il contient les "tripes" de votre application Merb.

### controllers
Tous les contrôleurs de votre application sont stockés ici (pas de surprise).
Les contrôleurs sont généralement nommés au pluriel.
Par exemple, si vous avez un modèle "``Page``",
le fichier du contrôleur s'appellera sûrement ``pages.rb``.
Cela n'est qu'une convention, cependant:
vous êtes libre de nommer vos contrôleurs comme vous voulez.
Allez dans la section [contrôleurs][] pour obtenir plus d'informations.

### models
Ce dossier contient les classes de vos modèles.
Ces classes représentent généralement vos [ORM][]s,
elles fournissent un accès orienté-objet aux tables de votre base de données.
Allez dans la section [modèles][] pour obtenir plus d'informations.

### views
Tout les templates sont stockés ici.
Par défaut, ce dossier contient les sous-dossiers
``exceptions`` et ``layout``.
Le dossier ``exceptions`` contient les templates
qui sont généralement relatifs aux erreurs HTTP.
Par exemple, une nouvelle application Merb
aura un fichier nommé ``not_found.html.{erb,haml}``,
qui correspond au code de statut HTTP 404.
Le dossier ``layout`` contient les templates généraux de l'application,
dans lesquels les templates d'actions seront rendus.
Le fichier de mise en page par défaut de l'application
est nommé ``application.html.{erb,haml}``.
Allez dans la section [vues][] pour obtenir plus d'informations.

## config
Oui, vous l'avez deviné.
Les fichiers de configuration de Merb sont situés ici.
Le fichier ``router.rb`` contient le [routage][] des URL de l'application,
qui définit la structure, l'ordre, et l'apparence de vos URLs.
Un autre fichier important, ``init.rb``, gère la configuration de base de Merb.
C'est ici que vous paramétrez votre ORM, le moteur de template,
et le framework de test.
Vous pouvez aussi ajouter de la configuration personnalisée au ``Merb::BootLoader``
dans ses blocks ``before_app_loads`` et ``after_app_loads``.
Un autre fichier important, ``dependencies.rb``,
où vous pouvez définir les dépendances de votre application:
les autres librairies ou gems nécessaire à vote application.
Chaque dépendance listée dans ce fichier sera chargée au démarrage de votre application Merb.

### environments
C'est ici que se situent les fichiers de configuration pour des environnements spécifiques.
Il y a quelques fichiers de configuration par défaut (en Ruby pure);
chacun correspondant à un environnement spécifique de Merb
(développement, production, etc.).

## gems
Quand vous prêt pour le [déploiement][] de votre application,
il est recommandé [d'emballer][] toutes vos dépendances
dans la structure de votre application.
Le dossier ``gems`` contiendra ces dépendances emballées.
Quand vous démarrerez votre application Merb,
tous les gems situés dans ce répertoire seront chargés, avec un priorité supérieure aux gems du système.

## public
Ici sont stockés les fichiers "statiques",
comme les ``favicon.ico`` et ``robots.txt``.

### images
Toutes les images que vos template pourront utiliser devrait aller ici.

### javascripts
Dans la "couche Merb" par défaut, ce dossier contient 2 fichiers:
``application.js`` et ``jquery.js``.
La "couche Merb" par défaut inclus
le fabuleux framework Javascript [jQuery][].

Si vous avez une petite quantité de code Javascript spécifique à votre application,
il devrait aller à l'intérieur du fichier ``application.js``.
En revanche, si ce code est plus lourd, vous pouvez rajouter autant de fichiers que nécessaire.

### stylesheets
En restant dans le principe de séparation des préoccupations,
tous les styles visuels devrait être mis dans une feuille de style CSS.
Quand vous générez une application Merb,
une feuille de style est crée (nommée ``master.css``),
que vous pouvez personnaliser suivant votre contenu.

## spec
Si vous utilisez [RSpec][] comme framework de [test][],
ce dossier contiendra ces tests.
Par défaut, ce dossier contient 2 fichiers:
un fichier vide ``spec.opts``,
que vous pouvez utiliser pour rajouter des arguments à la ligne de commande de RSpec
(ajouter une sortie colorée, etc.) et ``spec_helper.rb``,
où vous pouvez personnaliser le lanceur de spec (entre autres).

## tasks
Ce dossier contient les tâches du [thor][] associé à Merb.

[d'emballer]:   /fr/deployment/bundle
[contrôleurs]:  /fr/getting-started/controllers
[déploiement]:  /fr/deployment
[jQuery]:       http://jquery.com/
[modèles]:      /fr/getting-started/models
[ORM]:          http://en.wikipedia.org/wiki/Object-relational_mapping
[routage]:      /fr/getting-started/router
[RSpec]:        http://rspec.info/
[test]:         /fr/testing-your-application
[thor]:         http://wiki.merbivore.com/faqs/thor
[vues]:         /fr/getting-started/views
