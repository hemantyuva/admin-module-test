class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit
  layout 'admin_layout'
  # helper_method :current_user
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # def current_user
  #   if admin_signed_in?
  #     current_admin 
  #   elsif user_signed_in?
  #     current_user
  #   end 
  # end

  private

  def user_not_authorized 
    if request.referrer.present?
      flash[:error] = "No está autorizado para realizar esta acción."
      redirect_to request.referrer
    else
      flash[:error] = "No está autorizado para realizar esta acción."
      redirect_to root_path
    end
  end
end