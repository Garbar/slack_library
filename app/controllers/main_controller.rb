class MainController < ApplicationController
  def index
    @books = Book.order(:title).includes(:authors).page(params[:page]).per(12)
  end
end
