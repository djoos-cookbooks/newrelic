This is a test cookbook

## Usage

```
newrelic_agent_php 'Install' do  
  license node['newrelic']['license']  
  app_name 'test_app'  
  service_name 'httpd'
  config_file '/etc/php.d/newrelic.ini'  
  startup_mode 'external'  
end  
```  

* ```license:``` New Relic license key
* ```app_name:``` The name of the application, found in the newrelic.yml file
* ```service_name:``` Webserver service (apache2, httpd, nginx) If this is defined the install will take care of reloading the webserver. If not then the recipe will need to handle the reload.
* ```config_file:``` The New Relic php agent config file, depends on your php external configuration directory; e.g. /etc/php5/conf.d/newrelic.ini, /etc/php5/mods-available/newrelic.ini, ... Defaults to nil
* ```startup_mode:``` The newrelic-daemon startup mode ("agent"/"external"), defaults to "agent". [newrelic-daemon startup modes](https://newrelic.com/docs/php/newrelic-daemon-startup-modes)
