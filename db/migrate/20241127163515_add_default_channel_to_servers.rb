class AddDefaultChannelToServers < ActiveRecord::Migration[8.0]
  def change
    add_reference :servers, :default_channel, foreign_key: { to_table: :channels }
  end
end
