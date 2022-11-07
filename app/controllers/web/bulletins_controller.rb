# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.published.order(created_at: :desc).page(params[:page])
    @options_for_categories = Category.pluck(:name, :id)
  end

  def show
    @bulletin = Bulletin.find(params[:id])

    authorize @bulletin
  end

  def new
    authenticate_user!
    authorize Bulletin

    @bulletin = Bulletin.new
  end

  def create
    authenticate_user!
    authorize Bulletin

    @bulletin = current_user.bulletins.new(bulletin_params)

    if @bulletin.save
      redirect_to @bulletin, notice: t('.success')
    else
      render :new
    end
  end

  def edit
    authenticate_user!

    @bulletin = Bulletin.find(params[:id])

    authorize @bulletin
  end

  def update
    authenticate_user!

    @bulletin = Bulletin.find(params[:id])

    authorize @bulletin

    if @bulletin.update(bulletin_params)
      redirect_to @bulletin, notice: t('.success')
    else
      render :edit
    end
  end

  def to_moderate
    authenticate_user!

    @bulletin = Bulletin.find(params[:id])

    authorize @bulletin, :update?

    if @bulletin.to_moderate!
      redirect_back fallback_location: profile_path, notice: t('.success')
    else
      redirect_back fallback_location: profile_path, alert: t('.failure')
    end
  end

  def archive
    authenticate_user!

    @bulletin = Bulletin.find(params[:id])

    authorize @bulletin, :update?

    if @bulletin.archive!
      redirect_back fallback_location: profile_path, notice: t('.success')
    else
      redirect_back fallback_location: profile_path, alert: t('.failure')
    end
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
