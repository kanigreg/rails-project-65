# frozen_string_literal: true

require 'application_system_test_case'

class Web::Admin::CategoriesTest < ApplicationSystemTestCase
  setup do
    @category = categories(:one)
  end

  test 'visiting the index' do
    visit admin_categories_url
    assert_selector 'h1', text: 'Categories'
  end

  test 'creating a Category' do
    visit admin_categories_url
    click_on 'New Category'

    fill_in 'Name', with: @category.name
    click_on 'Create Category'

    assert_text 'Category was successfully created'
    click_on 'Back'
  end

  test 'updating a Category' do
    visit admin_categories_url
    click_on 'Edit', match: :first

    fill_in 'Name', with: @category.name
    click_on 'Update Category'

    assert_text 'Category was successfully updated'
    click_on 'Back'
  end
end
