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
    owner?
  end

  def to_moderate?
    owner? && record&.may_to_moderate?
  end

  def publish?
    admin? && record&.may_publish?
  end

  def reject?
    admin? && record&.may_reject?
  end

  def archive?
    (owner? || admin?) && record&.may_archive?
  end

  private

  def owner?
    record&.user == user
  end
end
