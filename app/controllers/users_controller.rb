class UsersController < ApplicationController
  
  def login

    username = params[:username]
    password = params[:password]
    server_response = {credential_id: -1}
    authenticate_user = Credential.find_by_username(username)
    if authenticate_user.blank? or not (authenticate_user.password.eql? password) 
      render json: server_response
      return false
    end 
    server_response[:credential_id] = authenticate_user.id
    #experimental shortcut expression
    authenticate_user.login_type.eql?("User") ? server_response["user_type"] = "Basic #{authenticate_user.login_type}" : server_response["user_type"] = authenticate_user.login_type
    render json: server_response
  
  end

  def view

    credential_id = params[:credential_id]
    begin
      user = Credential.find(credential_id).login
      server_response  = user
    rescue ActiveRecord::RecordNotFound => error
      server_response = {credential_id: -1}
    end
    render json: server_response       
  end

  def update
    credential_id = params[:credential_id]
    server_response = {credential_id: -1}
    
    update_user_credential = Credential.find(credential_id)
    update_user = update_user_credential.login
    
    puts "aaaaaaaaaaaaaaaaaaaaaaaaaa\n\n\n"
    render json: server_response and return false if Credential.find_by_username(params[:username])
    puts "kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk \n\n\n"
   
    params[:username].blank? ? (username = update_user_credential["username"]) : (username = params[:username])
    params[:password].blank? ? (password = update_user_credential["password"]) : (password = params[:password])
    
    params[:firstname].blank? ? (firstname = update_user["firstname"]) : (firstname = params[:firstname])
    params[:secondname].blank? ? (secondname = update_user["secondname"]) : (secondname = params[:secondname])
    params[:location].blank? ? (location = update_user["location"]) : (location = params[:location])
    params[:dob].blank? ? (dob = update_user["dob"]) : (dob = params[:dob])
    params[:gender].blank? ? (gender = update_user["gender"]) : (gender = params[:gender])
    
    update_user_credential.update_attributes(username: username, password: password)
    update_user.update_attributes(firstname: firstname, secondname: secondname ,location: location ,dob: dob ,gender: gender)
    
    server_response[:credential_id] = update_user_credential.id 
    render json: server_response
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
    firstname = params[:firstname]
    secondname = params[:secondname]
    password = params[:password]
    location = params[:location]
    dob = params[:dob]
    gender = params[:gender]
    server_response = {credential_id: -1}
    puts params    
    if Credential.find_by_username username or password.length <2 #check weather the given username is already excist    
      render json: server_response 
      return false
    end
    
    new_user = User.create(firstname: firstname, secondname: secondname, location: location, dob: dob, gender: gender)
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
