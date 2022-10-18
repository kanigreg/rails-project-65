# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:cars)
    @attr = { name: Faker::ProgrammingLanguage.name }

    sign_in users(:admin)
  end

  test 'should get index' do
    get admin_categories_url

    assert_response :success
  end

  test 'should get new' do
    get new_admin_category_url

    assert_response :success
  end

  test 'should create category' do
    assert_difference('Category.count') do
      post admin_categories_url, params: { category: @attr }
    end

    assert_redirected_to admin_categories_url
  end

  test 'should get edit' do
    get edit_admin_category_url(@category)

    assert_response :success
  end

  test 'should update category' do
    patch admin_category_url(@category), params: { category: @attr }
    @category.reload

    assert @category.name = @attr[:name]
    assert_redirected_to admin_categories_url
  end

  test 'should destroy category' do
    category = categories(:without_bulletins)
    assert_difference('Category.count', -1) do
      delete admin_category_url(category)
    end

    assert_redirected_to admin_categories_url
  end
end
