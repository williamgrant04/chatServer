class ServerSerializer < ActiveModel::Serializer
  attributes :id, :name, :default_channel, :created_at # Temporarily include the id before I add uids to the server model

  def default_channel
    object.default_channel.channel
  end

  def created_at
    object.created_at.strftime("%e %B %Y")
  end
end
