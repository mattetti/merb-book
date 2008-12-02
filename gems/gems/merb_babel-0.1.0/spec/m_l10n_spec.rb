require File.dirname(__FILE__) + '/spec_helper'

describe "ML10n" do
  include ML10n
  
  before(:each) do
    @lang_test_path = File.expand_path(File.dirname(__FILE__) + "/lang")
    @lang_test_path_2 = File.expand_path(File.dirname(__FILE__) + "/other_lang_dir")
    reset_localization_files_and_dirs!
  end
  
  it "should have a list of localization directories" do
    localization_dirs.should == Merb::Plugins.config[:merb_babel][:localization_dirs]
  end
  
  it "should be able to add a new localization directory" do
    add_localization_dir(@lang_test_path)
    localization_dirs.include?(@lang_test_path)
  end
  
  it "should have a list of localization source files" do
    localization_files.should == []
    add_localization_dir(@lang_test_path)
    localization_files.include?("#{@lang_test_path}/en.yml").should be_true
    localization_files.include?("#{@lang_test_path}/en-US.yml").should be_true
  end
  
  it "should load localization files and have them available" do
    add_localization_dir(@lang_test_path)
    load_localization!
    localizations['en'][:right].should == 'right'
    localizations['en'][:left].should == 'left'
    localizations['en']['US'][:greetings].should == 'Howdie'
  end
  
  it "should load more localization files and have them available" do
    add_localization_dir(@lang_test_path)
    load_localization!
    localizations['en'][:right].should == 'right'
    localizations.has_key?('fr').should be_false
    
    add_localization_dir(@lang_test_path_2)
    load_localization!
    localizations['en'][:right].should == 'right'
    localizations.has_key?('fr').should be_true
    localizations['fr'][:right].should == 'la droite'
    localizations['fr'][:left].should == 'la gauche'
    localizations['fr'][:greetings].should == 'Salut'
  end
  
end