class AuthenticationsController < ApplicationController
  def index  
    @authentications = current_user.try(:authentications)
  end  

  def create  
    omniauth = request.env["omniauth.auth"] 
debugger
    if (authentication = Authentication.find_by_provider_and_uid omniauth['provider'], omniauth['uid'] )
      flash[:notice] = "Signed in successfully."  
      sign_in_and_redirect :user, authentication.user
    elsif current_user
      if (authentication = current_user.authentications.find_by_provider_and_uid omniauth['provider'], omniauth['uid'])
        flash[:notice] = "Authentication successful."
      else
        current_user.apply_omniauth omniauth
        current_user.save
        flash[:notice] = "Signed in successfully."  
      end
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
