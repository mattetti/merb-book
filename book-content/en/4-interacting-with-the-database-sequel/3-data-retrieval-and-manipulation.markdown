#Database Retreival and Manipulation

##Finding records
    
Square brackets will return a single object. A primary key can be passed in as parameter, or a hash, which is used as a set of conditions.
    
    $ merb -i
    >> Post[1]
    => #<Post @values={:published=>false, :body=>"This is a blog post", :id=>1, :title=>"First Post"}>
    
    >> Post[:title => 'First Post']
    => #<Post @values={:published=>false, :body=>"This is a blog post", :id=>1, :title=>"First Post"}>
    
`Post.all` will return the entire set of Post objects.  There are a number of ways to refine the query made. The Sequel model is treated like a Sequel dataset, and all of the selection and refinement methods available to a dataset can be applied to a Sequel::Model. To simplify the following examples, the SQL statements produced by Sequel::Model have been shown.

    $ merb -i
    >> Post.all
     ~ SELECT * FROM `posts`
     
    >> Post.filter(:published => true).all
     ~ SELECT * FROM `posts` WHERE (`published` = 't')

    >> Post.exclude(:published => true).all
     ~ SELECT * FROM `posts` WHERE (`published` != 't')
     
    >> Post.order(:created_at.desc).paginate(2, 10).all
      ~ SELECT * FROM `posts` ORDER BY `created_at` DESC LIMIT 10 OFFSET 10
      
