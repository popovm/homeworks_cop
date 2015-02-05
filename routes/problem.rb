get '/problems' do
  id = (@user != nil ? @user.id : 0)
  @problems = Problem.where("author_id != ?", id)
  haml :'problems', layout: :application
end

get '/my_problems' do
  if !@user.nil?
    @problems = Problem.where(author_id: @user.id)
    haml :'problems', layout: :application
  else
    haml :'access_denied', layout: :application
  end
end

get '/problems/new' do
  if !@user.nil? && @user.teacher?
    haml :'new_problem', layout: :application
  else
    haml :'access_denied', layout: :application
  end
end

post '/problems/create' do
  if !@user.nil? && @user.teacher?
    @problem = Problem.new
    @problem.author_id = @user.id
    @problem.name = params['name']
    @problem.description = params['description']
    @problem.end_date = params['end_date']
    @solution = Solution.new
    @solution.author_id = @user.id
    @solution.text = params['text']
    @problem.save!
    @solution.problem_id = @problem.id
    @solution.save!

    if params['testoutput'] != nil
      params['testoutput'].zip(params['testinput']).each do |output, input|
        test = Test.new
        test.input, test.output = input, output
        test.problem_id = @problem.id
        test.save!
      end
    end

    haml :'problem_upload', layout: :application
  else
    haml :'access_denied', layout: :application
  end
end

get '/problems/:id/edit' do
  if !@user.nil? && @user.teacher?
    @problem = Problem.find(params['id'])
    haml :'edit_problem', layout: :application
  else
  end
end

post '/problems/:id/update' do
  if !@user.nil? && @user.teacher?
    @problem = Problem.find(params['id'])
    @problem.name = params['name']
    @problem.description = params['description']
    @problem.end_date = params['end_date']
    @problem.save!
    @solution = @problem.teacher_solution
    @solution.text = params['text']
    @solution.save!
    haml :'problem_updated', layout: :application
  else
    haml :'access_denied', layout: :application
  end
end


get '/problems/:id' do
  @problem = Problem.find(params['id'])
  if !@user.nil?
    haml :'problem', layout: :application
  else
    haml :'access_denied', layout: :application
  end
end

get '/problems/:id/delete' do
  @problem = Problem.find(params['id'])
  if !@user.nil? && @user.id == @problem.author_id
    if @problem.solutions.size <= 1
      @problem.solutions.each(&:destroy)
      @problem.destroy
      haml :'problem_deleted', layout: :application
    else
      haml :'problem_not_destructable', layout: :application
    end
  else
    haml :'access_denied', layout: :application
  end
end

get '/statistics' do
  if !@user.nil? && @user.teacher?
    haml :'teacher_statistics', layout: :application
  else
    haml :'access_denied', layout: :application
  end
end