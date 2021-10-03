# frozen_string_literal: true

class UserRequestSerializer < ActiveModel::Serializer
  attributes :email, :current_location

  def current_location
    [object.latitude, object.longitude]
  end
end
