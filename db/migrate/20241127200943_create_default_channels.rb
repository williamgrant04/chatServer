class CreateDefaultChannels < ActiveRecord::Migration[8.0]
  def change
    create_table :default_channels do |t|
      t.references :server, null: false, foreign_key: true
      t.references :channel, null: false, foreign_key: true
      t.timestamps
    end
  end
end
