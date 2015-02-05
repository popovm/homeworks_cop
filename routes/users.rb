get '/users/new' do
  haml :'registration', layout: :application
end

get '/login' do
  @wrong = false
  haml :'login', layout: :application
end

post "/login" do
  @user = User.find_by_email(params[:email])
  if @user and @user.authenticate(params[:password])
    session[:user_id] = @user.id
    haml :'login_success', layout: :application
  else
    @user = nil
    @wrong = true
    haml :'login', layout: :application
  end
end

get "/logout" do
  session[:user_id] = nil
  @user = nil
  haml :'home', layout: :application
end

post '/users/create' do
  begin
    raise ArgumentError if params['password'] != params['password_confirmation']

    @new_user = User.new
    @new_user.email = params['email']
    @new_user.name = params['name']
    @new_user.faculty_number = params['fn']
    @new_user.password = params['password']
    @new_user.role = params['role']
    @new_user.save

    haml :'registration_success', layout: :application
  rescue
    haml :'registration', layout: :application
  end
end

def logged_user?
  session[:user_id] != nil
end

post '/profile/change_password' do
  @user.password = params['new_password']
  @user.save!
  haml :'password_updated', layout: :application
end
