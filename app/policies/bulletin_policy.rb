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

  def to_moderate?
    creator? && record&.may_to_moderate?
  end

  def publish?
    admin? && record&.may_publish?
  end

  def reject?
    admin? && record&.may_reject?
  end

  def archive?
    (creator? || admin?) && record&.may_archive?
  end

  private

  def creator?
    record&.creator == user
  end
end
