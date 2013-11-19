class SchoolsController < ApplicationController

  def view
    message = "School view page params \n#{params}"
    render json: message
  end


  def update
    message = "School update page params \n#{params}"
    render json: message
  end

end
