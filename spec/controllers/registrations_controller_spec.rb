require "rails_helper"

RSpec.describe RegistrationsController, type: :controller do
  let!(:user) { create(:user) }

  before :each do
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "GET check_email_duplicacy" do
    context "when we are passing valid email" do
      it "returns http status 200" do
        get :check_email_duplicacy, params: { email: "jhumur@gmail.com", format: :json }
        expect(response).to have_http_status(:ok)
      end

      it "returns json data with a vaild message" do
        get :check_email_duplicacy, params: { email: "jhumur@gmail.com", format: :json }
        expect(JSON.parse(response.body)["message"]).to eq(I18n.t("valid_email"))
      end
    end

    context "when we are passing invalid email" do
      it "returns http status 422" do
        get :check_email_duplicacy, params: { email: user.email, format: :json }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns json data with a invaild message" do
        get :check_email_duplicacy, params: { email: user.email, format: :json }
        expect(JSON.parse(response.body)["message"]).to eq(I18n.t("invalid_email"))
      end
    end
  end
end
