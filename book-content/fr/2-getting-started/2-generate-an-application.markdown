# Créer une application

* This will become a table of contents (this text will be scraped).
{:toc}

Merb est fourni avec un créateur (``merb-gen``)
afin de créer des applications Merb.
Le créateur peut générer différents types d'application Merb;
pour voir toutes les options disponibles du créateur, saisissez:

    $ merb-gen -h
{:lang=shell html_use_syntax=true}

Pour l'instant, regardons les types d'applications Merb
qui peuvent être générés.

## Types
Merb peut être utilisé pour des applications allant du simple fichier, très petit et rapide
au service web large et complexe.
Différentes structures applicatives peuvent être générées,
suivant les besoins du développeur.
Les différentes structures applicatives que vous pouvez générer
sont: ``app``, ``core``, ``flat``, et ``very_flat``.

### App
La couche Merb complète.
Ceci génère une structure de répertoire pour une application complète
avec l'intégralité des fichiers de configuration.
Le fichier ``config/dependencies.rb`` est aussi créé,
il contient toutes les dépendances de ``merb-more`` et ``DataMapper``.

    $ merb-gen app my-application
{:lang=shell html_use_syntax=true}

Cette application a tout ce qu'il faut
pour commencer à construire une application web de première classe:
c'est la structure la plus similaire à celle par défaut utilisée dans Rails.
Les exemples de ce livre fonctionneront en partant du principe
que vous générez votre application de cette manière.

Vous pouvez démarrer cette application en saisissant ``merb``
dans le répertoire racine de l'application.
Cela démarrera Merb et le connectera au port par défut: 4000
Pour voir votre application en action, visitez <http://localhost:4000/>.

### Core
Core will generate the full application directory structure
with a full set of configuration files.
Unlike the ``app`` -- the opinionated full stack --
no dependencies will be added.
{: .to-translate}

    $ merb-gen core my-application
{:lang=shell html_use_syntax=true}

Start up this application by running ``merb``
in the application's root directory.
Notice that, unlike the other three generated apps,
there is no default content in core.
Visiting <http://localhost:4000/> will generate an error
until content and routing are added.
{: .to-translate}

### Flat
A flat application still keeps all its logic in a single file,
but has separate files for configuration and its own view directory.
{: .to-translate}

    $ merb-gen flat my-application
{:lang=shell html_use_syntax=true}

Flat applications are run, like any other generated merb app,
by running ``merb`` in the application's root directory.
By default, all methods in the ``my-application`` class
will be treated as actions with ``my-application`` as the controller.
e.g.: <http://localhost:4000/my-application/foo>
{: .to-translate}

This will call ``MyApplication#foo``
and render the output from the ``foo.html.*`` template.
{: .to-translate}

### Very Flat
A Very Flat application is similar to other Ruby micro frameworks,
where the entire application is in one file.
{: .to-translate}

    $ merb-gen very_flat my-applcation
{:lang=shell html_use_syntax=true}

To run a very flat application, start up Merb with the following command
(within your application directory):
{: .to-translate}

    $ merb -I my-applcation.rb
{:lang=shell html_use_syntax=true}

This will start Merb and bind it to the default port (4000).
To see your application in action, visit <http://localhost:4000/>.
{: .to-translate}