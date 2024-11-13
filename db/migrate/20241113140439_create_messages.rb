class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.text :content, null: false # I'm making this non-nullable because I don't want empty messages but I'll also add validations on the modal and the client side just in case, basically this should never be empty.
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
