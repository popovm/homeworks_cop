get '/problems' do
  id = @user != nil ? @user.id : 0
  @problems = Problem.where("author_id != ?", id)
  haml :'problems', layout: :application
end

get '/my_problems' do
  @problems = Problem.where(author_id: @user.id)
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

get '/problems/:id/edit' do
  @problem = Problem.find(params['id'])
  haml :'edit_problem', layout: :application
end

post '/problems/:id/update' do
  @problem = Problem.find(params['id'])
  @problem.name = params['name']
  @problem.description = params['description']
  @problem.save!
  @solution = @problem.teacher_solution
  @solution.text = params['text']
  @solution.save!
  haml :'problem_updated', layout: :application
end


get '/problems/:id' do
  @problem = Problem.find(params['id'])
  haml :'problem', layout: :application
end

delete '/problems/:id' do
  @problem = Problem.find(params['id'])
  @problem.destroy!
  haml :'problems', layout: :application
end