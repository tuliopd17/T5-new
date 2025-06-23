class AuthorsController < ApplicationController
  before_action :require_login
  before_action :require_admin, except: [:index, :show]
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  def index
    @authors = Author.includes(:books).all
    @authors = @authors.where("name ILIKE ?", "%#{params[:search]}%") if params[:search].present?
  end

  def show
    @books = @author.books.includes(:category)
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    
    if @author.save
      flash[:notice] = "Autor criado com sucesso."
      redirect_to @author
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @author.update(author_params)
      flash[:notice] = "Autor atualizado com sucesso."
      redirect_to @author
    else
      render :edit
    end
  end

  def destroy
    if @author.books.any?
      flash[:alert] = "Não é possível excluir um autor que possui livros associados."
      redirect_to @author
    else
      @author.destroy
      flash[:notice] = "Autor excluído com sucesso."
      redirect_to authors_path
    end
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name, :birth_date, :nationality, :biography)
  end
end
