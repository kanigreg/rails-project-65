# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    authorize Bulletin

    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.order(created_at: :desc).page(params[:page])
  end

  def publish
    @bulletin = Bulletin.find(params[:id])

    authorize @bulletin

    if @bulletin.publish!
      redirect_back fallback_location: admin_bulletins_path, notice: t('.success')
    else
      redirect_back fallback_location: admin_bulletins_path, alert: t('.failure')
    end
  end

  def reject
    @bulletin = Bulletin.find(params[:id])

    authorize @bulletin

    if @bulletin.reject!
      redirect_back fallback_location: admin_bulletins_path, notice: t('.success')
    else
      redirect_back fallback_location: admin_bulletins_path, alert: t('.failure')
    end
  end
end
