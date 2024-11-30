FactoryBot.define do
    factory (:artist) do
      username { "Faker" }
      about_artist { "Faker::St.about_artist" }
      created { Date.today }
      email { "artist1@msudenver.edu" }
      password { "password" }
      password_confirmation { "password" }  
    end
  end