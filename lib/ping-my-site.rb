require "dotenv-schema"
require "thor"
require "curb"
require "slack-notifier"

#Dotenv.load

class PingMySite < Thor
  option :follow_location, type: :boolean, default: false, desc: "Allow CURL to follow HTTP redirection"
  option :expected_status_code, type: :numeric, default: 200, desc: "A valid HTTP status code"
  option :expected_redirect_url, type: :string, desc: "A valid redirection url"

  desc "ping URL", "ping to URL"
  def ping(url)
    response_code = get_response_code(url)
    if response_code.to_i == options[:expected_status_code]
      # Everything's fine
      puts "Sucessfully ping #{url} with expected status code #{options[:expected_status_code]}"
      if options[:expected_status_code] == 301 and options[:expected_redirect_url]
        redirect_url = get_redirect_url(url)
        if redirect_url == options[:expected_redirect_url]
          # Everything's fine
          puts "Sucessfully redirect #{url} to #{options[:expected_redirect_url]} with status #{response_code}"
        else
          message = "Unable to redirect #{url} to #{options[:expected_redirect_url]} with expected status code #{options[:expected_status_code]} - Received location #{redirect_url} with #{response_code} instead"   
          puts "Something went wrong, we must notify someone"
          notify(message)
        end

      end
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

    def get_redirect_url(url)
      request(url).redirect_url
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

#PingMySite.start(ARGV)
