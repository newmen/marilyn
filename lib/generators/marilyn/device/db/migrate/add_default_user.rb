class AddDefaultUser < ActiveRecord::Migration
  def change
    admin = User.create(:email => 'admin@black-sheep.ru',
                        :password => 'admin_,tt')
    admin.save
  end
end