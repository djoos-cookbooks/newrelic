require 'serverspec'

set :backend, :exec
set :path, '/opt/rbenv/shims:/opt/rbenv/bin:/opt/rbenv/plugins/ruby_build/bin:/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:$PATH'
