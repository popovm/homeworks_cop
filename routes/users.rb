get '/users/new' do
  haml :'registration', layout: :application
end

before do
  @user = User.find_by_id(session[:user_id])
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
end

post '/users/create' do
  @user = User.new
  @user.email = params['email']
  @user.name = params['name']
  @user.faculty_number = params['fn']
  @user.password = params['password']
  if @user.save
    haml :'registration_success', layout: :application
  else
    haml :'registration', layout: :application
  end
end