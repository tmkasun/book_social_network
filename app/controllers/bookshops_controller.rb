class BookshopsController < ApplicationController

  def view

    credential_id = params[:credential_id]
    begin
      bookshop = Credential.find(credential_id).login
      server_response  = bookshop
    rescue ActiveRecord::RecordNotFound => error
      server_response = {credential_id: -1}
    end
    render json: server_response       

  end

  def update
    message = "Bookshop update page params \n#{params}"
    render json: message
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
    
    new_bookshop = Bookshop.create(name: name, location: location)
    new_bookshop_credential = new_bookshop.create_credential(username: username, password: password)
    
    if new_bookshop_credential.id.blank?
      new_bookshop.destroy!
      render json: server_response 
      return false
    end    
    server_response["credential_id"] = new_bookshop_credential.id
    render json: server_response

  end

end
