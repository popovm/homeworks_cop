get '/solutions' do
  @solutions = Solution.where(author_id: @user.id)
  haml: :'solutions'
end

get '/solutions/new' do
  haml: :'new_solution'
end

post '/solutions/create' do
  @solution = Solution.new
  @solution.author_id = @user.id
  @solution.name = params['name']
  @solution.description = params['text']
  @solution.save!
  return "solution uploaded"
end

post '/solutions/update' do
  @solution = Solution.find(id)
  @solution.name = params['name']
  @solution.description = params['text']
  @solution.save!
  return 'solution updated'
end

get '/solutions/:id' do
  @solution = Solution.find(id)
  haml: :'solution'
end

delete '/solutions/:id' do
  @solution = Solution.find(params['id'])
  @solution.destroy!
  return "solution destroyed!"
end