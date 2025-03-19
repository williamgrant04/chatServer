class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :image, :status, :created_at, :updated_at

  def image
    object.image_public_id
  end
end
