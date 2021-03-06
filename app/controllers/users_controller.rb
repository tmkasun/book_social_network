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
    
    server_response = {library: []}
    user_interests.each do |interest|
      library_book = {}
      library_book["title"] = interest.book.title
      library_book["author"] = interest.book.author
      library_book["rating"] = interest.rating
      library_book["category"] = interest.category
      library_book["isbn"] = interest.book.isbn
      library_book["interest_id"] = interest.id
      server_response[:library].push(library_book)
    end
    
    render json: server_response    
  end

  def show_wishlist
    credential_id = params[:credential_id]
    wishlist_user = Credential.find(credential_id).login
    user_interests = wishlist_user.interests.where(read: false)
    
    server_response = {wishlist: []}
    user_interests.each do |interest|
      wishlist_book = {}
      
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
    new_book = Book.create(title: title, author: author, isbn: false)
    user.books << new_book 
    
    server_response = {}
    server_response["credential_id"] = 1
    render json: server_response 
  end
  
  def add_to_library
    title = params["title"]
    isbn = params["isbn"]
    author = params["author"]
    
    category = params["category"]
    rating = params["rating"]
    
    server_response = {credential_id: -1}
    
    credential_id = params["credential_id"]
    
    user = Credential.find(credential_id).login
    new_book = Book.create(title: title, isbn: isbn, author: author)
    if new_book.valid?
      user.interests.create(book_id: new_book.id, category: category, rating: rating, read: true)
    else
      existing_book = Book.find_by_isbn(isbn)
      user.interests.create(book_id: existing_book.id, category: category, rating: rating ,read: true) 
    end
    server_response["credential_id"] = 1
    render json: server_response 
  end

  def delete_from_wishlist
    book_to_be_deleted_from_wishlist = params[:interest_id]
    server_response = {"delete" => 1}
    render json: server_response  and return true if Interest.destroy(book_to_be_deleted_from_wishlist)
    
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
  
  def friendlist
    
    server_response = {friendlist: []}
    all_users = User.select("firstname as name,location as home_town,dob,gender,id")
    all_users.each do |u|
      user = {name: u['name'], home_town: u['home_town'], dob: u['dob'], gender: u['gender'], credential_id: u.credential.id}
      server_response[:friendlist].push user
    end
    render json: server_response
    


  end

  def add_to_wishlist
    
    interest_id = params["interest_id"]
    credential_id = params["credential_id"]
    server_response = {result: 1}
    me = Credential.find(credential_id).login
    friends_interest = Interest.find(interest_id)
    me.interests.create(book_id: friends_interest.book.id,read: false, rating: 0)
    render json: server_response
    return false
  end

  def bookshops
    
    server_response = {bookshops: []}
    all_bookshops = Bookshop.select("id, name, location")
    all_bookshops.each do |bookshop|
    b_shop = {name: bookshop['name'], location: bookshop['location'], id: bookshop.id}
    server_response[:bookshops].push b_shop
    end
    render json: server_response

  end
  
  def search_library

    query = "%#{params[:query]}%"
    credential_id = params[:credential_id]
    user = Credential.find(credential_id).login
    true if Float(params[:query]) rescue false ?  users_library_books = user.books.where('isbn like ?',query) : users_library_books = user.books.where('title like ?',query)
    server_response = {library: []}
    users_library_books.each do |book|
      interest = user.interests.find_by_book_id(book.id)
      next unless interest['read']
      library_book = {}
      library_book["title"] = book.title
      library_book["author"] = book.author
      library_book["rating"] = interest.rating
      library_book["category"] = interest.category
      library_book["isbn"] = book.isbn
      library_book["interest_id"] = interest.id
      server_response[:library].push(library_book)
    end

    render json: server_response
    

  end

end
