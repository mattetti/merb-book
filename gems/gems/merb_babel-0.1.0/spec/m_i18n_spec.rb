require File.dirname(__FILE__) + '/spec_helper'
  
describe '#babelize' do
  
  before(:each) do
    Merb::Controller.send :include, Merb::GlobalHelpers
    @c = dispatch_to(TestController, :index)
    @c.add_localization_dir(File.expand_path(File.dirname(__FILE__) + "/lang"))
    @c.add_localization_dir(File.expand_path(File.dirname(__FILE__) + "/other_lang_dir"))
    @c.load_localization!
  end

  it "should babelize a word in English " do
    @c.locale.should == 'en-US'
    @c.language.should == 'en'
    @c.country.should == 'US'
    @c.babelize(:left).should == 'left'
  end
  
  it "should translate a word in English" do
    @c.t(:left).should == 'left'
    @c.translate(:left).should == 'left'
    @c._(:left).should == 'left'
  end
  
  it "should translate a word in american English" do
    @c.t(:greetings).should == 'Howdie'
  end
  
  it "should translate a word in british English" do
    @c.request.env[:locale] = 'en-UK'
    @c.t(:greetings).should == 'Heya'
  end
  
  it "should translate a word in French" do
    @c.request.env[:language] = 'fr'
    @c.t(:greetings).should == 'Salut'
  end
  
  it "should translate passing the full locale" do
    @c.t(:greetings, :language => 'en', :country => 'UK').should == 'Heya'
    @c.t(:greetings, :language => 'en', :country => 'US').should == 'Howdie'
  end
  
  it "should translate passing the language" do
    @c.t(:greetings, :language => 'fr').should == 'Salut'
  end
  
end