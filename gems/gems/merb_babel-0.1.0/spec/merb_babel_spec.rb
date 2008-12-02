require File.dirname(__FILE__) + '/spec_helper'


describe 'using set_locale before filter, ' do
  describe 'a controller' do
  
    describe 'locale' do
    
      it "should be set by default" do
        c = dispatch_to(TestController, :index)
        c.locale.should == 'en-US'
      end
  
      it "should be able to be set by passing a param" do
        c = dispatch_to(TestController, :index, :locale => 'fr-FR')
        c.locale.should == 'fr-FR'
      end
      
      it "should be able to be set using the session" do
        c = dispatch_to(TestController, :index) do |controller|
          controller.stub!(:session).and_return( :locale => "es-BO" )
        end
        c.locale.should == 'es-BO'
      end
      
      it "should be set using an url (when the routes are set properly)" do
        #c = get('tests')
        #c.locale.should == 'en-US'
        c = get('en-US/tests')
        c.locale.should == 'en-US'
        c = get('en-UK/tests')
        c.locale.should == 'en-UK'
      end
      
      it "should support longer locales (like zh-Hans-CN)" do
        c = dispatch_to(TestController, :index, :locale => 'zh-Hans-CN')
        c.locale.should == 'zh-hans-CN'
      end
    
    end
  
    describe 'language' do 
    
      it "should be set by default" do
        c = dispatch_to(TestController, :index)
        c.language.should == 'en'
      end
  
      it "should be able to be set by passing a param" do
        c = dispatch_to(TestController, :index, :language => 'fr')
        c.language.should == 'fr'
      end
    
      it "should bet set when a locale was set by params" do
        c = dispatch_to(TestController, :index, :locale => 'fr-FR')
        c.locale.should == 'fr-FR'
        c.language.should == 'fr'
      end
      
      it "should be set when a locale was set by params even with a long locale" do
        c = dispatch_to(TestController, :index, :locale => 'zh-Hans-CN')
        c.language.should == 'zh-hans'
      end
      
      it "should bet set when a locale was set by session" do
        c = dispatch_to(TestController, :index) do |controller|
          controller.stub!(:session).and_return( :locale => "es-BO" )
        end
        c.language.should == 'es'
      end
      
      it "should be set by the router" do
        c = get('fr/languages')
        c.language.should == 'fr'
        c.locale.should == 'en-US'
        # c = get('languages')
        # c.language.should == 'en'
      end
  
    end
  
    describe 'country' do

      it "should be set by default" do
        c = dispatch_to(TestController, :index)
        c.country.should == 'US'
      end
    
      it "should be able to be set by passing a param" do
        c = dispatch_to(TestController, :index, :country => 'ES')
        c.country.should == 'ES'
      end
      
      it "should bet set when a locale was set by params" do
        c = dispatch_to(TestController, :index, :locale => 'fr-FR')
        c.country.should == 'FR'
      end
      
      it "should bet set when a locale was set by session" do
        c = dispatch_to(TestController, :index) do |controller|
          controller.stub!(:session).and_return( :locale => "es-BO" )
        end
        c.country.should == 'BO'
      end
  
    end
    
  end
end

describe 'using set_language, ' do
  describe 'a controller' do
    describe 'language' do 
    
      it "should be set by default" do
        c = dispatch_to(LanguageController, :index)
        c.language.should == 'en'
      end
  
      it "should be able to be set by passing a param" do
        c = dispatch_to(LanguageController, :index, :language => 'fr')
        c.language.should == 'fr'
      end
  
    end
  end
end
