# frozen_string_literal: true

class Web::UsersController < Web::ApplicationController
  def profile
    authorize User

    @q = current_user.bulletins.ransack(params[:q])
    @bulletins = @q.result.order(created_at: :desc).page(params[:page])
  end
end
