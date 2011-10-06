class UsersController < ApplicationController
  load_and_authorize_resource :except => [:password, :password_update, :deactivate_oauth]

  before_filter :load_and_authorize_user_for_password, :only => [:password, :password_update]

  private

  def load_and_authorize_user_for_password
    @user = User.find(params[:id])
    raise CanCan::AccessDenied unless can?(:change_password, @user)
  end

  public

  def password
  end

  def password_update
    all_right = false
    if !params[:user][:password].blank? && params[:user][:password] == params[:user][:password_confirmation]
      if current_user == @user && @user.update_with_password(params[:user])
        all_right = true
        sign_in(:user, @user, :bypass => true)
      elsif current_user != @user && @user.update_attributes(params[:user])
        all_right = true
      end

      if all_right
        redirect_to(@user,
                    :notice => I18n.t('backend.actions.success_update',
                                      :model => I18n.t('activerecord.attributes.user.password')))
      end
    end

    unless all_right
      if params[:user][:password].blank?
        @user.errors.add(:password, I18n.t('errors.messages.cannot_be_blank'))
      elsif params[:user][:password] != params[:user][:password_confirmation]
        @user.errors.add(:password_confirmation, I18n.t('errors.messages.mismatch'))
      end unless @user.errors.any?
      render :action => "password"
    end
  end

  def deactivate_oauth
    authentication = Authentication.find(params[:id])
    raise CanCan::AccessDenied unless can?(:deactivate, authentication)
    authentication.destroy
    redirect_to user_path(authentication.user), :notice => t('devise.omniauth_callbacks.success_destroy', :kind => authentication.provider.capitalize)
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to(@user,
                  :notice => I18n.t('backend.actions.success_update',
                                    :model => I18n.t('activerecord.capitalized_models.user')))
    else
      render :action => "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to(users_url,
                :notice => I18n.t('backend.actions.success_destroy',
                                  :model => I18n.t('activerecord.capitalized_models.user')))

  end

end
