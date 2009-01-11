# Estructura del proyecto

* Esto será una tabla de contenidos (este texto será pegado).
{:toc}

La estructura típica de una nueva aplicación Merb (generada con el comando ``merb-gen app``)
es definida más o menos así:

    Directorio de la aplicación (Merb.root)
      - app
        - controllers
        - helpers
        - models
        - views
          - exceptions
          - layout
      - autotest
      - config
        - environments
      - doc
      - gems
      - merb
      - public
        - images
        - javascripts
        - stylesheets
      - spec
      - tasks

A continuación se presentará una síntesis de cada directorio y su función especifica.

## app
Este directorio es donde usted empleará la mayor parte de su tiempo, 
dado que contiene las "entrañas" de su aplicación Merb.

### controllers
Todos los controladores de su aplicación son almacenados aquí (lo cual no supone sorpresa alguna).
Los controladores son generalmente nombrados en plural.
Por ejemplo, si tiene un modelo llamado "``Pagina``", 
entonces el archivo del controlador debería de llamarse ``paginas.rb``.
Esto es simplemente una convención, de todas maneras; 
usted es libre de nombrar sus controladores a su conveniencia.
Visite la sección [controladores][] para más información.

### models
Este directorio contiene las clases de sus modelos.
Estas clases típicamente sirven como su [ORM][], 
que proveen acceso orientado a objeto a sus tablas en la base de datos.
Visite la sección [modelos][] para más información.

### views
Cualquier plantilla para las vistas serán almacenadas aquí.
Por defecto, este directorio contiene los 
subdirectorios ``exceptions`` y ``layout``.
El primero almacenará plantillas 
que están generalmente relacionadas a errores HTTP.
Por ejemplo, una nueva aplicación Merb 
contendrá la vista ``not_found.html.{erb,haml}``, 
que corresponde al código de estado 404 de HTTP.
El ultimo contendrá las plantillas de la aplicación, 
dentro de las cuales solamente las plantillas de las acciones serán mostradas.
El archivo de presentación por defecto de la aplicación 
se llama ``application.html.{erb,haml}``.
Visite la sección [vistas][] para más información.

## config
Si, lo adivinaste.
Los archivos de configuración de Merb son almacenados aquí.
El archivo ``router.rb`` contiene las [rutas][] URL de su aplicación, 
que definen la estructura, el orden y la apariencia de sus URLs.
Otro archivo importante, ``init.rb``, se encarga de la configuración base de Merb.
Aquí es donde puedes configurar su [ORM][], motor de plantillas, y plataforma de pruebas.
También puede adicionar configuraciones a medida en el ``Merb::BootLoader`` 
en sus bloques ``before_app_loads`` y ``after_app_loads``.
Otro archivo importante, ``dependencies.rb``, 
es donde usted puede definir las dependencias de su aplicación: 
otras librerías o gemas que su aplicación requiere.
Cualquier dependencia listada en ese archivo será cargada cuando su aplicación Merb arranque.

### environments
Aquí es donde todo archivo de configuración específico a algún entorno es guardado.
Existen un par de archivos típicos de configuración (en Ruby puro); 
cada uno corresponde a un entorno especifico de Merb 
(desarrollo, producción, etc.).

## gems
Cuando usted esté listo para el [despliegue][] su aplicación, 
es recomendable que [empaquete][] todas sus dependencias 
dentro del directorio de la aplicación.
El directorio ``gems`` es donde estas dependencias empaquetadas 
serán almacenadas.
Cuando inicie su aplicación, 
Merb cargará cada gema guardada en este directorio, otorgandoles prioridad por sobre las gemas del sistema.

## public
Aquí es donde usted puede almacenar los archivos "estáticos", 
tales como ``favicon.ico`` y ``robots.txt``.

### images
Cualquier imagen que sus plantillas utilicen deberán ser almacenadas aquí.

### javascripts
En el típico "stack", este directorio contiene dos archivos: 
``application.js`` y ``jquery.js``.
El stack por defecto viene empaquetado 
con la poderosa plataforma JavaScript llamada [jQuery][].

Si usted tiene pequeñas cantidades de código JavaScript específico a su aplicación, 
entonces resulta apropiado incluirlo dentro del archivo ``application.js``.
Si esto no es posible, entonces puede adicionar más archivos según sus necesidades.

### stylesheets
Siguiendo la idea de la separación de intereses, 
cualquier estilismo visual deberá ser definido en una hoja de estilos.
Cuando usted genera una aplicación Merb, 
el generador crea un archivo de hoja de estilos (llamado ``master.css``), 
el cual usted puede ajustar según sus necesidades.

## spec
Si estás usando [RSpec][] como tu plataforma de [pruebas][], 
este directorio contendrá todos los archivos de pruebas.
Por defecto, este directorio contiene dos archivos: 
el archivo ``spec.opts`` vacío, 
el cual usted puede usar para adicionar argumentos por linea de comandos a RSpec 
(añadir salida coloreada, etc.) y ``spec_helper.rb``, 
el cual usted puede ajustar a conveniencia el spec runner que utilice (entre otras cosas).

## tasks
Este directorio almacenará las tareas [thor][] de Merb.

[empaquete]: /deployment/bundle
[controladores]: /getting-started/controllers
[despliegue]: /deployment
[jQuery]: http://jquery.com/
[modelos]: /getting-started/models
[ORM]: http://en.wikipedia.org/wiki/Object-relational_mapping
[rutas]: /getting-started/router
[RSpec]: http://rspec.info/
[prueba]: /testing-your-application
[thor]: http://wiki.merbivore.com/faqs/thor
[vistas]: /getting-started/views
