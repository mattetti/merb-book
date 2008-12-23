# Autenticación

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

> La responsabilidad de un sistema de Autenticación es probar que la identidad
> que un usuario proclama es en efecto su identidad real. Hay un buen número de
> enfoques que un sistema de Autenticación puede utilizar para ello, incluyendo
> hosts de confianza, verificación de contraseñas, redes de confianza (como
> 'OpenId').
> Después de que la verificación ha ocurrido, las responsabilidades  del sistema
> de Autenticación han terminado.
> [Adam French][]{: .quote-author}
{: cite=http://adam.speaksoutofturn.com/post/57615195/entication-vs-orization .lead-quote}

## Gemas de  Merb-auth

[merb-auth][] es una meta-gema.
Una meta-gema es una gema de Ruby sin ningún código.
Su único propósito es declarar dependencias y facilitar la instalación

A partir de Merb 1.0.x merb-auth usa 3 gemas:
* [merb-auth-core][]
* [merb-auth-more][]
* [merb-auth-slice-password][]

### merb-auth-core

[merb-auth-core][] no intenta imponer qué modelo de usuario deberías utilizar,
o como deberías hacer la autenticación.
En lugar de ello se centra en la lógica necesaria para comprobar que un objeto
pasa la autenticación, y en almacenar las claves de los objetos autenticados
durante la sesión.

Este es de hecho el principio guía de MerbAuth.
La Sesión es usada como lugar para la autenticación,
con un número de métodos de ayuda (helpers) de controlador.

Puedes elegir proteger una acción de un controlador, o una ruta o grupos de
rutas.
Esta es la razón por la que puedes oir a la gente referirse a una sesión
autenticada.

MerbAuth utiliza las facilidades de gestión de excepciones de Merb que devuelven
códigos de estado HTTP correctos.
Para que falle el acceso, o para forzar un inicio de sesión en cualquier punto
del código del controlador,
simplemente genera una excepción ``Unauthenticated``, con un mensaje opcional
y al usuario se le presentará la página de inicio de sesión.
Esta página de inicio de sesión es de hecho la plantilla de la vista para
``Extensions#unauthenticated``.

Es posible utilizar MerbAuth con cualquier objeto como objeto usuario,
siempre y cuando el valor de ese objeto no sea 'false' y pueda
ser serializado hacia y desde la sesión.

Por ultimo, merb-auth es muy potente principalmente por su capacidad de
"encadenar estrategias".
Puedes añadir tantas estrategias como quieras y serán intentadas una tras otra
hasta encontrar finalmente una que funcione (acceso), o descubrir que no ha
sido exitosa ninguna (intento fallido).

Una estrategia de autenticación es simplemente una forma de autenticar una
solicitud (request).
Ejemplos de estrategías serían:

* Salted user (el usuario inicia sesión con su password utilizando una
encriptación "salada")
* OpenID
* API key/token
* Autenticación básica HTTP


### merb-auth-more

[merb-auth-more][] añade característcas extras a merb-auth-core.
La gema ofrece una serie de estrategias genéricas y mixins para el objeto "User"

Estrategias:

* formulario de usuario o email y contraseña (también conocida como
password\_form)
* autenticación básica HTTP (también conocida como basic\_auth)
* OpenID


Mixins:
* 'salted user' para ActiveRecord
* 'salted user' para DataMapper
* 'salted user' para relaxdb
* 'salted user' para sequel

El módulo mixin 'salted user' proporciona autenticación básica con contraseña
'salada' SHA1.
El módulo implementa el método requerido User.authenticate para ser usado con
las estrategias de contraseña predeterminadas.

### merb-auth-slice-password

[merb-auth-slice-password][] es un slice de Merb muy sencillo.
El slice proporcionará a los desarrolladores funcionalidades básicas de inicio y
fin de sesión.
Por defecto también incluirá la autenticación basada en formularios y la
autenticación básica.

Por defecto la slice cargará las estrategias ``password\_form``
y ``basic\_auth``.

Las vistas y estrategias pueden ser personalizadas como se se explica en el
ejemplo 'Hola Mundo - Autenticado'


## Autenticación en Merb Stack

Cuando generas una aplicación con la pila predeterminada de
merb[^merb-stack-app],
merb-auth está ya configurada para ser utilizada normalmente.

Si no quieres utilizarla, simplemente comenta la dependencia de merb-auth en
config/dependencies.rb


## Hola Mundo Autenticado


### Generar una aplicación

El primer paso es generar la aplicación utilizando la pila Merb.

    $ merb-gen app hello_world
    $ cd hello_world
{:lang=shell html_use_syntax=true}

Esto genera una aplicación vacia, con la autenticación ya configurada.
Los elementos básicos son:

    app/models/user.rb

    merb/merb-auth/setup.rb
    merb/merb-auth/strategies.rb
{:lang=ruby html_use_syntax=true}

La configuración de la autenticación de usuarios por defecto es proveida usando
usuario y contraseña.
Por supuesto antes tienes que configurar la base de datos y añadir un usuario.


    $ rake db:automigrate
    $ merb -i
    >> u = User.new(:login => "login_name")
    >> u.password = u.password_confirmation = "sekrit"
    >> u.save
{:lang=ruby html_use_syntax=true}


### Generar algo que proteger

Ahora que tenemos una aplicación y un usuario, necesitamos algo que proteger.

    $ merb-gen controller hello_world
{:lang=ruby html_use_syntax=true}

Pongamos algo en el controlador.

    class HelloWorld < Application
      def index
        "Hola mundo"
      end
    end
{:lang=ruby html_use_syntax=true}

Si inicias el merb ahora y vas a <http://localhost:4000/hello_world>
verás que devuelve "Hola mundo".

### Proteger la ruta

Todavía no está protegido, así que arreglemoslo.
Podemos o protegerlo en las rutas en ``config/router.rb`` o en la acción del
controlador.
Tomemos primero la opción del router.

Abre para editar ``config/router.rb``:

    Merb::Router.prepare do
      authenticate do
        match("/hello_world").to(:controller => "hello_world")
      end
    end
{:lang=ruby html_use_syntax=true}

Esto causará que el usuario tenga que iniciar sesión.
Esto es descubierto en el enrutador (router) y cuando falla, se detiene allí. (???)
Intenta acceder a <http://localhost:4000/hello_world> ahora.
¡Verás que necesitas iniciar sesión para acceder!

Bien.  Termina la sesión usando <http://localhost:4000/logout>


### Proteger el controlador

Ahora quitemos el codigo del router, y pongamos la protección en el
controlador.
Esto permitirá por ejemplo un control más fino sobre los recursos.


    Merb::Router.prepare do
     match("/hello_world").to(:controller => "hello_world")
    end
{:lang=ruby html_use_syntax=true}

Pongámoslo ahora dentro del controlador:

    class HelloWorld < Application

      before :ensure_authenticated

      def index
        "Hola mundo"
      end

    end
{:lang=ruby html_use_syntax=true}


Para acceder al usuario conectado actualmente desde el controlador usa:

    session.user
{:lang=ruby html_use_syntax=true}

Realmente... Para una autenticación básica "Hola Mundo", esto es todo.


### Sobrescribir las vistas predeterminadas

Si necesitas más personalización, puedes hacer:


    rake slices:merb-auth-slice-password:freeze:views
{:lang=ruby html_use_syntax=true}

Lo que esto hará es copiar las vistas desde la slice a la carpeta ``slices`` de
tu aplicación.

Entonces solo necesitas copiar o mover las plantillas a tu carpeta ``app/views``
y editarlas.


[^merb-stack-app]: merb-gen app hello\_world

## Probando un solicitud autenticada

Para probar una solicitud que necesita ser autenticada, necesitarás primero
iniciar la sesión.
La forma mas fácil de iniciar la sesión cuando estás ejecutando una
especificación (spec) es utilizar un método helper.

Aquí tenemos un ejemplo de dos 'helpers' añadidos a ``spec/spec\_helper.rb``.

    Merb::Test.add_helpers do

      def create_default_user
        unless User.first(:login => "krusty")
          User.create( :login => "krusty",
                       :password => "klown",
                       :password_confirmation => "klown") or raise "no puedo crear usuario"
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

El primer helper crea un usuario predeterminado a menos que ya exista.
El segundo helper envía una solicitud de inicio de sesión utilizando los
atributos del usuario predeterminado.
Observa que la acción de inicio de sesión (login) utiliza el verbo PUT de HTTP.

Ahora que has añadido estos 'helpers', solo necesitas modificar ligeramente tus
ejemplos:

    before(:each) do
      login
      @response = request(resource(:articles))
    end
{:lang=ruby html_use_syntax=true}

En el ejemplo anterior, la solicitud enviada a la URI de articulos será
autenticada.

[Adam French]:      <http://adam.speaksoutofturn.com>
[merb-auth]:        <http://github.com/wycats/merb/tree/master/merb-auth>
[merb-auth-core]:   <http://github.com/wycats/merb/tree/master/merb-auth/merb-auth-core>
[merb-auth-more]:   <http://github.com/wycats/merb/tree/master/merb-auth/merb-auth-more
[merb-auth-slice-password]: <http://github.com/wycats/merb/tree/master/merb-auth/merb-auth-slice-password>

*[API]: Application Programming Interface
