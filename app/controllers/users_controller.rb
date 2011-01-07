class UsersController < ApplicationController
  before_filter :authenticate_user!
  helper_method :to_list

  def edit
    @user = current_user
  end
end
