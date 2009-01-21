# Obtención y manipulación de datos
## Encontrando entradas en la base de datos
El uso de corchetes permitirá la obtención de un solo objeto.
Una llave primaria debe ser utilizada como parámetro
o también una colección, la cual es utilizada como un conjunto de condiciones.
    
    $ merb -i
    >> Artículo[1]
    => #<Artículo @values={:publicado => false, 
				 :cuerpo => "Esto es un artículo no publicado.", 
				 :id => 1, :titulo => "Primer artículo"}>    
    >> Artículo[:titulo => 'Primer artículo']
    => #<Artículo @values={:publicado => false, 
				 :cuerpo => "Esto es un artículo no publicado.", 
				 :id => 1, :titulo => "Primer artículo"}>
{:lang=shell html_use_syntax=true}
    
La instrucción ``Articulo.all`` retornará un conjunto de objetos ``Articulo``,
los cuales corresponderán a todas las entradas existentes en la respectiva tabla.

El modelo utilizado en Sequel es tratado como un conjunto de datos de Sequel.
Todos los métodos de selección y refinamiento disponibles en el conjunto de datos Sequel
pueden ser utilizados con el modelo Sequel.
A fin de simplificar los siguientes ejemplos, 
se mostrara el código de las consultas SQL generado por ``Sequel::Model``.

    $ merb -i
    >> Artículo.all
     ~ SELECT * FROM `artículos`     
    >> Artículo.filter(:publicado => true).all
     ~ SELECT * FROM `artículos` WHERE (`publicado` = 't')
    >> Artículo.exclude(:publicado => true).all
     ~ SELECT * FROM `artículos` WHERE (`publicado` != 't')
    >> Artículo.order(:created_at.desc).paginate(2, 10).all
      ~ SELECT * FROM `artículos` ORDER BY `created_at` DESC LIMIT 10 OFFSET 10
{:lang=shell html_use_syntax=true}
      
## Creando entradas en la base de datos

    >> artículo = Artículo.create(:titulo => 'Segundo artículo', 
				      :cuerpo => 'Otro artículo para algo.')
    => #<Artículo @values={:publicado => false, 
				 :cuerpo => "Otro artículo para algo.", 
				 :id => 2, :titulo => "Segundo artículo"}>
    >> artículo.new?
    => false
{:lang=shell html_use_syntax=true}

## Actualizando entradas en la base de datos

    >> artículo = Artículo[2]
    => #<Artículo @values={:publicado => false, 
				 :cuerpo => "Otro artículo para algo.", 
				 :id => 2, :titulo => "Segundo artículo"}>
    >> articulo.update(:titulo => 'Titulo reemplazado')
    => #<Articulo @values={:publicado => false, 
				 :cuerpo => "Otro artículo para algo.", 
				 :id => 2, :titulo => "Título reemplazado"}>
{:lang=shell html_use_syntax=true}
    
## Destruyendo entradas en la base de datos

    >> artículo = Articulo[2]
    => artículo.destroy
    >> artículo.exists?
    => false
{:lang=shell html_use_syntax=true}
    
La destrucción en masa de las entradas también esta disponible.
    
    # Este método destruirá toda la información relacionada con el objeto
    >>Artículo.filter(:user_id => 3).destroy
    
    # Este método es mas rápido, porque solamente destruirá la información
    # del objeto existente en una sola tabla mediante la ejecución de una
    # sola consulta hacia la base de datos.
    >>Artículo.filter(:user_id => 3).delete
{:lang=shell html_use_syntax=true}

La manera mas simple de observar las 
acciones mencionadas anteriormente en acción
es mediante la generación de un recurso y
de observar el código generado en dicho control.
