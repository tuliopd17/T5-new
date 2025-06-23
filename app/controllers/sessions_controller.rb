class SessionsController < ApplicationController
  # Pular verificação de CSRF para o método create durante desenvolvimento
  skip_before_action :verify_authenticity_token, only: [:create] if Rails.env.development?
  
  def new
    # Formulário de login
  end

  def create
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Bem-vindo, #{user.name}!"
      redirect_to root_path
    else
      flash.now[:alert] = "Email ou senha inválidos."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logout realizado com sucesso."
    redirect_to login_path
  end
end
