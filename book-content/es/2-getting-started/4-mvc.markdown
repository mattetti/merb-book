#MVC

MVC is an acronym that stand for Model, View, Controller.  It describe a form of web-application structuring that is easy to test and maintain because it separates business logic, server logic and content generation.  This is the structure of the standard Merb app the is generated for by the 'merb-gen app' command.  It is also the structure used by Rails, CakePHP, Django and many other popular web design tools.

To develop in Merb effectively, it is important that one understand both how the structure works, and what the most effective way to work with it is.  This Chapter will discuss the overall framework; the following three chapter will look at each piece in detail.

Models are the core of the framework.  They are responsible for the business logic of your application, and in Merb they are most often associated with database access through an ORM such as DataMapper or Active Record.  In some applications they are nothing more then a wrapper for a database table, but good developers will try to place as much in their model classes as possible describing relationships among various concepts and adding methods for any non-trivial piece of data retrieval or manipulation.

Views are the glitzy outer shell of an application.  Views are responsible for generating the actual content returned by a request.  Most commonly Views are written in a templating format like eRB or Haml.  Wise developers will attempt to put as little code as possible into a View.

Controllers deal with taking an incoming request and turning it into a response.  They are responsible for interpreting the incoming request, getting instances of the needed Models, and passing this information along to the View.  Novice users are often tempted to add lots of code into the controller layer, but this leads to brittle and hard to test code.  Instead, developers are well advised to keep their controllers as 'skinny' as possible by pushing and code that does not directly relate to the request/response cycle or the gathering of data into the Model.

In the default Merb application, the code for all three of these pieces is found in folders under the 'app' directory.  In the next chapters we will look at how Merb implements each of these parts.
