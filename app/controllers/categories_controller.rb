class CategoriesController < ApplicationController
  before_action :require_login
  before_action :require_admin, except: [:index, :show]
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.includes(:books).all
  end

  def show
    @books = @category.books.includes(:authors)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    
    if @category.save
      flash[:notice] = "Categoria criada com sucesso."
      redirect_to @category
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Categoria atualizada com sucesso."
      redirect_to @category
    else
      render :edit
    end
  end

  def destroy
    if @category.books.any?
      flash[:alert] = "Não é possível excluir uma categoria que possui livros associados."
      redirect_to @category
    else
      @category.destroy
      flash[:notice] = "Categoria excluída com sucesso."
      redirect_to categories_path
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
