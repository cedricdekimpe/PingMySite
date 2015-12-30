require './lib/ping-my-site'
$TESTING = true # Override $TESTING - this line must stay below the ```require '.lib/ping-my-site'``

describe PingMySite do

  let(:shell){ Thor::Base.shell.new }

  describe "output" do
    # Dummy test
    specify { expect { print('foo') }.to output('foo').to_stdout }

    # HTTP 200 successful test
    specify { expect { PingMySite.start(%w[ping http://www.greenlab-coworking.com], shell: shell) }.to output("Sucessfully ping http://www.greenlab-coworking.com with expected status code 200\n").to_stdout }
    
    # HTTP 404 unsuccessful test
    specify { expect { PingMySite.start(%w[ping http://www.greenlab-coworking.com --expected-status-code 404], shell: shell) }.to output("Something went wrong, we must notify someone\n").to_stdout }

    # HTTP 301 successful test
    specify { expect { PingMySite.start(%w[ping http://13pixels.be --expected-status-code 301 --follow-location false --expected-redirect-url http://www.13pixels.be], shell: shell) }.to output("Sucessfully ping http://13pixels.be with expected status code 301\nSucessfully redirect http://13pixels.be to http://www.13pixels.be with status 301\n").to_stdout }
  end
end
