Merb.logger.info("Compiling routes...")
Merb::Router.prepare do

  match('/table-of-content').to(:controller => 'pages', :action => 'index').name(:toc)
  match("/:chapter(/:page_name)").to(:controller => 'pages', :action => 'show').name(:page)
  #default_routes
  
  match('/').to(:controller => 'pages', :action => 'index')
end