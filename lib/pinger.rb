class Pinger

  attr_accessor :url, 
    :expected_status_code, 
    :expected_redirect_url,
    :follow_location

  def perform
    if response_code.to_i == @expected_status_code
      # Everything's fine
      puts "Sucessfully ping #{url} with expected status code #{@expected_status_code}"
      if @expected_status_code == 301 and @expected_redirect_url
        if redirect_url == @expected_redirect_url
          # Everything's fine
          puts "Sucessfully redirect #{url} to #{@expected_redirect_url} with status #{response_code}"
        else
          message = "Unable to redirect #{url} to #{@expected_redirect_url} with expected status code #{@expected_status_code} - Received location #{redirect_url} with #{response_code} instead"   
          puts "Something went wrong, we must notify someone"
          Notifier.new(message).perform
        end
      end
    else
      message = "Unable to ping #{url} with expected status code #{@expected_status_code} - Received #{response_code} instead"
      puts "Something went wrong, we must notify someone"
      Notifier.new(message).perform
    end
  end


  def response_code
    request.response_code
  end

  def redirect_url
    request.redirect_url
  end

  def request
    @request ||= Curl::Easy.new(@url) do |curl|
      curl.follow_location = @follow_location
    end
    @request.perform
    @request
  end
end
