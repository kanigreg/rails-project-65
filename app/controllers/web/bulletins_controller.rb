# frozen_string_literal: true

class Web::BulletinsController < ApplicationController
  def index
    @bulletins = Bulletin.all.order(created_at: :desc)
  end

  def show
    @bulletin = Bulletin.find(params[:id])
  end

  def new
    authorize_user!

    @bulletin = Bulletin.new
  end

  def create
    authorize_user!

    @bulletin = current_user.bulletins.new(bulletin_params)

    if @bulletin.save
      redirect_to @bulletin, notice: t('.success')
    else
      render :new
    end
  end

  def edit
    authorize_user!

    @bulletin = Bulletin.find(params[:id])
  end

  def update
    authorize_user!

    @bulletin = current_user.bulletins.find(params[:id])

    if @bulletin.update(bulletin_params)
      redirect_to @bulletin, notice: t('.success')
    else
      render :edit
    end
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
