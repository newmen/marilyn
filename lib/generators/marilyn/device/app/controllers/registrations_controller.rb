class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :authenticate_user!

  def edit
    redirect_to root_url
  end

  def cancel
    redirect_to root_url
  end
end