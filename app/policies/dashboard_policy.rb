# frozen_string_literal: true

class DashboardPolicy < ApplicationPolicy
  def index?
    admin?
  end
end
