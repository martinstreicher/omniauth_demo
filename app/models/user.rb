class User < ActiveRecord::Base
  devise :confirmable, :database_authenticatable, :invitable, :omniauthable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
    
  has_many :authentications
end
