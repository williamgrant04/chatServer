class AddImageToServers < ActiveRecord::Migration[8.0]
  def change
    add_column :servers, :image_public_id, :string, null: false
  end
end
