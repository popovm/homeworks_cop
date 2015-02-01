get '/users/new' do
  haml :'registration'
end

get '/login' do
  haml :'login'
end

post "/login" do
  @user = User.find_by_email(params[:email])
  if @user and @user.authenticate(params[:password])
    session[:user_id] = @user.id
  else
    return "WRONG PASS"
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
    return "SUCCESS"
  else
    haml :'registration'
  end
end