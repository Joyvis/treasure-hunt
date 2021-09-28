# frozen_string_literal: true

class Treasure < ApplicationRecord
  enum status: { found: 0, active: 1 }
end
