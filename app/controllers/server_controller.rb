class ServerController < ApplicationController
  def test
    render  json: Credential.last

  end
end
