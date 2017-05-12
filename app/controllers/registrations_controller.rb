class RegistrationsController < Devise::RegistrationsController
  respond_to :html, :json

  private

  def sign_up_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def account_update_params
    params.require(:user).permit :name, :email, :password, :password_confirmation,
      :current_password
  end
end
