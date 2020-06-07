require "rails_helper"

RSpec.describe HomeController, type: :controller do
  let!(:user) { create(:user) }
  let!(:new_post) { create(:post, tag_list: "Rspec, Hello", user: user) }

  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "returns http status 200" do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it "populates instance variable with an array of posts" do
      sign_in user
      get :index
      expect(assigns(:posts)).to eq([new_post])
    end

    context "when we are passing tag params" do
      it "populates instance variable with an array of posts with this tag" do
        post1 = create(:post, tag_list: "World", user: user)
        sign_in user
        get :index, params: { tag: "Rspec" }
        expect(assigns(:posts)).to eq([new_post])
        expect(assigns(:posts).include?(new_post)).to eq(true)
        expect(assigns(:posts).include?(post1)).to eq(false)
      end
    end

    context "when we are passing search params" do
      it "populates instance variable with an array of posts with this tag" do
        post1 = create(:post, tag_list: "World", user: user)
        sign_in user
        post :index, params: { search: "Rspec" }
        expect(assigns(:posts).kind_of?(Array)).to eq(true)
      end
    end
  end
end
