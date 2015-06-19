require 'net/http'
require 'net/https'
require 'json'

# NewRelic module
module NewRelic
  # Server monitor helper module
  module ServerMonitorHelpers
    def update_alert_policy(alert_policy_id)
      api_path = 'https://api.newrelic.com/v2'
      api_alert_path = api_path + '/alert_policies'
      new_server_ids = []

      # Get the current list of server ids
      result_policy = make_api_get_request("#{api_alert_path}/#{alert_policy_id}.json")
      current_server_ids = JSON.parse(result_policy.body)['alert_policy']['links']['servers']

      # Loop 60 times waiting for the installed server to be registered on service or timeout
      60.times.each do |i|
        hostname = Mixlib::ShellOut.new('hostname').run_command.stdout
        result_servers = make_api_get_request("#{api_path}/servers.json?filter[name]=#{hostname}")

        if result_servers.is_a?(Net::HTTPSuccess)
          new_server_ids = JSON.parse(result_servers.body)['servers'].map { |s| s['id'] }
        else
          exit(-1) if i == 59
          sleep(1)
        end
      end

      result_server_put = make_api_put_request(
        "#{api_alert_path}/#{alert_policy_id}.json",
        JSON.generate(
          :alert_policy => {
            :links => {
              :servers => new_server_ids + current_server_ids
            }
          }
        )
      )

      exit(-1) unless result_server_put.is_a?(Net::HTTPSuccess)
    end

    def make_api_get_request(url)
      url = URI.parse(url)
      req = Net::HTTP::Get.new(url.to_s)
      make_api_request(url, req)
    end

    def make_api_put_request(url, body)
      url = URI.parse(url)
      req = Net::HTTP::Put.new(url.to_s)
      req.body = body
      make_api_request(url, req)
    end

    def make_api_request(url, req)
      req['X-Api-Key'] = node['newrelic']['api_key']
      req['Content-Type'] = 'application/json'
      Net::HTTP.start(url.host, url.port, :use_ssl => (url.scheme == 'https')) do |http|
        http.request(req)
      end
    end
  end
end
