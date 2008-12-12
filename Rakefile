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

desc "create chapter TOC, usage: rake create_chapter_tocs LANG='en'"
task :create_chapter_tocs do
  require 'maruku'
  require 'maruku/ext/div'
  
  raise "You need to pass a language code or ALL" unless ENV["LANG"]
  puts "generating chapter TOCs for language: #{ENV["LANG"]}"
  
  if ENV["LANG"] =~ /all/i
    languages = Dir["#{Merb.root}/book-content/*"].entries.map{|f| File.basename(f) unless f.include? 'markdown'}
    languages.each do |language|
      chapters = Dir["#{Dir.pwd}/book-content/#{language}/*-*"].entries.map{|f| File.basename(f)[/\d-(.*)/, 1]}
      chapters.each do |chapter|
        save_chapter_toc(chapter, language)
      end
    end
  else
    chapters = Dir["#{Dir.pwd}/book-content/#{ENV["LANG"]}/*-*"].entries.map{|f| File.basename(f)[/\d-(.*)/, 1]}
    chapters.each do |chapter|
      save_chapter_toc(chapter, ENV["LANG"])
    end
  end
end

desc "add a timestamp to the warning banner"
task :add_timestamp do
  update_msg = "<small>last update: #{Time.now.strftime("%Y-%m-%d %T %Z")}</small> "
  file = "#{Dir.pwd}/app/views/layout/application.html.erb"
  old_content = File.open(file, "r").read
  File.open(file, "w+") do |f|
     f.write old_content.gsub('<p id="warning">', "<p id='warning'>#{update_msg}")
  end
end




def generate_toc_for_chapter(chapter_name, language)
  require 'rexml/document'
  
  files = Dir["#{Dir.pwd}/book-content/#{language}/*-#{chapter_name}/*-*.markdown"].entries
  
  files.map do |page|
    page_content = File.open(page).read
    m_doc = Maruku::new(page_content)

    if m_doc.toc.section_level > 0
      page_name = page[/\/book-content\/#{language}\/.*-#{chapter_name}\/.*-(.*)\.markdown/,1]
      toc = m_doc.toc.create_toc.dup
      
      # create a new entry for the file itself
      top_ul = REXML::Element.new("ul")
      top_ul.attributes["class"] = "toc"
      top_li = REXML::Element.new("li")
      top_li_a = REXML::Element.new("a")
      top_li_a.attributes["href"] = "/#{language}/#{chapter_name}/#{page_name}"
      top_li_a.text = m_doc.attributes[:title]
      top_li << top_li_a
      top_ul << top_li
      top_li << toc
      top_ul.to_s.to_s.gsub("href='#", "href='/#{language}/#{chapter_name}/#{page_name}#")
    else
      nil
    end
  end.compact.join("\n\n").gsub("<ul style='list-style: none;'/>", "")
end

def save_chapter_toc(chapter, language)
  chapter_dir = Dir["#{Dir.pwd}/book-content/#{language}/*-#{chapter}"].entries.first
  filename = chapter_dir + "/toc.markdown"
  File.open(filename, 'w') do |f| 
    f.write( "# #{chapter}\n\n #{generate_toc_for_chapter(chapter, language)} ")
  end
end