class CreateArtists < ActiveRecord::Migration[7.1]
  def change
    create_table :artists do |t|
      t.string :username
      t.text :about_artist
      t.date :created

      t.timestamps
    end
  end
end
