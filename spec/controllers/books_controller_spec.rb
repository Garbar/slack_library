require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let!(:book) { create(:book) }
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    before { get :show, id: book }
    it "returns http success" do
      get :show, id: book
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    # before { get :edit, id: book }
    it "returns http success" do
      get :edit, id: book
      expect(response).to have_http_status(:success)
    end
  end

end
