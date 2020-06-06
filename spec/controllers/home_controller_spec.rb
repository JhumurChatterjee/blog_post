require "rails_helper"

RSpec.describe HomeController do
  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "returns http status 200" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end
end
