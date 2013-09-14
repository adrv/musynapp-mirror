namespace :objects do


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
    Venue.make! # venue : 123456
    Band.make! # band : 123456
    Fan.make! # fan :123456
  end

  task :clean do
    puts '--- cleaning all'
    Registration.delete_all
    Venue.delete_all
    Band.delete_all
    Fan.delete_all
    Genre.delete_all
    SecretQuestion.delete_all
  end

  task :populate_genres do
    puts '--- creating genres'
    $config_data['genres'].each do |genre|
      Genre.make! title: genre
    end
  end

end
