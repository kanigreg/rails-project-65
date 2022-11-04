# frozen_string_literal: true

require 'application_system_test_case'

class Web::Admin::CategoriesTest < ApplicationSystemTestCase
  setup do
    @attr = { name: Faker::Hobby.activity }

    sign_in users(:admin)
  end

  test 'visiting the index' do
    visit admin_categories_url
    assert_selector 'h2', text: 'Categories'
  end

  test 'creating a Category' do
    visit admin_categories_url
    click_on 'New Category'

    fill_in 'Name', with: @attr[:name]
    click_on 'Create Category'

    assert page.has_content?('Category was successfully created')

    created_category = Category.last
    assert created_category.name == @attr[:name]
  end

  test 'updating a Category' do
    visit admin_categories_url
    click_on 'Edit', match: :first

    fill_in 'Name', with: @attr[:name]
    click_on 'Update Category'

    assert page.has_content?('Category was successfully updated')

    last_updated = Category.order(:updated_at).last
    assert last_updated.name == @attr[:name]
  end
end
