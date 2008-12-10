require 'rubygems'
require 'rake/rdoctask'

require 'merb-core'
require 'merb-core/tasks/merb'

include FileUtils

# Load the basic runtime dependencies; this will include 
# any plugins and therefore plugin rake tasks.
init_env = ENV['MERB_ENV'] || 'rake'
Merb.load_dependencies(:environment => init_env)
     
# Get Merb plugins and dependencies
Merb::Plugins.rakefiles.each { |r| require r } 

# Load any app level custom rakefile extensions from lib/tasks
tasks_path = File.join(File.dirname(__FILE__), "lib", "tasks")
rake_files = Dir["#{tasks_path}/*.rake"]
rake_files.each{|rake_file| load rake_file }

desc "Start runner environment"
task :merb_env do
  Merb.start_environment(:environment => init_env, :adapter => 'runner')
end

require 'spec/rake/spectask'
require 'merb-core/test/tasks/spectasks'
desc 'Default: run spec examples'
task :default => 'spec'

##############################################################################
# ADD YOUR CUSTOM TASKS IN /lib/tasks
# NAME YOUR RAKE FILES file_name.rake
##############################################################################

desc "create chapter TOC"
task :create_chapter_tocs do
  
  require 'maruku'
  
  languages = Dir["#{Merb.root}/book-content/*"].entries.map{|f| File.basename(f) unless f.include? 'markdown'}
  languages.each do |language|
    chapters = Dir["#{Dir.pwd}/book-content/#{language}/*-*"].entries.map{|f| File.basename(f)[/\d-(.*)/, 1]}
    chapters.each do |chapter|
      save_chapter_toc(chapter, language)
    end
  end

end

def generate_toc_for_chapter(chapter_name, language)
  require 'rexml/document'
  
  files = Dir["#{Dir.pwd}/book-content/#{language}/*-#{chapter_name}/*-*.markdown"].entries
  
  files.map do |page|
    page_content = File.open(page).read
    m_doc = Maruku::new(page_content)

    if m_doc.toc.immediate_children.size > 0 
      page_name = page[/\/book-content\/#{language}\/.*-#{chapter_name}\/.*-(.*)\.markdown/,1]
      toc = m_doc.toc.create_toc.dup
      
      # create a new entry for the file itself
      top_li = REXML::Element.new("li")
      top_li_a = REXML::Element.new("a")
      top_li_a.attributes["href"] = "/#{language}/#{chapter_name}/#{page_name}"
      top_li_a.text = m_doc.attributes[:title]
      top_li << top_li_a
      # 
      if REXML::XPath.first( toc, "//ul/li" ) 
        top_li << toc
        top_li.to_s.to_s.gsub("href='#", "href='/#{language}/#{chapter_name}/#{page_name}#")
      else
        nil
      end
      
    else
      nil
    end
  end.compact.join("\n\n")
  
  # merged_files = files.map{|file| File.open(file).read}.join("\n")
  # toc = "\n* This will become a table of contents (this text will be scraped).\n{:toc}\n"
  # 
  # merged_files.gsub!(toc, "")
  # merged_files = toc + merged_files
  # 
  # mf = Maruku::new(merged_files)
  # list = mf.to_html[/(<div class='maruku_toc'>.*<\/li><\/ul><\/div>)/, 1]
  # 
  # list #? list.gsub("href='#", "href='") : nil
end

def save_chapter_toc(chapter, language)
  chapter_dir = Dir["#{Dir.pwd}/book-content/#{language}/*-#{chapter}"].entries.first
  filename = chapter_dir + "/toc.markdown"
  File.open(filename, 'w') do |f| 
    f.write( "# #{chapter}\n\n #{generate_toc_for_chapter(chapter, language)} ")
  end
end

# each chapter
  # each page
   # generate toc for the file  .toc.create_toc
   # gsub the links with chapter/page#anchor
   # save the toc in memory
# save it in the chapter

 