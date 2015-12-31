require "dotenv-schema"
require "thor"
require "curb"
require "slack-notifier"
require "notifier"
require "pinger"

$TESTING = false

class PingMySite < Thor
  option :follow_location, type: :boolean, default: false, desc: "Allow CURL to follow HTTP redirection"
  option :expected_status_code, type: :numeric, default: 200, desc: "A valid HTTP status code"
  option :expected_redirect_url, type: :string, desc: "A valid redirection url"

  desc "ping URL", "ping to URL"
  def ping(url)
    pinger = Pinger.new
    pinger.url = url
    pinger.expected_status_code  = options[:expected_status_code]
    pinger.expected_redirect_url = options[:expected_redirect_url]
    pinger.follow_location       = options[:follow_location]
    pinger.perform
  end

end
