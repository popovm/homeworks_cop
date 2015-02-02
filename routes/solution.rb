get '/my_solutions' do
  @solutions = Solution.where(author_id: @user.id)
  haml :'solutions'
end

get '/problems/:problem_id/solutions' do
  @solutions = Solution.where(problem_id: params['problem_id'])
  haml :'solutions'
end

get '/problems/:problem_id/solutions/new' do
  @problem = Problem.find(params['problem_id'])
  haml :'new_solution', layout: :application
end

post '/problems/:problem_id/solutions/create' do
  @solution = Solution.new
  @solution.problem_id = params['problem_id']
  @solution.author_id = @user.id
  @solution.text = params['text']
  @solution.save!
  haml :'solution_upload', layout: :application
end

post '/problems/:problem_id/solutions/:id/update' do
  @solution = Solution.find(params['id'])
  @solution.name = params['name']
  @solution.text = params['text']
  @solution.save!
  return 'solution updated'
end

get '/problems/:problem_id/solutions/:id' do
  @solution = Solution.find(params['id'])
  haml :'solution'
end

delete '/problems/:problem_id/solutions/:id' do
  @solution = Solution.find(params['id'])
  @solution.destroy!
  return "solution destroyed!"
end