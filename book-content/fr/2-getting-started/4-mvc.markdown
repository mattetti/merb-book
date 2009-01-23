#MVC

* This will become a table of contents (this text will be scraped).
{:toc}

MVC est un acronyme pour Modèle, Vue, Contrôleur.
Il décrit une manière de structurer une application web
facile à tester et à maintenir,
car elle sépare la logique métier, la logique serveur, et la génération du contenu.
C'est la structure standard d'une application Merb
qui est générée par la commande '``merb-gen app``'.
C'est aussi la structure utilisée par [Rails][], [CakePHP][], [Django][],
et beaucoup d'autres framework populaires de développement web.

Pour développer efficacement dans Merb,
il est important de comprendre comment la structure MVC fonctionne,
et aussi la manière la plus pratique de travailler avec.
Ce chapitre discutera du framework en général;
les 3 chapitres suivants analyseront chaque partie en détails.

[Les Modèles][] sont le coeur du framework.
Il sont responsable de la logique métier de votre application;
dans Merb, ils sont le plus souvent associé aux accès à la base de donnée
à travers d'un ORM comme DataMapper ou Active Record.
Parfois les Modèles ne sont rien de plus
qu'une enveloppe définissant une table de la base de donnée.
Cependant, avoir des Modèles 'lourds' est généralement une bonne pratique.
Cela signifie que les classes de Modèle contiennent
les relations entre les données et les méthodes
pour toute recherche ou manipulation de morceaux de données.

[Les Vues][] sont la couche externe flashy de votre application.
Les Vues sont responsable de la génération du contenu (HTML, XML, JSON)
rendu par une requête.
Le plus souvent, les Vues sont écrites dans un format de mise en page
comme [Erb][] (embedded Ruby) ou [Haml][].
Les développeurs les plus sages tenteront de mettre le moins de code possible
à l'intérieur de leurs Vues.

[Les Contrôleurs][] s'occupent de récupérer une requête entrante
et de la transformer en une réponse.
Il sont responsable de l'interprétation des requêtes entrantes,
en récupérant les instances des Modèles nécessaires,
et en passant cette information vers la Vue.

Dans une application Merb par défaut,
le code pour toutes ces 3 parties se trouvent
dans les dossier '``models``', '``views``' et '``controlleurs``',
à l'intérieur du dossier '``app``'.
Dans les prochains chapitres, nous verrons comment Merb implémente chacune de ces pièces.

Les utilisateurs débutant sont souvent tentés d'ajouter beaucoup de code dans la couche contrôleur,
mais cela se termine avec un code fragile est difficile à tester.
A la place, il est conseiller aux développeurs
de garder leurs contrôleurs le plus 'maigre' possible,
en poussant le code qui ne se rapporte directement pas au cycle requête/réponse
(ou la récupération de donnée) dans le Modèle.

[CakePHP]:              http://www.cakephp.org/
[Django]:               http://www.djangoproject.com/
[Erb]:                  http://en.wikipedia.org/wiki/ERuby
[Haml]:                 http://haml.hamptoncatlin.com/
[Les Contrôleurs]:      /fr/getting-started/controllers
[Les Modèles]:          /fr/getting-started/models
[Les Vues]:             /fr/getting-started/views
[Rails]:                http://rubyonrails.org

