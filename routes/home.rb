get '/' do
	haml :'home', layout: :application
end

get '/contacts' do
  haml :'contacts', layout: :application
end

get '/profile' do
  haml :'profile', layout: :application
end