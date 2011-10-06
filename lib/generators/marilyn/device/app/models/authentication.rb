class Authentication < ActiveRecord::Base
  belongs_to :user

  # не нужно писать, т.к. пользователь на прямую не работает с созданием записи
  #validates :user_id, :presence => true
  #validates :provider, :presence => true
  #validates :uid, :presence => true
end
