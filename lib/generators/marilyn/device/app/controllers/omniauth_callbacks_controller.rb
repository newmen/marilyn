class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :authenticate_user!
  before_filter :process_oauth_callback

  def facebook; end
  def twitter; end
  def vkontakte; end

  protected
  def process_oauth_callback
    provider = Provider.build_provider(env['omniauth.auth'])
    if current_user
      auth = provider.find_authentication
      if auth
        notice = I18n.t('errors.messages.oauth_account_already_use', :provider => provider.name)
      else
        notice = I18n.t('devise.omniauth_callbacks.success', :kind => provider.name)
        current_user.filling_from_provider(provider)
        current_user.save
      end
      redirect_to(user_path(current_user), :notice => notice)
    else
      @user = User.find_for_oauth(provider)

      if @user.save
        flash[:notice] = I18n.t('devise.omniauth_callbacks.success', :kind => provider.name)
        sign_in_and_redirect @user, :event => :authentication
      else
        flash[:notice] = I18n.t('devise.omniauth_callbacks.success_need_registration', :kind => provider.name)
        session['devise.oauth'] = env['omniauth.auth']
        redirect_to new_user_registration_url
      end
    end
  end
end