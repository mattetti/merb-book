# Bundling your Merb application

* This will become a table of contents (this text will be scraped).
{:toc}

## Why bundling

While you are developing on your machine, your application might be running smoothly.
Your application relies on multiple libraries/Ruby gems already installed on your machine.
While everything might work now, the same gems probably won't be available on the server you will deploy to. If you work with other developers, they might be missing dependencies or have different versions.
You might also start a new project and use install a newer version of some libraries which
might create some conflicts in your old app.

To avoid all these issues, it is recommended that you bundle/freeze you application dependencies.

## How to bundle

To bundle dependencies you need two things:
  * a config/dedendencies.rb file
  * the latest task/merb.thor tasks

If you are using an older version of Merb, you might want to remove existing merb.thor files and regenerate a newer version:
    

    $ rm -rf tasks/merb.thor
    $ merb-gen thor
{:lang=shell html_use_syntax=true}

Make sure you have a dependencies.rb file in your /config folder or create a new one.

Here is an example of a default Merb stack generated dependencies.rb file.


    # dependencies are generated using a strict version, don't forget to edit the dependency versions when upgrading.
    merb_gems_version = "1.0.7.1"
    dm_gems_version   = "0.9.10.1"

    # For more information about each component, please read http://wiki.merbivore.com/faqs/merb_components
    dependency "merb-action-args", merb_gems_version
    dependency "merb-assets", merb_gems_version  
    dependency "merb-cache", merb_gems_version   
    dependency "merb-helpers", merb_gems_version 
    dependency "merb-mailer", merb_gems_version  
    dependency "merb-slices", merb_gems_version  
    dependency "merb-auth-core", merb_gems_version
    dependency "merb-auth-more", merb_gems_version
    dependency "merb-auth-slice-password", merb_gems_version
    dependency "merb-param-protection", merb_gems_version
    dependency "merb-exceptions", merb_gems_version
 
    dependency "dm-core", dm_gems_version         
    dependency "dm-aggregates", dm_gems_version   
    dependency "dm-migrations", dm_gems_version   
    dependency "dm-timestamps", dm_gems_version   
    dependency "dm-types", dm_gems_version        
    dependency "dm-validations", dm_gems_version  

    dependency "merb_datamapper", merb_gems_version
    dependency "do_sqlite3" # If using another database, replace this
{:lang=ruby html_use_syntax=true}

Usually this file is required by your config/init.rb.


To bundle all the dependencies listed in your dependencies file, run the following command on your development machine.

    $ thor merb:gem:install
 

Make sure your local ./gems directory and ./gems/cache are added to your SCM (git for instance). 
You should also ignore ./gems/gems and ./gems/specifications.

Every time, you change the dependencies required, don't forget to rerun the command mentioned above.

The reason for doing that is that native gems need to be recompiled on your deployment platform architecture or you coworker machine.


Next time someone will install the application or you deploy it, just run the following command: 

    $ bin/thor merb:gem:redeploy

This command will install gems that are in the cache but not available locally yet.

If you're using a deployment solution like Capistrano or Vlad, you can add this step right after the code has been checked out from your SCM.