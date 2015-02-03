get '/my_solutions' do
  @solutions = Solution.where(author_id: @user.id)
  haml :'my_solutions', layout: :application
end

get '/problems/:problem_id/solutions' do
  @problem = Problem.find(params['problem_id'])
  @solutions = Solution.where(problem_id: @problem.id)
  haml :'solutions', layout: :application
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

get '/verify_solution/:id' do
  @solution = Solution.find(params['id'])
  @solution.verify
  haml :'verify_solution', layout: :application
end

post '/solution/:id/grade' do
  @solution = Solution.find(params['id'])
  @solution.grade = params['grade'].to_f
  @solution.save!
  haml :'grade_updated', layout: :application
end

delete '/problems/:problem_id/solutions/:id' do
  @solution = Solution.find(params['id'])
  @solution.destroy!
  return "solution destroyed!"
end