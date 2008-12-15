Merb.logger.info("Compiling routes...")
Merb::Router.prepare do

  match('(/:language)/table-of-contents',
        :language => /^[a-z]{2}$/).
    to(:controller => 'pages', :action => 'index').name(:toc)

  match('(/:language)/:chapter(/:page_name)',
        :language => /^[a-z]{2}$/,
        :chapter  => /[^\/]{3,}/).
    to(:controller => 'pages', :action => 'show').name(:page)

  # default_routes

  match('/(:language)', :language => /^[a-z]{2}$/).
    to(:controller => 'pages', :action => 'index')
end