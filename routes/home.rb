get '/' do
	haml :'home', layout: :application
end

get '/contacts' do
  haml :'contacts', layout: :application
end

get '/profile' do
  if !@user.nil?
    haml :'profile', layout: :application
  else
    haml :'access_denied', layout: :application
  end
end

get '/profile/change_password' do
  if !@user.nil?
    haml :'change_password', layout: :application
  else
    haml :'access_denied', layout: :application
  end
end
