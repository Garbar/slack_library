class BookFilesController < ApplicationController
  before_action :set_file, only: [:update, :destroy]
  def create
    @book = Book.find(params[:book_id])
    @file = @book.book_files.build(file_params)
    respond_to do |format|
      if @file.save
        format.html { redirect_to book_path(@book), notice: 'File was successfully added.' }
        format.json { render json: {mess: 'ok'}, status: :created }
      else
        format.html { render :new }
        format.json { render json: @file.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

  end

  def destroy

  end

  private
  def set_file
    @file = BookFile.find(params[:id])
    @book = Book.find(params[:book_id])
  end

  def file_params
    params.require(:book_file).permit(:title, :file, :format, :book_id)
  end
end
