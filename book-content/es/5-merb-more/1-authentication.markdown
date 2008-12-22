# Autenticación

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

> Las responsabilidades de un sistema de Autenticación son probar que la identidad que un usuario proclama
> es realmente su identidad real. Hay un buen numero de enfoques que un
> sistema de Autenticación puede utilizar para ello, incluyendo hosts de confianza,
> verificación de contraseñas, redes de confianza (como 'OpenId').
> Despues de que la verificación ha ocurrido, las responsabilidades  del sitema de Autenticación 
> han terminado. 
> [Adam French][]{: .quote-author}
{: cite=http://adam.speaksoutofturn.com/post/57615195/entication-vs-orization .lead-quote}

## Gemas Merb-auth 

[merb-auth][] es una meta-gema.
Una meta-gema es una gema de Ruby sin ningún código.
Su único propósito es declarar dependencias y facilitar la instalación

A partir de Merb 1.0.x merb-auth usa 3 gemas:
* [merb-auth-core][]
* [merb-auth-more][]
* [merb-auth-slice-password][]

### merb-auth-core

[merb-auth-core][] no intenta imponer que modelo de usuario deberías utilizar,
o como debería autenticarse.
En lugar de ello se centra en la lógica necesaria para comprobar que un objeto
pasa la autenticación, y en almacenar las claves de los objetos autenticados
durante la sesión.

Este es de hecho el principio guía de MerbAuth.
La Sesión es usada como lugar para la autenticación,
con un número de métodos de ayuda (helpers) de controlador.

Puedes elegir proteger una acción de un controlador, o una ruta o grupos de rutas.
Esta es la razón por la que puedes oir a la gente referirse a una sesión autenticada.

MerbAuth utiliza las facilidades de gestión de excepciones de Merb que devuelven
códigos de estado HTTP correctos.
Para que falle el acceso, o para forzar un inicio de sesión en cualquier punto del código del controlador,
simplemente genera una ``Unauthenticated`` excepción, con un mensaje opcional
y al usuario se le presentará la página de inicio de sesión.
Esta página de inicio de sesión es de hecho la plantilla de la vista para ``Extensions#unauthenticated``.

Es posible utilizar MerbAuth con cualquier objeto como objeto usuario,
siempre y cuando el valor de ese objeto no sea 'false' y pueda
ser serializado hacia y desde la sesión. 

Por ultimo, merb-auth es muy potente principalmente por su capacidad de encadenar estrategias.
Puedes añadir tantas estrategias como quieras y seran intentadas una tras otra hasta encontrar
finalmente una que funcione (acceso), o descubrir que ho ha pasado ninguna (intento fallido).

Una estrategia de autenticación es simplemente una forma de autenticar una solicitud (request).
Ejemplos de estrategías serían:
* Salted user (el usuario inicia sesión con su password utilizando una encriptación "salada")
* OpenID
* API key/token
* Autenticación básica HTTP


### merb-auth-more

[merb-auth-more][] añada característcas extras a merb-auth-core.
La gema ofrece una serie de estrategias genéricas y mixins para el objeto "User"

Estrategias:
* login or email password form (aka password\_form)
* basic HTTP authentication (aka basic\_auth)
* OpenID


Mixins:
* 'salted user' para ActiveRecord
* 'salted user' para DataMapper
* 'salted user' para relaxdb
* 'salted user' para sequel

El módulo mixin 'salted user' proporciona autenticación básica con password encriptado SHA1 'salted'.
Implementa el método requerido User.authenticate para ser usado con
las estrategias de password predeterminadas.
{: .to-translate}

### merb-auth-slice-password

[merb-auth-slice-password][] es una 'Merb slice' muy sencilla.
La slice proporcionará a los desarrolladore con unas funciones de inicio y final de sesión basicas.
Por defecto también incluirá la autenticación basada en formularios y la autenticación básica.

Por defecto la slice cargará las estrategias de autorización básica y la basada en formularios.

Vistas y estrategias pueden ser personalizadas como se se explica en el
ejemplo 'Hola Mundo - Autenticado'


## Autenticación en Merb Stack

Cuando generas una aplicación con la pila predeterminadas de merb[^merb-stack-app],
merb-auth esta ya configurada para la utilización normal.

Si no quieres utilizarla, simplemente comenta la dependencia en merb-auth en 
config/dependencies.rb


## Hola Mundo Autenticado


### Generar una aplicación

El primer paso es generar la aplicación utilizando la pila Merb.

    $ merb-gen app hello_world
    $ cd hello_world
{:lang=shell html_use_syntax=true}

Esto genera una aplicación vacia, con la autenticación ya configurada.
Los elemento básicos son:

    app/models/user.rb

    merb/merb-auth/setup.rb
    merb/merb-auth/strategies.rb
{:lang=ruby html_use_syntax=true}

La configuración de la autenticación de usuarios se preocupará por defecto de 
la utilización del login y el password 
Por supuesto tienes que configurar la base de datos y añadir el usuario antes.


    $ rake db:automigrate
    $ merb -i
    >> u = User.new(:login => "login_name")
    >> u.password = u.password_confirmation = "sekrit"
    >> u.save
{:lang=ruby html_use_syntax=true}


### Generar algo que proteger

Ahora tenemos una aplicación, y un usuario, necesitamos algo que proteger.

    $ merb-gen controller hello_world
{:lang=ruby html_use_syntax=true}

Pongamos algo en el controlador.

    class HelloWorld < Application
      def index
        "Hello World"
      end
    end
{:lang=ruby html_use_syntax=true}

Si inicias el merb ahora y vas a <http://localhost:4000/hello_world>
veras los resultados "Hello world".

### Proteger la ruta

Todavía no esta protegido, así que arreglemoslo.
Podemos o protegerlo en las rutas en config/router.rb o en la acción del controlador.
Tomemos primero la opción del router.

Abre para editar config/router.rb

    Merb::Router.prepare do
      authenticate do
        match("/hello_world").to(:controller => "hello_world")
      end
    end
{:lang=ruby html_use_syntax=true}

Esto causará que el usuario tenga que iniciar sesión
Esto es descubierto en el "router" y cuando falla, para en el router.
Intenta acceder a <http://localhost:4000/hello_world> ahora.
Verás que necesitas iniciar sesión para acceder alli.

Bien!.  Logout, <http://localhost:4000/logout>


### Proteger el controlador

Ahora quitemos el codigo del 'router', y pongamos la protección an el controlador.
Esto permitirá por ejemplo un control mas fino sobre los recursos.


    Merb::Router.prepare do
     match("/hello_world").to(:controller => "hello_world")
    end
{:lang=ruby html_use_syntax=true}

Pongamolo ahora dento del controlador:

    class HelloWorld < Application

      before :ensure_authenticated

      def index
        "Hello World"
      end

    end
{:lang=ruby html_use_syntax=true}


Para acceder al usuario actualmente logueado/logado desde el controlador usa:

    session.user
{:lang=ruby html_use_syntax=true}

Realmente... Para una autenticación básica "Hola Mundo", esto es todo.


### Sobrescribir las vistas predeterminadas

Si necesitas mas personalización, puedes hacer:


    rake slices:merb-auth-slice-password:freeze:views
{:lang=ruby html_use_syntax=true}

Lo que esto hará es copiar las vistas desde la slice a la carpeta /slices/ de
tu aplicación.

Entonces solo necesitas copiar o mover las plantillas a tu carpeta /views/.
Modificar las plantillas copiadas a /app/views/ debería ahora ser considerado. 




[^merb-stack-app]: merb-gen app hello\_world

## Probando un solicitud autenticada

Para probar una solicitud que necesita ser autenticada, necesitarás primero iniciar la sesión.
La forma mas fácil de iniciar la sesión cuando estas ejecutando una especificacion (spec) es 
utilizar un metodo helper.

Aquí tenemos un ejemplo de dos 'helpers' añadidos a /spec/spec\_helper.rb

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

El primer helper crea un usuario preseterminado a menos que ya exista.
El segundo helper envia una solicitud de inicio de sesión utilizando los atributos del usuario predeterminado.
Observa que la acción de inicio de sesión (login) utiliza el verbo PUT de HTTP.


Ahora que has añadido estos 'helpers', solo necesitas modificar ligeramente tus ejemplos:

    before(:each) do
      login
      @response = request(resource(:articles))
    end
{:lang=ruby html_use_syntax=true}

En el ejemplo anterior, la solicitud enviada a la URI de articulos será autenticada.

[Adam French]:      <http://adam.speaksoutofturn.com>
[merb-auth]:        <http://github.com/wycats/merb/tree/master/merb-auth>
[merb-auth-core]:   <http://github.com/wycats/merb/tree/master/merb-auth/merb-auth-core>
[merb-auth-more]:   <http://github.com/wycats/merb/tree/master/merb-auth/merb-auth-more
[merb-auth-slice-password]: <http://github.com/wycats/merb/tree/master/merb-auth/merb-auth-slice-password>

*[API]: Application Programming Interface
