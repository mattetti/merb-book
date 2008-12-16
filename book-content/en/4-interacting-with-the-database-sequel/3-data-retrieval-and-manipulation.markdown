#Database Retreival and Manipulation

##Finding records
    
Square brackets will return a single object.
A primary key can be passed in as parameter, or a hash, which is used as a set of conditions.
    
    $ merb -i
    >> Post[1]
    => #<Post @values={:published=>false, :body=>"This is a blog post", :id=>1, :title=>"First Post"}>
    
    >> Post[:title => 'First Post']
    => #<Post @values={:published=>false, :body=>"This is a blog post", :id=>1, :title=>"First Post"}>
    
`Post.all` will return the entire set of Post objects.
The Sequel model is treated like a Sequel dataset.
All of the selection and refinement methods available to a dataset can be applied to a Sequel::Model. 
To simplify the following examples, the SQL statements produced by Sequel::Model have been shown.

    $ merb -i
    >> Post.all
     ~ SELECT * FROM `posts`
     
    >> Post.filter(:published => true).all
     ~ SELECT * FROM `posts` WHERE (`published` = 't')

    >> Post.exclude(:published => true).all
     ~ SELECT * FROM `posts` WHERE (`published` != 't')
     
    >> Post.order(:created_at.desc).paginate(2, 10).all
      ~ SELECT * FROM `posts` ORDER BY `created_at` DESC LIMIT 10 OFFSET 10
      
##The Other Three Letters in CRUD

###Create

    >> p = Post.create(:title => 'second post', :body => 'another post for something')
    => #<Post @values={:published=>false, :body=>"another post for something", :id=>2, :title=>"second post"}>
    >> p.new?
    => false

###Update

    >> p = Post[2]
    => #<Post @values={:published=>false, :body=>"another post for something", :id=>2, :title=>"second post"}>
    >> p.update(:title => 'replacement title')
    => #<Post @values={:published=>false, :body=>"another post for something", :id=>2, :title=>"replacement title"}>
    
###Delete

    >> p = Post[2]
    => p.destroy
    >> p.exists?
    => false
    
Mass deletions are also available.
    
    # This will run destruction hooks on each object
    Post.filter(:user_id => 3).destroy
    
    # This is faster, but will not run hooks.
    # It just runs a single query.
    Post.filter(:user_id => 3).delete
    
A simple way to see Sequel CRUD in action is to merb-gen a resource and view the generated controller.