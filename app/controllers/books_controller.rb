class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]

  def list_oop
    @books = Book.where out_of_print: true
    render :index, status: :ok
  end

  def list_books_by_author
    @author = Author.find_by(first_name: params[:first_name], last_name: params[:last_name])
    @books = Book.where author: @author
    render :index, status: :ok
  end

  def list_books_by_year_published_range
    @books = Book.where(year_published: params[:begin_year]..params[:end_year])
    render :index, status: :ok
  end

  def list_books_since_year
    @books = Book.where(year_published: params[:year]..)
    render :index, status: :ok
  end

  # GET /books or /books.json
  def index
    @books = Book.all
  end

  # GET /books/1 or /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :year_published, :isbn, :price, :out_of_print, :views, :supplier_id, :author_id)
    end
end
