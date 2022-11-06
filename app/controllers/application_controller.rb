# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include AuthConcern
  include Pundit::Authorization

  helper_method :user_signed_in?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from NotAutenticatedError, with: :user_not_authenticated

  private

  def user_not_authorized
    redirect_to root_path, alert: t('access_denied')
  end

  def user_not_authenticated
    redirect_to root_path, alert: t('not_authenticated')
  end
end
