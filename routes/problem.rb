get '/problems' do
  @problems = Problem.where(author_id != @user.id)
  haml :'problems', layout: :application
end

get '/problems/new' do
  haml :'new_problem', layout: :application
end

post '/problems/create' do
  @problem = Problem.new
  @problem.author_id = @user.id
  @problem.name = params['name']
  @problem.description = params['description']
  @solution = Solution.new
  @solution.author_id = @user.id
  @solution.text = params['text']
  @problem.save!
  @solution.problem_id = @problem.id
  @solution.save!
  haml :'problem_upload', layout: :application
end

post '/problems/update' do
  @problem = Problem.find(id)
  @problem.name = params['name']
  @problem.description = params['description']
  @problem.save!
  haml :'problems', layout: :application
end

get '/problems/:id' do
  @problem = Problem.find(id)
  haml :'problem', layout: :application
end

delete '/problems/:id' do
  @problem = Problem.find(params['id'])
  @problem.destroy!
  haml :'problems', layout: :application
end