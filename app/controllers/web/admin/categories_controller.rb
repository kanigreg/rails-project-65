# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  def index
    authorize Category

    @categories = Category.all
  end

  def new
    authorize Category

    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])

    authorize @category
  end

  def create
    authorize Category

    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: t('.success')
    else
      render :new
    end
  end

  def update
    @category = Category.new(category_params)

    authorize @category

    if @category.update(category_params)
      redirect_to admin_categories_path, notice: t('.succcess')
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])

    authorize @category

    if @category.bulletins.empty?
      @category.destroy
      redirect_to admin_categories_path, notice: t('.success')
    else
      redirect_to admin_categories_path, alert: t('.not_empty')
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
