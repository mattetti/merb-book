# Pruebas de integración con Cucumber

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

[Cucumber][] es el método preferido para 
realizar las pruebas de integración en las aplicaciones Merb.
Cucumber es una herramienta que puede ejecutar "documentación de características", 
las cuales son escritas en formato de texto simple.
A continuación se le presentara una típica característica de Cucumber:

    Característica: Inicio de sesión de usuario
      Para asegurar la seguridad de la aplicación
      Un usuario cotidiano del sistema
      Debe autenticarse antes de utilizar la aplicación

      Escenario: Falla en el inicio de la sesión
        Dado que el usuario no se ha autenticado
        Cuando el usuario se dirige hacia /login
        Y relleno "usuario" con "yo_no_existo"
        Y relleno "contraseña" con "y_yo_no_tengo_contraseña"
        Y pulso el botón "Autenticarse"
        Entonces la solicitud de inicio de sesión debería fallar
        Y el usuario debería recibir un mensaje de error

## Merb y Cucumber
Para utilizar Cucumber junto con Merb, 
usted debe instalar el plug-in [merb\_cucumber][].
A fin de instalar esta herramienta, 
usted debe ejecutar el siguiente comando

    $ sudo gem install merb_cucumber
{:lang=shell html_use_syntax=true}

En el caso de estar utilizando el directorio local de gemas, 
usted debe ejecutar el siguiente comando

    $ thor merb:gem:install merb_cucumber
{:lang=shell html_use_syntax=true}

Entonces, desde el directorio raíz de su aplicación Merb, 
usted debe ejecutar el siguiente comando

    $ merb-gen cucumber
{:lang=shell html_use_syntax=true}

En el caso de instalar el soporte para [Webrat][], 
usted debe ejecutar el siguiente comando

    $ merb-gen cucumber --session-type webrat
{:lang=shell html_use_syntax=true}

Esto también instalará la característica de acceso mostrada anteriormente.
que debería pasar en el caso que usted este utilizando ``merb-auth``.

La ejecución de las características definidas 
es tan simple como ejecutar el siguiente comando

    $ rake features
{:lang=shell html_use_syntax=true}

## Creación de nuevas características
Para agregar la definición de una nueva característica a su aplicación Merb, 
usted debe ejecutar el siguiente comando 

    $ merb-gen feature nombre_característica
{:lang=shell html_use_syntax=true}

Este comando generará una nueva característica 
llamada ``nombre_característica.feature`` en el directorio ``features``
de su aplicación Merb. 
Esta característica tendrá el siguiente aspecto 

    Característica: agregar comentario
      Para [cumplir una determinada meta]
      Un [un cierto rol o persona]
      Debe [una determinada acción]

      Escenario: [primer escenario]
        Dada [una pre-condición]
        Y [otra pre-condición]
        Cuando [un evento sucede]
        Y [otro evento sucede]
        Entonces [resultado]
        Y [otro resultado]

      Escenario: [otro escenario]
      	Dada [una pre-condición]
      	Y [otra pre-condición]
      	Cuando [un evento sucede]
      	Y [otro evento sucede]
      	Entonces [resultado]
      	Y [otro resultado]

Si luego usted ejecuta sus característica desde la linea de comando,
podrá observar que Cucumber le proporcionara consejos sobre como implementar cada paso.
Para más información sobra la implementación de sus características, 
por favor referirse a la página [Cucumber wiki][].

[Cucumber]: http://github.com/aslakhellesoy/cucumber/wikis/home
[merb\_cucumber]: http://github.com/david/merb_cucumber/tree/master
[Webrat]: http://github.com/brynary/webrat/wikis
[Cucumber wiki]: http://github.com/aslakhellesoy/cucumber/wikis/home

