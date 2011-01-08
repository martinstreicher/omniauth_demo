class User < ActiveRecord::Base
  devise :confirmable, :database_authenticatable, :invitable, :omniauthable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
    
  has_many :authentications
  
  def apply_omniauth(omniauth)  
    omniauth_params = { :provider => omniauth ['provider'], :uid => omniauth['uid'] }
    self.authentications.build omniauth_params
    self.confirmed_at ||= Time.now
    debugger 
    x = 1
  end  
  
  # Override the Devise method to determine if a password is required
  def password_required?
    (authentications.empty? || !password.blank?) && super
  end  
end
