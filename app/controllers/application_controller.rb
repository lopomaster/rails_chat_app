class ApplicationController < ActionController::Base

  before_action :user_login?

  def user_login?
    if cookies.signed[:user_name].blank?
      redirect_to root_path
    end
  end

end
