require 'machinist/active_record'
require 'faker'

SecretQuestion.blueprint do
end

Registration.blueprint do
  username { Faker::Internet.email }
  password { '123456'}
  password_confirmation { '123456' }
end

Fan.blueprint do
  name {  Faker::Name.name }
  registration { Registration.make! registrateable: object }
end

Venue.blueprint do
  name {  Faker::Name.name }
  address { Faker::Lorem.words(5).join }
  description { Faker::Lorem.words(30).join(' ') }
  registration { Registration.make! registrateable: object }
end

Band.blueprint do
  name {  Faker::Name.name }
  description { Faker::Lorem.words(30).join(' ') }
  registration { Registration.make! registrateable: object }
  genre { Genre.all.sample || Genre.make! }
end

Genre.blueprint do
  title { ['Acoustic', 'Ambient', 'Classical', 'Jazz & Blues', 'Dance / Electronic', 'Hip Hop', 'Pop', 'Reggae', 'Rock', 'Indie'].sample }
end
