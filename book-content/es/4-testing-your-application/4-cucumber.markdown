# Pruebas de de integración con Cucumber (pepino)

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

[Cucumber][] es el método preferido para hacer pruebas de integración en las
aplicaciones Merb.
Cucumber es una herramienta que puede ejecutar la documentación de las características escrita en texto sin formato.
Este es un ejemplo de una característica típica en Cucumber:

    Característica: Inicio de sesión
      Para asegurarnos de la seguridad de la aplicación
      Un usuario habitual del sistema
      Debe autenticarse antes de utilizar la aplicación

      Escenario: Fallo de inicio de sesión
        Dado que no estoy autenticado
        Cuando voy a /login
        Y relleno "login" con "yo_no_existo"
        Y relleno "password" con "y_yo_no_tengo_password"
        Y pulso el botón "Log In"
        Entonces la solicitud de inicio de sesión debería fallar
        Y yo debería ver un mensaje de error

## Merb y Cucumber

Para utilizar Cucumber con Merb, necesitas instalar el plugin [merb\_cucumber][].
Para instalar el plugin, ejecuta el comando

    $ sudo gem install merb_cucumber

o, si estas utilizando el directorio local de gemas ejecuta

    $ thor merb:gem:install merb_cucumber

Entonce, desde la raiz de tu proyecto merb ejecuta

    $ merb-gen cucumber

O para instalarlo con soporte de [Webrat][] ejecuta

    $ merb-gen cucumber --session-type webrat

Esto también instalará la característica de acceso (login) que se muestra arriba, que debería pasar
si estas utilizando merb-auth.

Ejecutar todas las características es tan simple como ejecutar

    $ rake features

## Creación de nuevas características

Para añadir una nueva característica a tu aplicación Merb, ejecuta

    $ merb-gen feature NOMBRE_CARACTERISTICA

Esto creará una nueva característica denominada NOMBRE_CARACTERISTICA.feature en el directorio 'features'
que tendrá este aspecto:

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

Si ejecutas tus características desde la linea de comandos, veras que Cucumber
te da pistas sobre como implementar cada paso.
Mas información sobre la implementación de características con Cucumber puede encontrarse en
[Cucumber wiki].

[Cucumber]:         http://github.com/aslakhellesoy/cucumber/wikis/home
[merb\_cucumber]:   http://github.com/david/merb_cucumber/tree/master
[Webrat]:           http://github.com/brynary/webrat/wikis
[Cucumber wiki]:    http://github.com/aslakhellesoy/cucumber/wikis/home
