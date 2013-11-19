class UsersController < ApplicationController
  
  def login
    message = "user loging page params \n#{params}" 
    render json: message 
  end

  def view
    message = "user view page params \n#{params}" 
    render json: message 
  end

  def update
    message = "user update page params \n#{params}"
    render json: message
  end

  def show_library
    message = "user show_library page params \n#{params}"
    render json: message
  end

  def show_wishlist
    message = "user show_wishlist page params \n#{params}"
    render json: message
  end

  def add_to_wishlist
    message = "user add_to_wishlist page params \n#{params}"
    render json: message
  end

  def add_to_library
    message = "user add_to_library page params \n#{params}"
    render json: message
  end

  def foo
    message = "user foo page params \n#{params}"
    render json: message
  end

end
