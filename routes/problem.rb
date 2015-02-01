get '/problems' do
  @problems = Problem.where(author_id != @user.id)
  haml: :'problems'
end

get '/problems/new' do
  haml: :'new_problem'
end

post '/problems/create' do
  @problem = Problem.new
  @problem.author_id = @user.id
  @problem.name = params['name']
  @problem.description = params['description']
  @problem.save!
  return "Problem uploaded"
end

post '/solutions/update' do
  @problem = Problem.find(id)
  @problem.name = params['name']
  @problem.description = params['description']
  @problem.save!
  return 'problem updated'
end

get '/solutions/:id' do
  @problem = Problem.find(id)
  haml: :'problem'
end

delete '/problems/:id' do
  @problem = Problem.find(params['id'])
  @problem.destroy!
  return "Problem destroyed!"
end