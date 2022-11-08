# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def show?
    admin? || creator? || record&.published?
  end

  def update?
    creator?
  end

  private

  def creator?
    record&.user == user
  end

  def admin?
    user&.admin?
  end
end
