class BookshopsController < ApplicationController

  def view
    message = "Bookshop view page params \n#{params}"
    render json: message
  end

  def update
    message = "Bookshop update page params \n#{params}"
    render json: message
  end

  def signup

    message = "Bookshops signup page params \n#{params}"
    render json: message
  end

end
