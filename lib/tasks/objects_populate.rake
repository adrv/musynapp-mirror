namespace :objects do

  require 'database_cleaner'

  task populate: [:environment, :clean, :prepare,
                  :populate_genres,
                  :populate_questions, 
                  :populate_users,
                  ] 

  task  :populate_questions do
    puts '--- creating questions'
    $config_data['questions'].each do |question|
      SecretQuestion.make! body: question
    end
  end

  task :prepare do
    $config_data = YAML::load( File.open( Rails.root.join('config', 'config_data.yml')))
    load Rails.root.join('config', 'blueprints.rb')
  end

  task :populate_users do
    puts '--- creating users'
    [Venue, Band, Fan].each do |user_type|
      username = user_type.to_s.downcase
      p username
      reg = Registration.make!( password: '123456',
                                password_confirmation: '123456',
                                username: username,
                                registrateable: user_type.make! )
     end
  end

  task :clean do
    puts '--- cleaning all'
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.clean # cleanup of the test
  end

  task :populate_genres do
    puts '--- creating genres'
    $config_data['genres'].each do |genre|
      Genre.make! title: genre
    end
  end

end
