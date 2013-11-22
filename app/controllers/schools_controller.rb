class SchoolsController < ApplicationController

  def view

    credential_id = params[:credential_id]
    begin
      school = Credential.find(credential_id).login
      server_response  = school
    rescue ActiveRecord::RecordNotFound => error
      server_response = {credential_id: -1}
    end
    render json: server_response       

  end


  def update
    credential_id = params[:credential_id]
    server_response = {credential_id: -1}
    
    update_school_credential = Credential.find(credential_id)
    update_school = update_school_credential.login
    
    render json: server_response and return false if Credential.find_by_username(params[:username])
   
    params[:username].blank? ? (username = update_school_credential["username"]) : (username = params[:username])
    params[:password].blank? ? (password = update_school_credential["password"]) : (password = params[:password])
    
    params[:name].blank? ? (name = update_school["name"]) : (name = params[:name])
    params[:location].blank? ? (location = update_school["location"]) : (location = params[:location])
    
    update_school_credential.update_attributes(username: username, password: password)
    update_school.update_attributes(name: name,location: location)
    
    server_response[:credential_id] = update_school_credential.id 
    render json: server_response
  end
  
  def signup 
    username = params[:username]
    password = params[:password]
    name = params[:name]
    location = params[:location]
    
    server_response = {credential_id: -1}
    
    puts params    
    
    if Credential.find_by_username username or password.length <2 #check weather the given username is already excist    
      render json: server_response 
      return false
    end
    
    new_school = School.create(name: name, location: location)
    new_school_credential = new_school.create_credential(username: username, password: password)
    
    if new_school_credential.id.blank?
      new_school.destroy!
      render json: server_response 
      return false
    end    
    server_response["credential_id"] = new_school_credential.id
    render json: server_response

  end
end
