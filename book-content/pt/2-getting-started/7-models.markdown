#Models

Genericamente falando, models são uma representação programática dos conceitos e
dados utilizados por uma aplicação. Numa aplicação de blog, seriam coisas como
posts, comentários e usuários. Em uma loja eles poderiam ser produtos, clientes,
carrinhos de compra, vendas etc... O Merb foi projetado de modo a dar bastante
liberdade aos desenvolvedores para descrever seus modelos. Os models podem ser
qualquer coisa que o desenvolvedor possa representar através de classes Ruby.

Tendo dito isto, a grande maioria das aplicações utilizará algum tipo de [ORM][]
(do inglês Object Relational Mapper - Mapeamento Objeto Relacional) para
persistir dados entre requisições, e a maioria irá armazenar seus dados em algum
banco de dados. Por default, o Merb utiliza o DataMapper comunicando-se com um
banco de dados SQLite. Esta é uma excelente escolha para facilitar o
desenvolvimento de novos projetos.

Uma vez em produção, entretanto, geralmente é recomendado que os desenvolvedores
façam a transição para um dos engines de banco de dados mais poderosos como o
Postgres ou MySQL. Projetos que estejam vindo do mundo Rails podem querer manter
seus models ActiveRecord, e o Merb também irá suportar esta configuração.

O resto deste capítulo irá focar no uso do DataMapper para criar classes de
Models.

## Atributos

Em um modelo do DataMapper, os atributos são definidos com o método
``propriedade``. Este método recebe o nome do atributo, um tipo de dado, e um
hash de opções. Ao contrário deo ActiveRecord, um modelo DataMapper não precisa
de arquivos de migration separados (apesar das migrations serem suportadas).
Veja o exemplo de um model DataMapper típico:

    class Article
      include DataMapper::Resource
      property :id,           Serial
      property :title,        String
      property :content,      Text
      property :published_at, DateTime
    end
{:lang=ruby html_use_syntax=true}

Veja a seção [properties][] no site do DataMapper para mais detalhes.

## Validações

Você pode fazer a validação do seu model de duas maneiras diferentes. Ou você
a define ao mesmo tempo que define seus atributos, ou usa um método
``validates_*`` explicitamente. Os dois exemplos a seguir são equivalentes:

    # Using "auto-validations", defined with the property.
    class Person
      include DataMapper::Resource
      property :id,   Serial
      property :name, String,  :nullable => false
      property :age,  Integer, :length => 1..150
    end

    # Using the "validates_*" methods.
    class Person
      include DataMapper::Resource
      property :id,   Serial
      property :name, String
      property :age,  Integer

      validates_present :name
      validates_length  :age, :within => 1..150
    end
{:lang=ruby html_use_syntax=true}

Para maiores informações, veja a página de [validations][] do DataMapper.

## Associações

O DataMapper tem uma maneira bem versátil de definir as associações entre seus
models. Todos os tipos de associação são suportados, incluindo One-To-Many,
Many-To-Many, etc. As associações são configuradas usando-se os métodos ``has``
e ``belongs_to``.

Digamos, por exemplo, que você está escrevendo uma aplicação de blog. Esta
aplicação irá ter os models Article (Artigo) e Comment (Comentário). Você
construiria a associação da seguinte maneira:

    class Article
      include DataMapper::Resource
      # setup properties
      has n, :comments
    end

    class Comment
      include DataMapper::Resource
      # setup properties
      belongs_to :article
    end
{:lang=ruby html_use_syntax=true}

Isto lhe dará algums métodos adicionais para trabalhar com as associações.

    article = Article.first
    article.comments  # Retorna todos os comentários associados.
    comment = Comment.first
    comment.article   # Retorna o artigo pai.
{:lang=ruby html_use_syntax=true}

Se você der uma olhada no model Article, você irá notar o
"mítico, mágico ``n``". Este método é um atalho para ``Infinity`` e é usando
para construir a associação "has many" (possui vários).

Fazer uma associação "has one" (possui um) é tão simples quanto passar o inteiro
``1`` (um) para o método ``has``. Por exemplo:

    class Person
      include DataMapper::Resource
      # setup properties
      has 1, :coffee_cup
    end

    class CoffeeCup
      include DataMapper::Resource
      # setup properties
      belongs_to :person
    end
{:lang=ruby html_use_syntax=true}

Assim como a associação "has many", você terá alguns helpers adicionais:

    person = Person.first
    person.coffee_cup  # Retorna a xícara (cup) da pessoa (person)
    cup = CoffeeCup.first
    cup.person  # Returns o dono (person) da xícara (cup).
{:lang=ruby html_use_syntax=true}

Para alguns exemplos mais avançados, como uma associação "has many through",
veja a página [associations][] do DataMapper.

## Callbacks

Os callbacks permitem quem você "conecte" código dentro de vários métodos, para
prover funcionalidades adicionais, ou (por exemplo) garantir que uma propriedade
é formatada de uma certa maneira. O DataMapper suporta callbacks usando uma
abordagem [aspect-oriented][] e inclui (entre outros) os métods ``before`` e
``after``.

Digamos que você tem um model Comment (Comentário) e que você gostaria de ter
certeza que o propriedade ``homepage`` começa com "http://" sem precisar obrigar
a pessoa a digitar a string explicitamente. Uma maneira de fazê-lo seria:

    class Comment
      include DataMapper::Resource
      property :homepage, String

      before :save, :sanitize_homepage

      private

      def sanitize_homepage
        # If the homepage already begins with "http://", just return.
        return if homepage =~ /^http[s]?:\/\/\w/
        self.homepage = 'http://' + homepage
      end
    end
{:lang=ruby html_use_syntax=true}

Como você pôde ver, o método ``before```recebe (como símbolos) o nome do método
com o qual você ira "conectar-se" e o nome do método que irá fazer o trabalho.
Você também pode passar um bloco:

    before :save do
      # ... the monkey dance.
    end
{:lang=ruby html_use_syntax=true}

Você pode definir callback para essencialmente qualquer método, incluindo
métodos de classe. Para mais detalhes, veja a página [hooks][] do DataMapper.

[ORM]:             http://en.wikipedia.org/wiki/Object-relational_mapping
[properties]:      http://datamapper.org/doku.php?id=docs:properties
[validations]:     http://datamapper.org/doku.php?id=docs:validations
[associations]:    http://datamapper.org/doku.php?id=docs:associations
[aspect-oriented]: http://en.wikipedia.org/wiki/Aspect_oriented
[hooks]:           http://datamapper.org/doku.php?id=docs:hooks
