
newrelic_agent_php 'Install php agent' do
  app_name 'app1'
  config_file '/etc/php.d/newrelic.ini'
  startup_mode 'external'
  key '0000ffff0000ffff0000ffff0000ffff0000ffff'
  action 'upgrade'
end
