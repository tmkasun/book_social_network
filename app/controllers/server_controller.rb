class ServerController < ApplicationController
  def test
    render json: params
  end
end
