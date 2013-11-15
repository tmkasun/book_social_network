class ServerController < ApplicationController
  def test
    render json: User.all
  end
end
