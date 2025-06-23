class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  before_action :current_user
  
  protected
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_login
    unless logged_in?
      flash[:alert] = "Você deve estar logado para acessar esta página."
      redirect_to login_path
    end
  end
  
  def require_admin
    require_login
    unless current_user&.admin?
      flash[:alert] = "Acesso negado. Apenas administradores podem realizar esta ação."
      redirect_to root_path
    end
  end
  
  helper_method :current_user, :logged_in?
end
