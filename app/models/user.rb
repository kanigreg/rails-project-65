# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bulletins, dependent: :destroy, inverse_of: :user, foreign_key: :creator_id

  validates :email, presence: true
end
