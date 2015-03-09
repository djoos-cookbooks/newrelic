* ```Chef::Exceptions::Service occurred in delayed notification: service[apache2] (/tmp/kitchen/cookbooks/newrelic/providers/agent_php.rb line 61) had an error: Chef::Exceptions::Service: service[apache2]: unable to locate the init.d script!```  

-- This is a result of notifies against service[apache2]  
-- Currenly commented out notifies for POC






