class AuthorsController < ApplicationController
  def index
    @authors = Author.order(:name)
  end

  def show
    @author = Author.find(params[:id])
  end
end
