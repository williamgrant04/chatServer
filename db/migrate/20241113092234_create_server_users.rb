class CreateServerUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :server_users do |t|
      t.references :server, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
