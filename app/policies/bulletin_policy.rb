# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user
  end

  def update?
    creator?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def creator?
    record&.creator == user
  end
end
