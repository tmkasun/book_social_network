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
    username = params[:username]
    first_name = params[:firstname]
    last_name = params[:secondname]
    password = params[:password]
    location = params[:location]
    date_of_birth = params[:dob]
    gender = params[:gender]
    server_response = {credential_id: -1}
    puts params    
    if Credential.find_by_username username or password.length <2 #check weather the given username is already excist    
      render json: server_response 
      return false
    end
    
    new_user = User.create(first_name: first_name, last_name: last_name, location: location, date_of_birth: date_of_birth, gender: gender)
    new_user_credential = new_user.create_credential(username: username, password: password)
    
    if new_user_credential.id.blank?
      new_user.destroy!
      render json: server_response 
      return false
    end    
    server_response["credential_id"] = new_user_credential.id
    render json: server_response

  end

end
