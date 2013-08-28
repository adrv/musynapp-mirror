
namespace :objects do
  
  task populate: [:environment, :load_blueprints, :populate_questions] 

  task  populate_questions: :environment do
    ['What''s the name of your first pet?', 'What was the name of of your school?'].each do |question|
      SecretQuestion.make! body: question
    end
  end

  task :load_blueprints do
    load Rails.root.join('config', 'blueprints.rb')
  end

end
