class BooksController < ApplicationController
  def create
    @book = Book.new(book_params)
    @book.save
    redirect_to book_path(@book.id)
    # 詳細画面へリダイレクトするには固定のURL"book_path"ではなく"book_path(@book.id)"じゃないとダメ。
  end

  def index
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
