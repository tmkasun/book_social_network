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
    credential_id = params[:credential_id]
    library_user = Credential.find(credential_id).login
    user_interests = library_user.interests.where(read: true)
    library_book = {}
    server_response = {library: []}    
    user_interests.each do |interest|
      library_book["title"] = interest.book.title
      library_book["author"] = interest.book.author
      library_book["rating"] = interest.rating
      library_book["category"] = interest.category
      library_book["isbn"] = interest.book.isbn
      server_response[:library].push(library_book)
    end
    
    render json: server_response    
  end

  def show_wishlist
    credential_id = params[:credential_id]
    wishlist_user = Credential.find(credential_id).login
    user_interests = wishlist_user.interests.where(read: false)
    wishlist_book = {}
    server_response = {wishlist: []}    
    user_interests.each do |interest|
      wishlist_book["title"] = interest.book.title
      wishlist_book["author"] = interest.book.author
      wishlist_book["interest_id"] = interest.id
      server_response[:wishlist].push(wishlist_book)
    end
    
    render json: server_response
  end

  def add_to_wishlist
    title = params["title"]
    author = params["author"]
    
    credential_id = params["credential_id"]
    
    user = Credential.find(credential_id).login
    new_book = Book.create(title: title, author: author)
    user.books << new_book 
  end
  
  def add_to_library
    title = params["title"]
    isbn = params["isbn"]
    author = params["author"]
    
    category = params["category"]
    rating = params["rating"]
    
    credential_id = params["credential_id"]
    
    user = Credential.find(credential_id).login
    new_book = Book.create(title: title, isbn: isbn, author: author)
    user.interests.create(book_id: new_book.id, category: category, rating: rating, read: true) if new_book.valid?
    existing_book = Book.find_by_isbn(isbn)
    user.interests.create(book_id: existing_book.id, category: category, rating: rating ,read: true)
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
