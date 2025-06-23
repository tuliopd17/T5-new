class LoansController < ApplicationController
  before_action :require_login
  before_action :set_book
  before_action :set_loan, only: [:destroy]

  def create
    if current_user.admin?
      flash[:alert] = "Administradores não podem fazer empréstimos."
      redirect_to @book
      return
    end

    if @book.loans.active.exists?
      flash[:alert] = "Este livro já está emprestado."
      redirect_to @book
      return
    end

    @loan = @book.loans.build(
      user: current_user,
      loan_date: Date.current,
      return_date: 2.weeks.from_now,
      returned: false,
      status: 'active'
    )

    if @loan.save
      flash[:notice] = "Livro emprestado com sucesso! Devolução até #{@loan.return_date.strftime('%d/%m/%Y')}."
    else
      flash[:alert] = "Erro ao emprestar livro: #{@loan.errors.full_messages.join(', ')}"
    end

    redirect_to @book
  end

  def destroy
    if current_user.admin? || @loan.user == current_user
      @loan.update!(
        returned: true,
        status: 'returned'
      )
      flash[:notice] = "Livro devolvido com sucesso!"
    else
      flash[:alert] = "Você não tem permissão para devolver este livro."
    end

    redirect_to @book
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_loan
    @loan = @book.loans.find(params[:id])
  end
end
