# frozen_string_literal: true

class DashboardPolicy < ApplicationPolicy
  def index?
    admin?
  end

  class Scope < Scope
    def resolve
      scope.all if user.admin?
    end
  end
end
