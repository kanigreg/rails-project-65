# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def logout
    sign_out
    redirect_to root_path
  end

  def callback
    email, name = auth[:info].values_at(:email, :name)

    user = User.find_or_initialize_by(email: email.downcase)

    unless user.persisted?
      user.name = name
      user.save!
    end

    sign_in user
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
