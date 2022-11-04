# frozen_string_literal: true

class Web::BulletinsController < ApplicationController
  def index
    authorize Bulletin

    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.published.order(created_at: :desc).page(params[:page])
  end

  def show
    @bulletin = Bulletin.find(params[:id])

    authorize @bulletin
  end

  def new
    authorize Bulletin

    @bulletin = Bulletin.new
  end

  def create
    authorize Bulletin

    @bulletin = current_user.bulletins.new(bulletin_params)

    if @bulletin.save
      redirect_to @bulletin, notice: t('.success')
    else
      render :new
    end
  end

  def edit
    @bulletin = Bulletin.find(params[:id])

    authorize @bulletin
  end

  def update
    @bulletin = current_user.bulletins.find(params[:id])

    authorize @bulletin

    if @bulletin.update(bulletin_params)
      redirect_to @bulletin, notice: t('.success')
    else
      render :edit
    end
  end

  def to_moderate
    @bulletin = current_user.bulletins.find(params[:id])

    authorize @bulletin

    if @bulletin.to_moderate!
      redirect_back fallback_location: admin_bulletins_path, notice: t('.success')
    else
      redirect_back fallback_location: admin_bulletins_path, alert: t('.failure')
    end
  end

  def archive
    @bulletin = current_user.bulletins.find(params[:id])

    authorize @bulletin

    if @bulletin.archive!
      redirect_back fallback_location: admin_bulletins_path, notice: t('.success')
    else
      redirect_back fallback_location: admin_bulletins_path, alert: t('.failure')
    end
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
