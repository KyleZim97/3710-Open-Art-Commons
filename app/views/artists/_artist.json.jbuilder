json.extract! artist, :id, :username, :about_artist, :created, :created_at, :updated_at
json.url artist_url(artist, format: :json)
