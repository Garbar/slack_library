RSpec.describe CategoriesController, type: :controller do
  let!(:category) { create(:category) }

  describe 'GET #index' do

    before { get :index }

    it 'renders index template' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, id: category }

    it 'returns one category object' do
      expect(assigns(:category)).to eq category
    end

    it 'renders show template' do
      expect(response).to render_template :show, id: category
    end
  end


  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    before { get :edit, id: category }
    it "returns http success" do
      get :edit, id: category
      expect(response).to have_http_status(:success)
    end
  end


end
