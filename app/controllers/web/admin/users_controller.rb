# frozen_string_literal: true

class Web::Admin::UsersController < Web::Admin::ApplicationController
  def index
    authorize User

    @users = User.all
  end

  def edit
    authorize User

    @user = User.find(params[:id])
  end

  def update
    authorize User

    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_users_path, notice: t('.success')
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin)
  end
end