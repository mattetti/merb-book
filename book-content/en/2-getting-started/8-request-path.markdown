#Request Path

All web applications begin with an HTTP request by a client.
They all end with a response from our server.
In this chapter, we are going to follow the program flow
from the client request through to the response.

##From the Client to Our Doorstep

The inner working of the Internet are beyond the scope of this book.
It is however helpful to remember that there is a client (web browser) out
there
and that the request it generates passes through a number of steps to reach
our servers.
Along the way proxies, caches and firewalls may look at the request, modify it,
and possibly store what we send back.
If all goes well this will be transparent to both our server and the user.
There are time, particularly with dynamic sites, where these things will need
to be taken into account.
There are also ways to take advantage of the infrastructure of the internet
that reduce the load on the server
while can save both bandwidth and equipment costs.

##Proxy Agents

The first stop for a request in a live application is usually a load ballancing
reverse proxy like [NginX][] or Apache.
Depending on the setup, these proxies may serve static files like images,
CSS style sheets, JavaScript, and even cached pages without ever interacting
with our application.

##Rack

If the request cannot be handled with static methods,
it is forwarded on to a Rack Application Server.
[Mongrel][], [GlassFish][](?) [Thin][], [Ebb][], and a number of lesser-know programs fill this
role.
These programs read the request from the network and form it into a very simple
standardized form called [Rack][].
Merb can handle requests from any server that can speak the Rack protocol.
This make it easy to switch between different application servers.

There are some fairly powerful thing that can be don with Rack Middleware such
as logging, file serving, and benchmarking.
We will not cover the use of Rack extensively here,
but you can find Merb's Rack setup in 'config/rack.rb' in the full stack app.

##Router

The Router is the first place a request hits that is within the Merb framework.
The Router's job is to use the request to find a controller,
pick which action(method) to invoke on the controller,
and set fill any additional entries in the params hash.

Behind the scenes the Merb framework has already don some things for you.
By the time a request reaches the controller, Merb has:

* Extracted the request URI Path.
* Looked through the requests Cookies and populated the cookies hash.
* Restored the session if it existed for this request.
* parsed any Post or Query data sent by the client into the params hash.

The developer can use any of this information in routing the request.
Please see the chapter on routing for more information.

##Controller

The Router finishes by making an instance of one of the controllers.
It then calls a public method on that controller.
The controller builds a response by using Model Object and view templates.
The controller can also manipulate the default response headers.
The return value of the Controller method becomes the body of the response.
Please see the chapters on [MVC][] for more information.

##Caching

If caching is enabled, the body of the response may be places somewhere where
it can be used to serve requests for the same recourse.
Caching may happen within Merb, by Rack Middleware, by a Proxy server,
or by the client web browser.

##Out the Door

Finally Merb sends a well formed rack response back to the application server.
The application server in turn formats an HTTP response which is put out over
the wire.
The client receives the response and interprets by, for example, rendering a web page.

[Mongrel]:    /need/link
[MVC]:        /getting-started/mvc
[NginX]:      /deployment/nginx
[GlassFish]:  /deployment/jruby
[Rack]:       /need/link
