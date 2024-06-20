class CreateAlbums < ActiveRecord::Migration[7.1]
  def change
    create_table :albums do |t|
      t.bigint :external_id, null: false
      t.string :title
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    add_index :albums, :external_id, unique: true
  end
end
