get '/my_solutions' do
  if !@user.nil?
    @solutions = Solution.where(author_id: @user.id)
    haml :'my_solutions', layout: :application
  else
    haml :'access_denied', layout: :application
  end
end

get '/problems/:problem_id/solutions' do
  @problem = Problem.find(params['problem_id'])
  if !@user.nil? && @problem.author_id == @user.id
    @solutions = Solution.where(problem_id: @problem.id)
    haml :'solutions', layout: :application
  else
    haml :'access_denied', layout: :application
  end
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

get '/problems/:problem_id/solutions/:solution_id' do
  @solution = Solution.find(params['solution_id'])
  if !@user.nil? && [@solution.author_id, @solution.problem.author_id].member?(@user.id)
    haml :'solution', layout: :application
  else
    haml :'access_denied', layout: :application
  end
end

get '/problems/:problem_id/solutions/:solution_id/edit' do
  @solution = Solution.find(params['solution_id'])
  if !@user.nil? && @solution.author_id == @user.id
    haml :'edit_solution', layout: :application
  else
    haml :'access_denied', layout: :application
  end
end

post '/problems/:problem_id/solutions/:solution_id/update' do
  @solution = Solution.find(params['solution_id'])
  if !@user.nil? && @solution.author_id == @user.id
    @solution.text = params['text']
    @solution.save!
    haml :'solution_updated', layout: :application
  else
    haml :'access_denied', layout: :application
  end
end

get '/verify_solution/:id' do
  @solution = Solution.find(params['id'])
  if !@user.nil? && @solution.problem.author_id == @user.id
    @solution.verify
    haml :'verify_solution', layout: :application
  else
    haml :'access_denied', layout: :application
  end
end

post '/solution/:id/grade' do
  @solution = Solution.find(params['id'])
  if !@user.nil? && @solution.problem.author_id == @user.id
    @solution.grade = params['grade'].to_f
    @solution.save!
    haml :'grade_updated', layout: :application
  else
    haml :'access_denied', layout: :application
  end
end

get 'solutions/:id/delete' do
  @solution = Solution.find(params['id'])
  if !@user.nil? && @solution.author_id == @user.id
    @solution.destroy
    haml :'solution_deleted', layout: :application
  else
    haml :'access_denied', layout: :application
  end
end