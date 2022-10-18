# frozen_string_literal: true

require 'application_system_test_case'

class Web::Admin::UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test 'visiting the index' do
    visit admin_users_url
    assert_selector 'h1', text: 'Users'
  end

  test 'updating a User' do
    visit admin_users_url
    click_on 'Edit', match: :first

    fill_in 'Email', with: @user.email
    fill_in 'Name', with: @user.name
    click_on 'Update User'

    assert_text 'User was successfully updated'
    click_on 'Back'
  end
end
