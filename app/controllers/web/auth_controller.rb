# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def logout
    sign_out
    redirect_to root_path
  end

  def callback
    return redirect_to root_path if user_signed_in?

    email, name = auth[:info].values_at(:email, :name)

    user = User.find_or_initialize_by(email: email.downcase)

    unless user.update(name: name)
      return redirect_to root_path, alert: t('.failure')
    end

    sign_in user
    redirect_to root_path, notice: t('.success')
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
