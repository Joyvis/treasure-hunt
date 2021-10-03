# frozen_string_literal: true

class UserRequest < ApplicationRecord
  validates_presence_of :email, :distance, :latitude, :longitude
end
