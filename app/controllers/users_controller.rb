class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_admin, only: [:index, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_owner_or_admin, only: [:show, :edit, :update]

  def index
    @users = User.includes(:profile, :loans).all
  end

  def show
    @loans = @user.loans.includes(:book)
  end

  def new
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new(user_params)
    @user.role = 'user' # usuários comuns por padrão
    
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Conta criada com sucesso! Bem-vindo, #{@user.name}!"
      redirect_to root_path
    else
      @user.build_profile unless @user.profile
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Perfil atualizado com sucesso."
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user == current_user
      flash[:alert] = "Você não pode excluir sua própria conta."
      redirect_to @user
    else
      @user.destroy
      flash[:notice] = "Usuário excluído com sucesso."
      redirect_to users_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                 profile_attributes: [:bio, :avatar_url, :phone, :address])
  end

  def require_owner_or_admin
    unless current_user == @user || current_user&.admin?
      flash[:alert] = "Acesso negado."
      redirect_to root_path
    end
  end
end
