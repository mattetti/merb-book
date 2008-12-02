$TESTING=true
$:.push File.join(File.dirname(__FILE__), '..', 'lib')
require "rubygems"
require "merb-core"
require File.join(File.dirname(__FILE__), "..", 'lib', 'merb_babel')

default_options = {
  :environment => 'test',
  :adapter     => 'runner',
  :session_store => 'cookie',
  :session_secret_key => '187a66e27674660418cf4499471d5a0587f360d0'
}

options = default_options.merge($START_OPTIONS || {})

Merb.disable(:initfile)
Merb.start_environment(options)

Spec::Runner.configure do |config|
  config.include Merb::Test::ViewHelper
  config.include Merb::Test::RouteHelper
  config.include Merb::Test::RequestHelper
  config.include Merb::Test::ControllerHelper
end

Merb.load_dependencies(:environment => 'test')

Merb::Router.prepare do |r|
  r.match(/\/?(en\-US|en\-UK|es\-ES|es\-AR)?/).to(:locale => "[1]") do |l|
    l.match("/tests").to(:controller => "test_controller")
  end
  r.match(/\/?(en|es|fr|de)?/).to(:language => "[1]") do |l|
    l.match("/languages").to(:controller => "language_controller")
  end
end



class TestController < Merb::Controller
  
  before :set_locale
  def index; end
end

class LanguageController < Merb::Controller
  
  before :set_language
  def index; end
end