class UsersController < ApplicationController
  
  def login

    puts params # debug info

    username = params[:username]
    password = params[:password]

    puts "username = #{username}, password = #{password}" # debug info
    
    server_response = {credential_id: -1}
    authenticate_user = Credential.find_by_username(username)
    if authenticate_user.blank? or not (authenticate_user.password.eql? password) 
      render json: server_response
      return false
    end 
    server_response[:credential_id] = authenticate_user.id
    render json: server_response
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
  
  def signup
    
    puts params
    render json: "This is user signup page client params = #{params}"
   
  end
end
