# Autenticación

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

> Las responsabilidades de un sistema de Autenticación es probar que la identidad
> que un usuario reclama es, en efecto, su identidad real. Hay un gran número de enfoques 
> que un sistema de Autenticación puede utilizar para ello, incluyendo hosts confiables, 
> verificación de contraseñas, redes de confianza (como 'OpenId').
> Después de que la verificación haya ocurrido, las responsabilidades del sistema
> de Autenticación han terminado.
> [Adam French][]{: .quote-author}
{: cite=http://adam.speaksoutofturn.com/post/57615195/entication-vs-orization .lead-quote}

## Gemas de Merb-auth
[merb-auth][] es una meta-gema.
Una meta-gema es una gema de Ruby sin ningún código.
Su único propósito es declarar dependencias y facilitar la instalación.

A partir de Merb 1.0.x, [merb-auth][] utiliza 3 gemas:

* [merb-auth-core][]
* [merb-auth-more][]
* [merb-auth-slice-password][]

### merb-auth-core

[merb-auth-core][] no intenta imponer qué 
modelo de usuario usted debería utilizar,
o como debería realizar la autenticación.
De lo contrario, este se centra en la lógica requerida 
para comprobar que un objeto pasa la autenticación 
y en almacenar las claves de los objetos autenticados en la sesión.

Este es, de hecho, el principio que guía ``merb-auth``.
La Sesión es usada como lugar para la autenticación,
con una aspersión de los ayudantes del controlador.

Usted puede elegir proteger una acción 
de un controlador, una ruta o grupos de rutas.
Esta es la razón usted habrá oído 
a la gente referirse a una sesión autenticada.

``merb-auth`` utiliza las facilidades en el manejo de excepciones de Merb,
que retornaran los código de estado HTTP correctos.
Al fallar o forzar un inicio de sesión en cualquier punto del código de su controlador,
se generara una excepción de tipo ``Unauthenticated`` (con un mensaje opcional)
y se le presentará al usuario la página de inicio de sesión.
Esta página de inicio de sesión es, de hecho, 
la plantilla de la vista para la acción ``Extensions#unauthenticated``.

Es posible utilizar ``merb-auth`` con cualquier objeto como un objeto usuario,
siempre y cuando el objeto en cuestión no sea evaluado como falso
y este puede ser serializado hacia y desde la sesión.

Finalmente, ``merb-auth`` obtiene gran poder debido 
a su capacidad para "encadenar estrategias".
Usted puede agregar tantas estrategias como desee;
ya que estas serán intentadas una tras otra hasta encontrar 
una estrategia que funcione (inicio de sesión) 
o que ninguna estrategia haya sido exitosa (intento fallido).

Una estrategia de autenticación es simplemente una forma de autenticar una petición.
A continuación se le presentara un ejemplo de este tipo de estrategias:

 * usuario salado (el usuario inicia la sesión con su contraseña usando una encriptación "salada")
 * OpenID
 * llave/símbolo de una API
 * Autenticación HTTP básica

### merb-auth-more
[merb-auth-more][] agrega características adicionales a ``merb-auth-core``.
Esta gema ofrece una serie de estrategias genéricas y "mixins" para el objeto "Usuario".

Estrategias:

 * formulario de contraseña para inicio de sesión o e-mail (también conocida como ``password\_form``)
 * autenticación HTTP básica (también conocida como ``basic\_auth``)
 * OpenID

Mixins:

 * 'usuario salado' para ActiveRecord
 * 'usuario salado' para DataMapper
 * 'usuario salado' para RelaxDB
 * 'usuario salado' para Sequel

El módulo mixin 'usuario salado' proporciona 
autenticación básica con contraseña 'salada' del tipo SHA1.
Este módulo implementa el método requerido ``Usuario.authenticate`` 
para ser usado con las estrategias de contraseña por defecto.

### merb-auth-slice-password
[merb-auth-slice-password][] es una rodaja sencilla de Merb; 
la cual proporciona las funcionalidad tales como inicio y fin de una sesión,
ademas de incluir la autenticación basada en formularios y autenticación básica.

Por defecto, la rodaja cargará las estrategias ``password\_form``
y ``basic\_auth``.

Usted puede personalizar tanto las vistas como las estrategias, 
tal cual se ha explicado en el ejemplo "Hola mundo autenticado".

## Autenticación en el stack Merb
Cuando usted genera una aplicación con el stack Merb por defecto[^merb-stack-app],
la librería ``merb-auth`` se encuentra ya configurada para su uso normal.

En el caso que usted no desee utilizar esta librería,
debe simplemente comentar la dependencia a la misma 
en el archivo ``config/dependencies.rb``.

## Hola Mundo Autenticado

### Generar una aplicación
El primer paso a realizar es generar su aplicación, usando el stack Merb.

    $ merb-gen app hola_mundo
    $ cd hola_mundo
{:lang=shell html_use_syntax=true}

Esto generara el esqueleto de su aplicación, con la autenticación ya configurada.
Los elementos básicos son los siguientes

    app/models/usuario.rb
    merb/merb-auth/setup.rb
    merb/merb-auth/strategies.rb
{:lang=ruby html_use_syntax=true}

Por defecto, la configuración para la autenticación de usuarios ya esta preparada,
usando una contraseña y una cuenta para iniciar la sesión.
Por supuesto, usted debe configurar la base de datos y crear un usuario previamente. 

    $ rake db:automigrate
    $ merb -i
    >> usuario = Usuario.new(:login => "usuario_cuenta")
    >> usuario.password = usuario.password_confirmation = "sekrit"
    >> usuario.save
{:lang=ruby html_use_syntax=true}

### Generar algo para proteger
Teniendo ya una aplicación y un usuario, 
usted necesita algo para proteger.

    $ merb-gen controller hola_mundo
{:lang=ruby html_use_syntax=true}

Creado el controlador, por favor ingrese algún método a utilizar.

    class HolaMundo < Application
      def index
        "Hola mundo"
      end
    end
{:lang=ruby html_use_syntax=true}

Si usted inicia su aplicación Merb y 
accede a la dirección <http://localhost:4000/hola_mundo> desde su navegador web,
podrá visualizar el resultado del método "hola mundo".

### Proteger la ruta
Su aplicación todavía no se encuentra protegida, 
pero usted puede preparar su aplicación para que acepte la autenticación.
Usted puede proceder a proteger su aplicación 
ya sea utilizando las rutas en el archivo ``config/router.rb`` o 
a través de una acción determinada del controlador.
A continuación se demostrara como proceder tomando en cuenta el primer enfoque.

Usted debe modificar el archivo ``config/router.rb`` de la siguiente manera

    Merb::Router.prepare do
      authenticate do
        match("/hola_mundo").to(:controller => "hola_mundo")
      end
    end
{:lang=ruby html_use_syntax=true}

Esto hará que el usuario requiera iniciar una sesión 
a fin de visualizar la pagina en cuestión.
El enrutador se encarga de descubrir la conexión con la acción requerida y, 
en el caso de fallas, este detendrá la visualización de la pagina deseada.

A fin de finalizar su sesión, 
usted debe acceder la dirección <http://localhost:4000/logout> desde su navegador web.

### Proteger el controlador
Ahora se procederá a suprimir el código del archivo del enrutador 
para configurar la protección a nivel del controlador.
Pro ejemplo, esto permitirá un mejor control sobre los recursos.

    class HolaMundo < Application
      before :ensure_authenticated

      def index
        "Hola mundo"
      end
    end
{:lang=ruby html_use_syntax=true}

A fin de acceder al usuario ya inicializado dentro de su controlador, 
usted debe utilizar el siguiente código

    session.user
{:lang=ruby html_use_syntax=true}

Notese que, para realizar una autenticación básica de su aplicación, 
usted ya ha escrito todo el código necesario.

### Sobrescribir las vistas predeterminadas
En el caso que desee personalizar sus vistas, 
usted puede ejecutar el siguiente comando

    $ rake slices:merb-auth-slice-password:freeze:views
{:lang=shell html_use_syntax=true}

Este comando copiara las vistas desde las rodajas 
al directorio ``slices`` de su aplicación Merb.

Entonces usted deberá ya sea copiar o mover esos archivos al directorio ``app/views``
para finalmente modificarlos a como le sea mas conveniente.

## Probando una petición autenticada
A fin de probar una petición que requiere ser autenticada, 
usted necesita iniciar una sesión en su aplicación ante todo.
La manera mas simple de iniciar su sesión 
cuando usted esta ejecutando una especificación de petición 
es usar un método de ayuda.

A continuación se le presentara un ejemplo de 
dos métodos de ayuda agregados al archivo ``spec/spec\_helper.rb``.

    Merb::Test.add_helpers do
      def crear_usuario_por_defecto
        unless Usuario.first(:login => "krusty")
          Usuario.create(:login => "krusty",
                         :password => "klown",
                         :password_confirmation => "klown") or raise "no se puede crear el usuario."
        end
      end

      def iniciar_sesion
        crear_usuario_por_defecto
        request("/iniciar_sesion", {
          :method => "PUT",
          :params => {
            :login => "krusty",
            :password => "klown"
          }
        })
      end
    end
{:lang=ruby html_use_syntax=true}

El primer método de ayuda generara un usuario por defecto si este no ha sido ya creado.
El segundo método de ayuda enviara una petición de inicio de sesión 
usando los atributos del usuario por defecto.
Observe que la acción de inicio de sesión utiliza el verbo PUT de HTTP.

Ahora que ya ha agregado estos métodos de ayuda, 
usted solo debe modificar someramente su ejemplo 

    before(:each) do
      iniciar_sesion
      @respuesta = request(resource(:articulos))
    end
{:lang=ruby html_use_syntax=true}

En el ejemplo anterior, la petición enviada a la URI de los artículos será autenticada.

[Adam French]: http://adam.speaksoutofturn.com
[merb-auth]: http://github.com/wycats/merb/tree/master/merb-auth
[merb-auth-core]: http://github.com/wycats/merb/tree/master/merb-auth/merb-auth-core
[merb-auth-more]: http://github.com/wycats/merb/tree/master/merb-auth/merb-auth-more
[merb-auth-slice-password]: http://github.com/wycats/merb/tree/master/merb-auth/merb-auth-slice-password

[^merb-stack-app]: merb-gen app hola\_mundo

*[API]: Application Programming Interface
