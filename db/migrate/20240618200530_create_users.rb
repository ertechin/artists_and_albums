class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :user_name, null: false
      t.string :phone
      t.jsonb :other_infos, default: {}
      t.timestamps
    end
  end
end
