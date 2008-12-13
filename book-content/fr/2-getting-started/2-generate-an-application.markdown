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

## Types d'Applications
Merb peut être utilisé pour des applications allant du simple fichier, très petit et rapide
au service web large et complexe.
Différentes structures applicatives peuvent être générées,
suivant les besoins du développeur.
Les différentes structures applicatives que vous pouvez générer
sont: ``app``, ``core``, ``flat``, et ``very_flat``.

### App
La couche Merb complète avec une opinion.
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
Cela démarrera Merb et le connectera au port par défaut, 4000.
Pour voir votre application en action, visitez <http://localhost:4000/>.

### Core
Core va générer la structure complète des dossiers de l'application
avec l'intégralité des fichiers de configuration.
Contrairement à  ``app`` -- la couche complète avec une opinion --
aucune dépendance ne sera ajoutée.

    $ merb-gen core my-application
{:lang=shell html_use_syntax=true}

Vous pouvez démarrer cette application en saisissant ``merb``
dans le répertoire racine de l'application.
Veuillez noter que, contrairement aux autres applications générées,
il n'y a pas de contenu par défaut dans ``core``.
Visiter <http://localhost:4000/> donnera une erreur
tant que le contenu et le routage ne sera pas ajouté.

### Flat
Une application ``flat`` garde toute la logique dans un seul fichier,
mais a des fichiers séparés pour la configuration et son propre dossier pour les vues.

    $ merb-gen flat my-application
{:lang=shell html_use_syntax=true}

Les applications ``flat`` sont exécutées, comme n'importe quelle autre application merb,
en saisissant ``merb`` dans le répertoire racine de l'application.
Par défaut, toutes les méthodes dans la classe ``my-application``
seront traitées comme des actions, avec ``my-application`` comme contrôleur.
Par exemple: <http://localhost:4000/my-application/foo>

Ceci appelle ``MyApplication#foo``
et affiche en sortie le template ``foo.html.*``.

### Very Flat
Une application ``very flat`` est similaire à d'autres micro frameworks Ruby,
où toute l'application se trouve dans le même fichier.

    $ merb-gen very_flat my-applcation
{:lang=shell html_use_syntax=true}

Pour exécuter une application ``very flat``, démarrer Merb avec la commande suivante
(dans le répertoire de votre application):

    $ merb -I my-applcation.rb
{:lang=shell html_use_syntax=true}

Cela démarrera Merb et le connectera au port par défaut, 4000.
Pour voir votre application en action, visitez <http://localhost:4000/>.