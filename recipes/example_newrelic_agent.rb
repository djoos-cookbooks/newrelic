newrelic_agent 'Install agent' do
  config_file '/etc/php.d/newrelic.ini'
  startup_mode 'external'
  action 'upgrade'
end
