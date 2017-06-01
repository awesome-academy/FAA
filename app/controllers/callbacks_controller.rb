class CallbacksController < Devise::OmniauthCallbacksController
  User.omniauth_providers.each do |provider|
    define_method(provider) do
      auth = request.env["omniauth.auth"]
      @user = User.from_omniauth auth

      if @user.persisted?
        if is_navigational_format?
          set_flash_message :notice, :success, kind: auth.provider
        end
        sign_in_and_redirect @user
      else
        flash[:notice] = t ".auth_failure"
        redirect_to root_path
      end
    end
  end
end
