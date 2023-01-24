class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]

  def list_oop
    @books = Book.where out_of_print: true
    render :index, status: :ok
  end

  def available_books_since_year
    @books = Book.where(out_of_print: false).where(year_published: params[:year]..)
    render :index, status: :ok
  end

  def list_books_by_either_author
    @author1 = Author.find_by(first_name: params[:a1_f_name], last_name: params[:a1_l_name])
    @author2 = Author.find_by(first_name: params[:a2_f_name], last_name: params[:a2_l_name])
    @books = Book.where(author: @author1).or(Book.where(author: @author2))
    render :index, status: :ok
  end

  def list_books_not_by_author
    @author = Author.find_by(first_name: params[:first_name], last_name: params[:last_name])
    @books = Book.where.not author: @author
    render :index, status: :ok
  end

  def list_books_by_author
    if Author.exists?(first_name: 'Joe', last_name: 'Shmoe')
      @author = Author.find_by(first_name: params[:first_name], last_name: params[:last_name])
      @books = Book.where author: @author
      render :index, status: :ok
    else
      render :index, status: :unprocessable_entity
    end
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
    if params[:asc_order]
      @books = Book.order(:year_published)
    else
      @books = Book.order(year_published: :desc)
    end
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
