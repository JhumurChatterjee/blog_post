require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  let!(:user)        { create(:user) }
  let!(:new_post)    { create(:post, user: user) }
  let!(:new_comment) { create(:comment, commentable_id: new_post.id, user: user) }

  describe "POST #create" do
    it "requires login" do
      sign_out user
      post :create, params: { comment: { body: "Hello World", commentable_id: new_post.id, commentable_type: "Post", user: user } }
      expect(response).to redirect_to(new_user_session_path)
    end

    context "with valid attributes" do
      it "saves the new comment in the database" do
        sign_in user
        expect {
          post :create, params: { comment: { body: "Hello World", commentable_id: new_post.id, commentable_type: "Post", user: user }, format: "js" }
        }.to change(Comment, :count).by(1)
      end

      it "returns http status 200" do
        sign_in user
        post :create, params: { comment: { body: "Hello World", commentable_id: new_post.id, commentable_type: "Post", user: user }, format: "js" }
        expect(response).to have_http_status(:ok)
      end

      it "assigns a newly created but unsaved comment to an instance variable" do
        sign_in user
        post :create, params: { comment: { body: "Hello World", commentable_id: new_post.id, commentable_type: "Post", user: user }, format: "js" }
        expect(assigns(:comment)).to be_a(Comment)
        expect(assigns(:comment)).to be_persisted
      end
    end

    context "with invalid attributes" do
      it "does not save the new comment in the database" do
        sign_in user
        expect{
          post :create, params: { comment: { body: nil, commentable_id: new_post.id, commentable_type: "Post", user: user }, format: "js" }
        }.not_to change(Comment, :count)
      end

      it "assigns a newly created but unsaved comment an instance variable" do
        sign_in user
        post :create, params: { comment: { body: nil, commentable_id: new_post.id, commentable_type: "Post", user: user }, format: "js" }
        expect(assigns(:comment)).to be_a_new(Comment)
      end

      it "returns http status 200" do
        sign_in user
        post :create, params: { comment: { body: nil, commentable_id: new_post.id, commentable_type: "Post", user: user }, format: "js" }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "DELETE #destroy" do
    it "requires login" do
      sign_out user
      delete :destroy, params: { id: new_comment.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "returns http status 200" do
      sign_in user
      delete :destroy, params: { id: new_comment.id, format: :js }
      expect(response).to have_http_status(:ok)
    end

    it "deletes the post" do
      sign_in user
      expect{
        delete :destroy, params: { id: new_comment.id, format: :js }
      }.to change(Comment, :count).by(-1)
    end
  end
end
