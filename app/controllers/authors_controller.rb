class AuthorsController < ApplicationController
  before_action :set_author, only: %i[ show edit update destroy ]

  def oop_counts
    @oop_counts = Author.joins(:books)
                        .select('authors.first_name, authors.last_name, count(books.out_of_print) as oop_count')
                        .where('books.out_of_print' => true)
                        .group('authors.id')
  end


  # GET /authors or /authors.json
  def index
    if params[:book_count]
      @authors = Author.joins(:books)
                       .select('authors.id, authors.first_name, authors.last_name')
                       .group('books.author_id')
                       .having('count(books.title) >= ?', params[:book_count].to_i)
    else
      @authors = Author.all
    end
  end

  # GET /authors/1 or /authors/1.json
  def show
  end

  # GET /authors/new
  def new
    @author = Author.new
  end

  # GET /authors/1/edit
  def edit
  end

  # POST /authors or /authors.json
  def create
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        format.html { redirect_to author_url(@author), notice: "Author was successfully created." }
        format.json { render :show, status: :created, location: @author }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authors/1 or /authors/1.json
  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to author_url(@author), notice: "Author was successfully updated." }
        format.json { render :show, status: :ok, location: @author }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/1 or /authors/1.json
  def destroy
    @author.destroy

    respond_to do |format|
      format.html { redirect_to authors_url, notice: "Author was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # Count the number of books written by each author.
  def book_count
    @book_count = Author.joins(:books).group('authors.first_name', 'authors.last_name').count
    render :book_count, status: :ok
  end

  # List all authors and their books.
  def all_books
    @authors = Author.joins('INNER JOIN books ON authors.id = books.author_id')
                     .select('authors.first_name, authors.last_name, books.title')
    render :all_books, status: :ok
  end

  # List all titles of books with price in the given range along with the author name.
  def books_in_price_range
    price_range = params[:low]..params[:high]
    @authors_and_books = Author.joins(:books).where(books: { price: price_range })
                               .select('authors.first_name, authors.last_name, books.title, books.price')
    render :books_in_price_range, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def author_params
      params.require(:author).permit(:first_name, :last_name)
    end
end
