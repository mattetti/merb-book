Merb.logger.info("Compiling routes...")
Merb::Router.prepare do
  
  # http://localhost:4000/
  # http://localhost:4000/en/
  # http://localhost:4000/fr
  # http://localhost:4000/table-of-contents
  # http://localhost:4000/en/table-of-contents
  # http://localhost:4000/getting-started/install-instructions
  # http://localhost:4000/en/getting-started/install-instructions

  match('(/:language)/table-of-contents', 
           :language => /^[a-z]{2}$/).to(:controller => 'pages', :action => 'index').name(:toc)
  
  match('(/:language)/:chapter(/:page_name)',
        :language => /^[a-z]{2}$/,
        :chapter  => /[^\/]{3,}/).to(:controller => 'pages', :action => 'show').name(:page)
  
  match('/(:language)', :language => /^[a-z]{2}$/).to(:controller => 'pages', :action => 'index')
  
  # match('(/:language)(/)', :language => /^[a-z]{2}$/).to(:controller => "pages") do
  #     match(":chapter(/:page_name)", :chapter => %r'[^/.;?]{3,}').to(:action => "show").name(:page)
  #     match("(table-of-contents)").name(:toc)
  # end
  
end