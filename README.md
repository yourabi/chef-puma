Puma Cookbook
=============

Chef cook for the puma server.

The defaults assume you are deploying with capistrano and will write all configuration and logs to the shared/puma directory... However the configuration should be flexible enough to support any deployment setup.

The cookbook will also setup scripts to support restarts and phased restarts.

By default puma_config will enable monit monitoring and log rotation via logrotate.


Requirements
------------

monit, logrotate


Usage
-----
Basic Config using defaults based off the application name:

    puma_config "app"
  
Custom config overriding app settings. In this example the configuration files and helper scripts will be placed in /srv/app/shared/puma.

    puma_config "app" do
      directory "/srv/app"
      environment 'staging'
      monit false
      logrotate false
      thread_min 0
      thread_max 16
      workers 2
    end


Issues
------
Find a bug? Want a feature? Submit an [issue here](http://github.com/yourabi/chef-puma/issues). Patches welcome!


Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.

1. Fork the repository on Github

2. Create a named feature branch (like `add_component_x`)
 
3. Write you change
 
4. Write tests for your change (if applicable)
 
5. Run the tests, ensuring they all pass

6. Submit a Pull Request using Github


License and Authors
-------------------

License: Apache

Authors: Yousef Ourabi

About: This was originally developed for use at Burstorm: http://www.burstorm.com
