# Authentification

* This will become a table of contents (this text will be scraped).
{:toc}

> Les responsabilité d'un système d'Authentification est de prouver que l'identité réclamée
> par un utilisateur est en effet son identité réelle. Il y a de multiples approches depuis
> lesquelles un système d'Authentification peut se contruire, incluant les hôtes de confiance,
> la vérification de mot de passe, ou les réseaux de confiance (comme 'OpenID').
> Après que la vérification ait eu lieu, les responsabilités du système d'Authentification
> sont terminées.
> [Adam French][]{: .quote-author}
{: cite=http://adam.speaksoutofturn.com/post/57615195/entication-vs-orization .lead-quote}

## Merb-auth gems

[merb-auth][] est un méta-gem.
Un méta-gem est un gem Ruby sans code.
Son unique fonction est de déclarer les dépendances et de facilité installation.

Dans la version 1.0.x de Merb, merb-auth utilise 3 gems:
* [merb-auth-core][]
* [merb-auth-more][]
* [merb-auth-slice-password][]

### merb-auth-core

[merb-auth-core][] n'essaye pas d'influencer votre choix pour votre modèle utilisateur,
ni la façon avec laquelle il doit s'authentifier.
Au lieu de ça, il se concentre sur la logique nécessaire pour vérifier qu'un objet
réussi l'authentification, et sauvegarde les clés des objets authentifiés
dans la session.

C'est le principe fondamental de MerbAuth.
La Session est l'endroit utilisé pour l'authentification,
avec une couche d'aides pour les contrôleurs.

Vous pouvez choisir de protéger une action d'un contrôleur, une route, ou un groupe de routes.
C'est pourquoi vous entendrez les développeurs faire référence aux sessions authentifiées.

MerbAuth fait appel aux installation de gestion des erreurs dans Merb,
qui retournent des codes de statuts HTTP correctes.
Lors d'erreur de Login, ou pour forcer un Login à n'importe quel point de votre contrôleur,
il suffit lancer une exception ``Unauthenticated`` avec un message optionnel
et la page de Login sera envoyée à l'utilisateur
La page de Login est en fait un template de Vue pour ``Extensions#unauthenticated``.

Il est possible d'utiliser MerbAuth avec n'importe quel objet en tant qu'objet utilisateur,
en s'assurant que cet objet ne corresponde pas à ``false`` et
qu'il puisse être sérialisé a l'intérieur et au dehors de la session.

Enfin, merb-auth est très puissant de par sa capacité à enchaîner les stratégies.
Vous pouvez ajouter autant de stratégies que vous désirez et elles passeront les unes a la suite des autres
jusqu'à que l'une d'entre elle fonctionne (connexion), ou qu'aucune ne réussisse (tentative manquée).

Une stratégie d'authentification n'est qu'un moyen d'authentifier une requête.
Voici des exemples de stratégies:
* Utilisateur "Salted" (l'utilisateur se connecte avec un mot de passe en utilisant un cryptage "salted")
* OpenID
* clé/jeton API
* Authentification HTTP basique


### merb-auth-more

[merb-auth-more][] rajoute des fonctionnalités en plus à merb-auth-core.
Ce gem offre une série de stratégies génériques et un objet "User" à héritages multiples (Mixins).

Stratégies:
* Formulaire de connexion avec identifiant (ou email) et mot de passe (aka password\_form)
* Authentification HTTP basique (aka basic\_auth)
* OpenID


Héritages multiples (Mixins):
* Utilisateur "salted" avec ActiveRecord
* Utilisateur "salted" avec DataMapper
* Utilisateur "salted" avec relaxdb
* Utilisateur "salted" avec sequel

Le mixin pour l'utilisateur "salted" fournit l'authentification par mot de passe crypté avec SHA1.
Il implémente la méthode User.authenticate indispensable pour son usage
avec les stratégies de mot de passe par défaut.

### merb-auth-slice-password

[merb-auth-slice-password][] est un slice Merb très simple.
Ce Slice fournit aux développeurs une fonction basique de connexion et déconnexion.
Par défaut, il inclut aussi un formulaire pour les connexions avec mot de passe et l'authentification basique.

Par défaut, ce slice chargera les stratégies password\_form et basic\_auth

Les vues et les stratégies peuvent être personnalisées comme dans
l'exemple "Hello World authentifié" fourni ci-dessous.


## Authentification dans la couche Merb

Quand vous créez une application avec la couche merb de base[^merb-stack-app],
merb-auth est déjà configuré pour un usage normal.

Si vous n'avez pas besoin de cette fonctionnalité, il vous suffit de commenter la dépendance
à merb-auth dans config/dependencies.rb.

## Hello World authentifié


### Créer une application

La première étape est de créer votre application en utilisant la couche Merb de base.

    $ merb-gen app hello_world
    $ cd hello_world
{:lang=shell html_use_syntax=true}

Ceci crée la structure de l'application, avec l'authentification déjà configurée.
Les éléments de bases sont:

    app/models/user.rb

    merb/merb-auth/setup.rb
    merb/merb-auth/strategies.rb
{:lang=ruby html_use_syntax=true}

Par défaut, l'authentification d'un utilisateur est gérée par un identifiant et un mot de passe.
Vous devez évidemment configurer la base de donnée et ajouter le premier utilisateur.


    $ rake db:automigrate
    $ merb -i
    >> u = User.new(:login => "identifiant")
    >> u.password = u.password_confirmation = "sekrit"
    >> u.save
{:lang=ruby html_use_syntax=true}


### Créer quelque chose à protéger

Maintenant que nous avons une application, et un utilisateur, nous avons besoin de protéger
quelque chose.

    $ merb-gen controller hello_world
{:lang=ruby html_use_syntax=true}

Mettons quelque chose dans le contrôleur.

    class HelloWorld < Application
      def index
        "Hello World"
      end
    end
{:lang=ruby html_use_syntax=true}

Si vous démarrez Merb maintenant, et que vous ouvrez <http://localhost:4000/hello_world>,
vous verrez s'afficher "Hello World".

### Protéger le routage

Ce n'est pas encore protéger, réglons ce point.
Nous pouvons soit le protéger au niveau du routage dans config/router.rb, ou dans l'action du contrôleur.
Commençons pour voir le routeur.

Editez config/router.rb:

    Merb::Router.prepare do
      authenticate do
        match("/hello_world").to(:controller => "hello_world")
      end
    end
{:lang=ruby html_use_syntax=true}

Ceci amène l'utilisateur à s'authentifier.
Le routeur découvre le ``authenticate``, et s'arrête s'il échoue l'authentification.
Essayez maintenant d'aller sur <http://localhost:4000/hello_world>.
Vous verrez que vous devrez vous authentifier pour y accéder!

Ok. Déconnexion, <http://localhost:4000/logout>


### Protéger le contrôleur

Maintenant, enlevons le code du routeur, et rajoutons la protections au
niveau du contrôleur.
Cela permet, par exemple, un contrôle plus fin au niveau des ressources.

    Merb::Router.prepare do
     match("/hello_world").to(:controller => "hello_world")
    end
{:lang=ruby html_use_syntax=true}

Maintenant rajoutons-le au contrôleur:

    class HelloWorld < Application

      before :ensure_authenticated

      def index
        "Hello World"
      end

    end
{:lang=ruby html_use_syntax=true}

Pour accéder à l'utilisateur connecté depuis votre contrôleur, utilisez:

    session.user
{:lang=ruby html_use_syntax=true}

Voilà... pour l'authentification basique de "Hello World", il n'y a rien de plus.

### Ecraser les vues par défaut

Si vous désirez personnaliser votre application, vous pouvez faire:

    rake slices:merb-auth-slice-password:freeze:views
{:lang=ruby html_use_syntax=true}

Cela fera une copie des vues, présentes dans le slice, à l'intérieur du dossier
/slices/ de votre application.

Après, vous devez copier ces vues dans le répertoire /app/views/ de votre application.
En éditant maintenant ces fichiers, vos modification devraient être prises en compte.

[^merb-stack-app]: merb-gen app hello\_world

## Tester une requête authentifiée

Pour tester une requête qui doit Être authentifiée, vous devrez d'abord vous connecter.
La manière la plus simple pour se connecter, quand vous lancez une spécification de requête,
est d'utiliser un snippet de code.

Voici un exemple de 2 snippets rajoutés dans /spec/spec\_helper.rb

    Merb::Test.add_helpers do

      def create_default_user
        unless User.first(:login => "krusty")
          User.create( :login => "krusty",
                       :password => "klown",
                       :password_confirmation => "klown") or raise "can't create user"
        end
      end

      def login
        create_default_user
        request("/login", {
          :method => "PUT",
          :params => {
            :login => "krusty",
            :password => "klown"
          }
        })
      end

    end
{:lang=ruby html_use_syntax=true}

Le premier snippet crée un utilisateur par défaut, à moins qu'il n'existe déjà.
Le second snippet envoi un requête de connexion en utilisant les attributs de l'utilisateur par défaut.
Notez que l'action de connexion utilise la commande HTTP PUT.

Maintenant que vous avez rajouté ces snippets, il vous suffit de modifier légèrement vos exemples:

    before(:each) do
      login
      @response = request(resource(:articles))
    end
{:lang=ruby html_use_syntax=true}

Dans l'exemple ci-dessus, la requête envoyée à l'URI des articles sera authentifiée.

[Adam French]:      http://adam.speaksoutofturn.com
[merb-auth]:        http://github.com/wycats/merb/tree/master/merb-auth
[merb-auth-core]:   http://github.com/wycats/merb/tree/master/merb-auth/merb-auth-core
[merb-auth-more]:   http://github.com/wycats/merb/tree/master/merb-auth/merb-auth-more
[merb-auth-slice-password]: http://github.com/wycats/merb/tree/master/merb-auth/merb-auth-slice-password

*[API]: Application Programming Interface