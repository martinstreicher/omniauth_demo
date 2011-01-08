class AuthenticationsController < ApplicationController
  def index  
    @authentications = current_user.try(:authentications)
  end  

  def create  
    omniauth = request.env["omniauth.auth"] 

    if (authentication = Authentication.find_by_provider_and_uid omniauth['provider'], omniauth['uid'] )
      flash[:notice] = "Signed in successfully."  
      sign_in_and_redirect :user, authentication.user
    elsif current_user
      current_user.authentications.find_or_create_by_provider_and_uid omniauth['provider'], omniauth['uid']    
      flash[:notice] = "Authentication successful."
      redirect_to :root
    else
      user = User.new :confirmed_at => Time.now  
      user.apply_omniauth omniauth  
      if user.save
        flash[:notice] = "Signed in successfully."  
        sign_in_and_redirect :user, user
      else
        session[:omniauth] = omniauth.except('extra')  
        redirect_to new_user_registration_url
      end
    end          
  end

  def destroy  
    @authentication = current_user.authentications.find(params[:id])  
    @authentication.destroy  
    
    flash[:notice] = "Successfully destroyed authentication."  
    redirect_to :root
  end  
end
