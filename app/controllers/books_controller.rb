class BooksController < ApplicationController

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
      # 詳細画面へリダイレクトするには固定のURL"book_path"ではなく"book_path(@book.id)"じゃないとダメ。
    else
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
      # 4,updateアクション内の変数をインスタンス変数に。
      # 5,book_path(@book.id)
      # 6,_________^^^ここも忘れずに。
    else
      # @book = Book.find(params[:id])
      # 1,↑render先でエラーメッセージが出なかった原因。
      # 2,ifの行の@book.updateの@bookが失敗したデータを持っているのでそのままeditに飛ばす。
      # 3,updateアクションに対応するviewはないのでもともとローカル変数だったが、editにrenderするためにインスタンス変数になることに注意。
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end