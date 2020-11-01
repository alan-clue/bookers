class BooksController < ApplicationController

  before_action :authenticate_user!

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.new
    @bookDetail = Book.find(params[:id])
  end

  def create
    @book = current_user.books.new(book_params)
    if @book.save
      flash[:notice] = 'Book was successfully created.'
      redirect_to book_path(@book)
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
    @submit = 'Update Book'
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = 'Book was successfully updated.'
      redirect_to book_path(@book)
    else
      flash[:alert] = 'Book was error updated.'
      render :edit
    end

  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

    def book_params
      params.require(:book).permit(:title, :body)
    end
end
