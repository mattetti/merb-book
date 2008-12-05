# Generate an application
Merb comes with a generator (<tt>merb-gen</tt>) in order to create Merb applications. The generator can generate different types of Merb applications, to see all the generator options available type

    $ merb-gen -h
## Types
The different application structures you can generate are, <tt>very_flat</tt>, <tt>flat</tt>, <tt>core</tt> and <tt>app</tt>.

### Very Flat
A Very Flat application is is similar to other Ruby micro frameworks, where the entire application is in one file.

    $ merb-gen very_flat my-applcation

To run a very flat application you start up Merb with the following command (within your application directory):

    $ merb -I my-applcation.rb

This will start Merb and bind it to the default port 4000. To see your application in action, visit [http://localhost:4000/](http://localhost:4000/).

### Flat


### Core


### App
The opinionated Merb stack
