# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def update?
    admin?
  end

  class Scope < Scope
    def resolve
      scope.all if user.admin?
    end
  end
end
