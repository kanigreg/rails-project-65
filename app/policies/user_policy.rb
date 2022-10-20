# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def update?
    admin?
  end

  def profile?
    user
  end
end
