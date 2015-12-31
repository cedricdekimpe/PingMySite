class Notifier
  
  def initialize(message)
    @message = message
  end

  def notifier
    @notifier ||= Slack::Notifier.new ENV['SLACK_WEBHOOK_URL']
    @notifier.username = "Ping My Site"
    @notifier
  end
  
  def perform
    unless $TESTING
      notification = notifier.ping(@message)
      
      if notification.response.code.to_i == 200
        puts "Successfully notified to Slack"
      else
        puts "Something went wrong when trying to notify Slack"
      end
    else
      return "Successfully notified to Slack"
    end
  end
end
