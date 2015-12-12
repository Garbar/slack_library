class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :comment, :get_book_from]
  def index
    # @books = Book.order(:title).includes(:authors).page(params[:page]).per(12)
    @books = Book.order(created_at: :desc).includes(:authors).page(params[:page]).per(12)
    @isbn = IsbnForm.new
  end

  def show
    @file = @book.book_files.build
    @comment = Review.new
    @reviews = Review.where(book_id: @book.id).includes(:user).order("created_at DESC")
    .page(params[:page]).per(6)
    respond_to do |format|
      format.html # show.html.erb
      format.json
      format.js
    end
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

  def get_book_from
    book = ParserService.new(params[:site], @book)
    book.check_book
    respond_to do |format|
      format.html { redirect_to :back }
      format.json
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
  def comment
    @comment = current_user.reviews.build(comment_params)
    @comment.book_id = @book.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to :back }
        format.json
        format.js
      else
        format.html { redirect_to :back }
        format.json
        format.js
      end
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
    params.require(:book).permit(:title, :isbn, :date_published, :lang, :description, :author_ids,
                                 :category_ids => []
                                 )
  end

  def comment_params
    params.require(:review).permit(:text)
  end

end
