class AddDefaultUser < ActiveRecord::Migration
  DEFAULT_ADMIN_EMAIL = 'admin@black-sheep.ru'
  DEFAULT_ADMIN_PASSWORD = 'admin_,tt'

  def self.up
    return if User.find_by_email(DEFAULT_ADMIN_EMAIL)

    admin = User.create(:email => DEFAULT_ADMIN_EMAIL,
                        :password => DEFAULT_ADMIN_PASSWORD)
    admin.save
  end

  def self.down
    admin = User.find_by_email(DEFAULT_ADMIN_EMAIL)
    admin.delete if admin
  end

end