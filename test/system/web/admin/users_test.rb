# frozen_string_literal: true

require 'application_system_test_case'

class Web::Admin::UsersTest < ApplicationSystemTestCase
  setup do
    @attrs = {
      name: Faker::Name.name,
      email: Faker::Internet.email
    }

    sign_in users(:admin)
  end

  test 'visiting the index' do
    visit admin_users_url
    assert_selector 'h2', text: 'Users'
  end

  test 'updating a User' do
    visit admin_users_url
    click_on 'edit', match: :first

    fill_in 'Email', with: @attrs[:email]
    fill_in 'Name', with: @attrs[:name]
    click_on 'Update User'

    assert_text 'User was successfully updated'

    last_updated = User.order(:updated_at).last
    assert last_updated.name == @attr[:name]
  end
end
