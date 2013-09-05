namespace :objects do
  
  task populate: [:environment, :clean ,:load_blueprints, :populate_questions, :populate_users] 

  task  :populate_questions do
    puts '--- creating questions'
    ['What''s the name of your first pet?', 'What was the name of of your school?'].each do |question|
      SecretQuestion.make! body: question
    end
  end

  task :load_blueprints do
    load Rails.root.join('config', 'blueprints.rb')
  end

  task :populate_users do
    puts '--- users users'
    Venue.make! # venue : 123456
    Band.make! # band : 123456
    Fan.make! # fan :123456
  end

  task :clean do
    puts '--- cleaning all'
    Registration.delete_all
    Venue.delete_all
    Fan.delete_all
    Band.delete_all
  end

end
