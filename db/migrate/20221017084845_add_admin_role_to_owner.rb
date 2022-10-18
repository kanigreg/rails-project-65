class AddAdminRoleToOwner < ActiveRecord::Migration[6.1]
  def up
    User.find_by_email('netsafe.g@gmail.com')&.update(admin: true)
  end

  def down
    User.find_by_email('netsafe.g@gmail.com')&.update(admin: false)
  end
end
