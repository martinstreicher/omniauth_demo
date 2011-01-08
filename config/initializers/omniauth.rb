module Services
  FACEBOOK_APP_ID          = "144903888897323"
  FACEBOOK_API_ID          = "5af70c7944f0440065786d05d38dec9e"
  FACEBOOK_APP_SECRET      = "d645352b22b7acdfe4b257a3e0dd350d"
  
  GOOGLE_CONSUMER_KEY      = "strike.heroku.com"
  GOOGLE_CONSUMER_SECRET   = "9ZVMBvjBDxrRDyRhHa9SaVaG"
  
  LINKEDIN_CONSUMER_KEY    = "QZxUdbAyuouuFcDGcS17DzcOwNs5lXzcWTrPTRJuSQFu46XxTEr3aRen6yLkajnd"
  LINKEDIN_CONSUMER_SECRET = "JAGiOnDBVLhuThbEqjboppjOHeRsLL6R6Bg4zP0Rw_E6Ur6_ehvbcHQHkszp2zYj"
  
  TWITTER_API_KEY          = "hSt6bkPQBLMuAdnBdS0EdQ"
  TWITTER_CONSUMER_KEY     = "hSt6bkPQBLMuAdnBdS0EdQ"
  TWITTER_CONSUMER_SECRET  = "mZvUlqfbdZAQnlhE3PiIlCvpEmiAmKIc7XyqMscyCjA"
end

Rails.application.config.middleware.use OmniAuth::Builder do  
  provider :twitter,    Services::TWITTER_CONSUMER_KEY,   Services::TWITTER_CONSUMER_SECRET
  provider :facebook,   Services::FACEBOOK_APP_ID,        Services::FACEBOOK_APP_SECRET
  provider :linked_in,  Services::LINKEDIN_CONSUMER_KEY,  Services::LINKEDIN_CONSUMER_SECRET 
end  
