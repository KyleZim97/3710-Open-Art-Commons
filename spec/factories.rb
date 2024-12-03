FactoryBot.define do
  factory (:artist) do
    username { Faker::Internet.username }
    about_artist { Faker::Lorem.sentence }
    created { Date.today }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }  
  end

  factory (:art) do
    title { Faker::Book.title } 
    description { Faker::Lorem.paragraph } 
    tags { Faker::Lorem.words(number: 3).join(', ') } 
    category { %w[Painting Sculpture Digital].sample } 
    license_type { %w[Public Domain Creative_Commons Restricted].sample } 
    download_count { Faker::Number.between(from: 0, to: 100) } 
    artist
  end
end