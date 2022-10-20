# frozen_string_literal: true

class Web::UsersController < Web::ApplicationController
  def profile
    authorize User

    @bulletins = current_user.bulletins
  end
end
