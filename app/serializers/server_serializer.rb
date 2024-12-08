class ServerSerializer < ActiveModel::Serializer
  attributes :id, :name, :defaultChannel, :created # Temporarily include the id before I add uids to the server model

  belongs_to :owner

  def defaultChannel
    object.default_channel.channel
  end

  def created
    object.created_at.strftime("%e %B %Y")
  end
end
