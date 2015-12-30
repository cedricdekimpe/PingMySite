require "dotenv-schema"
require "thor"
require "curb"
require "slack-notifier"

Dotenv.load

class PingMySite < Thor
  option :follow_location, type: :boolean, default: false
  option :expected_status_code, type: :numeric, default: 200

  desc "ping URL", "ping to URL"
  def ping(url)
    response_code = get_response_code(url)
    if response_code.to_i == options[:expected_status_code]
      # Everything's fine
      puts "Sucessfully ping #{url} with expected status code #{options[:expected_status_code]}"
    else
      message = "Unable to ping #{url} with expected status code #{options[:expected_status_code]} - Received #{response_code} instead"
      puts "Something went wrong, we must notify someone"
      notify(message)
    end
  end

  no_commands do

    def get_response_code(url)
      request(url).response_code
    end

    def request(url)
      @request ||= Curl::Easy.new(url) do |curl|
        curl.follow_location = options[:follow_location]
      end
      @request.perform
      @request
    end

    def notify(message)
      notifier = Slack::Notifier.new ENV['SLACK_WEBHOOK_URL']
      notifier.username = "Ping My Site"
      notification = notifier.ping(message)
      
      if notification.response.code.to_i == 200
        puts "Successfully notified to Slack"
      else
        puts "Something went wrong when trying to notify Slack"
      end
    end

  end
end

PingMySite.start(ARGV)
