# frozen_string_literal: true

class Admin::BulletinPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def publish?
    admin? && record&.may_publish?
  end

  def reject?
    admin? && record&.may_reject?
  end

  def archive?
    admin? && record&.may_archive?
  end
end
