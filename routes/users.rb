get '/users/new' do
  haml :'registration', layout: :application
end

get '/login' do
  haml :'login', layout: :application
end

post "/login" do
  @user = User.find_by_email(params[:email])
  if @user and @user.authenticate(params[:password])
    session[:user_id] = @user.id
    haml :'login_success', layout: :application
  else
    haml :'login', layout: :application
  end
end

get "/logout" do
  session[:user_id] = nil
  @user = nil
  haml :'home', layout: :application
end

post '/users/create' do
  @new_user = User.new
  @new_user.email = params['email']
  @new_user.name = params['name']
  @new_user.faculty_number = params['fn']
  @new_user.password = params['password']
  @new_user.role = params['role']
  if @new_user.save
    haml :'registration_success', layout: :application
  else
    haml :'registration', layout: :application
  end
end

def logged_user?
  session[:user_id] != nil
end

