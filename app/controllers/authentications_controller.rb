class AuthenticationsController < ApplicationController
  def index  
    @authentications = current_user.try(:authentications)
  end  

  def create  
    auth = request.env["rack.auth"] 
    current_user.authentications.create(:provider => auth ['provider'], :uid => auth['uid'])  
    
    flash[:notice] = "Authentication successful."  
    redirect_to :root
  end  

  def destroy  
    @authentication = current_user.authentications.find(params[:id])  
    @authentication.destroy  
    
    flash[:notice] = "Successfully destroyed authentication."  
    redirect_to :root
  end  
end
