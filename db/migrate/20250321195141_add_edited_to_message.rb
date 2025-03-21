class AddEditedToMessage < ActiveRecord::Migration[8.0]
  def change
    add_column :messages, :edited, :boolean, default: false
  end
end
