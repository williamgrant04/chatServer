class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :timestamp, :edit_timestamp, :edited
  belongs_to :author

  def timestamp
    object.created_at.to_i
  end

  def edit_timestamp
    object.updated_at.to_i
  end
end
