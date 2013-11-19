class ServerController < ApplicationController
  def test
    render  json: Credential.last

  end

  def log
    
    render text: `tail log/production.log -n 50`
  end
end
