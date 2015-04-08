This is a test cookbook


## Usage

```
newrelic_agent_php 'Install' do  
  license node['newrelic']['license']  
  app_name 'test_app'  
  config_file '/etc/php.d/newrelic.ini'  
  startup_mode 'external'  
end  
```
