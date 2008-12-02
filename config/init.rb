# Go to http://wiki.merbivore.com/pages/init-rb
 
# Specify a specific version of a dependency
# dependency "RedCloth", "> 3.0"

dependency "maruku", ">= 0.5.9"
dependency "merb-assets", "~> 1.0"

#  use_orm :none
use_test :rspec
use_template_engine :erb
 
Merb::Config.use do |c|
  c[:use_mutex] = false
  #c[:session_store] = 'cookie'  # can also be 'memory', 'memcache', 'container', 'datamapper
  
  # cookie session store configuration
  #c[:session_secret_key]  = '8cea7e76dcb6c428521f22c4943b4e69430a85fa'  # required for cookie session store
  #c[:session_id_key] = '_merb-book_session_id' # cookie session id key, defaults to "_session_id"
end
 
Merb::BootLoader.before_app_loads do
  # This will get executed after dependencies have been loaded but before your app's classes have loaded.
end
 
Merb::BootLoader.after_app_loads do
  # This will get executed after your app's classes have been loaded.
  MaRuKu::In::Markdown.register_block_extension(
    :regexp => /<(sidebar|note):".*?">/,
    :handler => proc do |doc, src, context|
      first_line = src.shift_line
      first_line =~ /<(sidebar|note):"(.*?)">/
      kind, subkind = $1, $2
      lines = ["<p class='#{kind}_head'>#{$2}</p>"]

      while src.cur_line && src.cur_line !~ /<\/(sidebar|note)>/
        line = src.shift_line
        lines.push line
      end

      src.shift_line

      src = MaRuKu::In::Markdown::BlockLevelParser::LineSource.new(lines)
      children = doc.parse_blocks(src)

      context.push doc.md_el(:div, children, {}, {:class => "#{kind} #{subkind}"})

      true
    end
  )
end