class User < ActiveRecord::Base
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :omniauthable

  has_many :authentications, :dependent => :destroy

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  # Метод используется во время регистрации нового пользователя. Он вызывается девайсовым контроллером.
  def self.new_with_session(params, session)
    super.tap do |u|
      if data = session["devise.oauth"]
        provider = Provider.build_provider(data)
        u.filling_from_provider(provider)
      end
    end
  end

  def self.find_for_oauth(provider)
    auth = provider.find_authentication
    if auth
      user = auth.user
      return user if user
    end

    user = provider.find_user || User.new
    user.filling_from_provider(provider)
    user
  end

  def filling_from_provider(provider)
    provider.build_authentication_for_user(self)
    provider.fill_user(self)
  end

  def admin?
    Levelup::Application.admins.include?(email)
  end

end
