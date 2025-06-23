class BooksController < ApplicationController
  before_action :require_login
  before_action :require_admin, except: [:index, :show]
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.includes(:category, :authors).all
    @books = @books.where("title ILIKE ?", "%#{params[:search]}%") if params[:search].present?
  end

  def show
    @loan = @book.loans.active.first
  end

  def new
    @book = Book.new
    @categories = Category.all
    @authors = Author.all
  end

  def create
    @book = Book.new(book_params)
    
    if @book.save
      # Associar autores selecionados
      @book.author_ids = params[:book][:author_ids] if params[:book][:author_ids]
      flash[:notice] = "Livro criado com sucesso."
      redirect_to @book
    else
      @categories = Category.all
      @authors = Author.all
      render :new
    end
  end

  def edit
    @categories = Category.all
    @authors = Author.all
  end

  def update
    if @book.update(book_params)
      # Atualizar autores associados
      @book.author_ids = params[:book][:author_ids] if params[:book][:author_ids]
      flash[:notice] = "Livro atualizado com sucesso."
      redirect_to @book
    else
      @categories = Category.all
      @authors = Author.all
      render :edit
    end
  end

  def destroy
    @book.destroy
    flash[:notice] = "Livro excluído com sucesso."
    redirect_to books_path
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :isbn, :publication_date, :pages, :description, :category_id)
  end
end
