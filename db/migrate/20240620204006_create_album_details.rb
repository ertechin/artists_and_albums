class CreateAlbumDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :album_details do |t|
      t.bigint :external_id, null: false
      t.text :description
      t.string :url
      t.string :thumbnail_url
      t.references :album, null: false, foreign_key: true
      t.timestamps
    end
    add_index :album_details, :external_id, unique: true
  end
end