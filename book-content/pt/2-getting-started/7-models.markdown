#Models

Genericamente falando, models são uma representação programática dos conceitos e dados utilizados por uma aplicação. Numa aplicação de blog, seriam coisas como posts, comentários e usuários. Em uma loja eles poderiam ser produtos, clientes, carrinhos de compra, vendas etc.... O Merb foi projetado de modo a dar bastante liberdade aos desenvolvedores para descrever seus modelos. Os models podem ser qualquer coisa que o desenvolvedor possa representar através de classes Ruby.

Tendo dito isto, a grande maioria das aplicações utilizará algum tipo de ORM (do inglês Object Relational Mapper - Mapeamento Objeto Relacional) para persistir dados entre requisições, e a maioria irá armazenar seus dados em algum banco de dados. Por default, o Merb utiliza o DataMapper comunicando-se com um banco de dados SQLite. Esta é uma excelente escolha para facilitar o desenvolvimento de novos projetos. Uma vez em produção, entretanto, geralmente é recomendado que os desenvolvedores façam a transição para um dos engines de banco de dados mais poderosos como o Postgres ou MySQL. Projetos que estejam vindo do mundo Rails podem querer manter seus models ActiveRecord, e o Merb também irá suportar esta configuração.

O resto deste capítulo irá focar no uso do DataMapper para criar classes de Models.

## Atributos

## Associações

## Callbacks
