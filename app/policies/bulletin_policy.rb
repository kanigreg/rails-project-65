# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    creator?
  end

  def create?
    user
  end

  def update?
    creator?
  end

  private

  def creator?
    record&.user == user
  end
end
