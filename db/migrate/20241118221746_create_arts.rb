class CreateArts < ActiveRecord::Migration[7.1]
  def change
    create_table :arts do |t|
      t.string :title
      t.text :description
      t.text :tags
      t.string :category
      t.string :license_type
      t.integer :download_count
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
