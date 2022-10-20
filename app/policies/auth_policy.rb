# frozen_string_literal: true

class AuthPolicy < ApplicationPolicy
  def login?
    !user
  end

  def logout?
    user
  end
  alias authenticated? logout?
end
