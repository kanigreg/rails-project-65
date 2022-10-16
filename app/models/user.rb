# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bulletins, dependent: :destroy, inverse_of: :creator, foreign_key: :creator_id
end
