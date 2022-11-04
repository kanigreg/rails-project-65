# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    admin? || creator? || record&.published?
  end

  def create?
    user
  end

  def update?
    creator?
  end

  def to_moderate?
    creator? && record&.may_to_moderate?
  end

  def archive?
    creator? && record&.may_archive?
  end

  private

  def creator?
    record&.user == user
  end
end
