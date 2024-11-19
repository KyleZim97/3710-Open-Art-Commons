json.extract! art, :id, :title, :description, :tags, :category, :license_type, :download_count, :artist_id, :created_at, :updated_at
json.url art_url(art, format: :json)
