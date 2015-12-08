class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  def index
    # @books = Book.order(:title).includes(:authors).page(params[:page]).per(12)
    @books = Book.order(created_at: :desc).includes(:authors).page(params[:page]).per(12)
    @isbn = IsbnForm.new
  end

  def show
    @file = @book.book_files.build
  end

  def new
    @book =Book.new
  end

  def edit
  end

  def create
    @book =Book.new(book_params)
    respond_to do |format|
      if @book.save
        format.html { redirect_to book_path(@book), notice: 'Book was successfully created.' }
        format.json { render json: {mess: 'ok'}, status: :created }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def get_book
    @isbn = IsbnForm.new(isbn_params)
    respond_to do |format|
      if @isbn.valid?
        isbn = @isbn.to_hash
        # book = ParserService.new(@isbn)
        # book.check_book
        @book = Book.find_or_create_by(isbn: isbn[:isbn])
        format.html { redirect_to book_path(@book), notice: 'Book was successfully created.'  }
      else
        format.html { redirect_to root_path, notice: 'Parser did not work.' }
      end
    end
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def isbn_params
    params.require(:isbn_form).permit(:isbn)
  end
  def book_params
    params.require(:book).permit(:title, :isbn, :published_date, :lang, :description, :author_ids)
  end
end
