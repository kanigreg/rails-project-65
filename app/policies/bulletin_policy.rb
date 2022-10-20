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
    creator? && record&.draft?
  end

  def publish?
    admin? && record&.under_moderation?
  end

  def reject?
    admin? && record&.under_moderation?
  end

  def archive?
    creator? || admin?
  end

  private

  def creator?
    record&.creator == user
  end
end
