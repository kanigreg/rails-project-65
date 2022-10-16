# frozen_string_literal: true

module AuthConcern
  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session.delete(:user_id)
    session.clear
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    session[:user_id].present? && current_user.present?
  end

  def authorize_user!
    redirect_to root_path unless user_signed_in?
  end
end
