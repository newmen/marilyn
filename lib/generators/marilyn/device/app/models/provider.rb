class Provider
  def self.build_provider(oa)
    oa['provider'].classify.constantize.new(oa)
  end
  
  def initialize(oa)
    @name = oa['provider']
    @uid = oa['uid']
    @info = oa && oa['user_info']
    @extra_hash = oa && oa['extra']['user_hash']
  end

  def name
    @name.capitalize
  end

  def find_user
    User.find_by_email(email) if email
  end

  def find_authentication
    Authentication.where(oauth_hash).first
  end

  def build_authentication_for_user(user)
    user.authentications << Authentication.new(oauth_extend_hash)
  end

  protected

  #attr_reader :uid

  def account_url; nil end
  def email; nil end

  def oauth_hash
    { :provider => @name, :uid => @uid }
  end

  def oauth_extend_hash
    oauth_hash.merge(:url => account_url)
  end
end

class Facebook < Provider
  def fill_user(user)
    user.first_name = @info['first_name'] unless user.first_name?
    user.last_name = @info['last_name'] unless user.last_name?
    user.email = @extra_hash['email'] unless user.email?
    user.about = @extra_hash['bio'] unless user.about?
    user.sex = case @extra_hash['gender']
                  when 'male' then Sex::MALE
                  when 'female' then Sex::FEMALE
                  else nil
                end unless user.sex?
  end

  protected

  def email
    @extra_hash['email']
  end

  def account_url
    @info['urls']['Facebook']
  end
end

class Twitter < Provider
  def fill_user(user)
    user.first_name = @info['name'] unless user.first_name?
    user.about = @info['description'] unless user.about?
  end
end

class Vkontakte < Provider
  def fill_user(user)
    user.first_name = @info['first_name'] unless user.first_name?
    user.last_name = @info['last_name'] unless user.last_name?
    user.sex = case @extra_hash['gender']
                  when 2 then Sex::MALE
                  when 1 then Sex::FEMALE
                  else nil
                end unless user.sex?
  end

  protected

  def account_url
    @info['urls']['Vkontakte']
  end
end
