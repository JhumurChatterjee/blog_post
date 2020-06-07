require "rails_helper"

RSpec.describe PostsController do
  let!(:user)     { create(:user) }
  let!(:new_post) { create(:post, user: user) }

  describe "GET index" do
    it "requires login" do
      sign_out user
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it "returns http status 200" do
      sign_in user
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
        get :index, params: { tag: "Demo" }
        expect(assigns(:posts)).to eq([new_post])
        expect(assigns(:posts).include?(new_post)).to eq(true)
        expect(assigns(:posts).include?(post1)).to eq(false)
      end
    end
  end

  describe "GET #new" do
    it "requires login" do
      sign_out user
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end

    it "returns http status 200" do
      sign_in user
      get :new, params: { id: new_post.id }
      expect(response).to have_http_status(:ok)
    end

    it "assigns a new post to an instance variable" do
      sign_in user
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "GET #show" do
    let!(:user1) { create(:user) }
    let!(:post1) { create(:post, user: user1, archive: true) }

    context "when user not logged in" do
      it "returns http status 200 for valid post" do
        sign_in user
        get :show, params: { id: new_post.id }
        expect(response).to have_http_status(:ok)
      end

      it "assigns the requested post to an instance variable" do
        sign_in user
        get :show, params: { id: new_post.id }
        expect(assigns(:post)).to eq(new_post)
      end

      it "redirect to root path for unauthorized post" do
        sign_in user
        get :show, params: { id: post1.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #edit" do
    let!(:user1) { create(:user) }
    let!(:post1) { create(:post, user: user1) }

    it "requires login" do
      sign_out user
      get :edit, params: { id: new_post.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    context "with authorized id" do
      it "returns http status 200" do
        sign_in user
        get :edit, params: { id: new_post.id }
        expect(response).to have_http_status(:ok)
      end

      it "assigns the requested post to an instance variable" do
        sign_in user
        get :edit, params: { id: new_post.id }
        expect(assigns(:post)).to eq(new_post)
      end
    end

    context "with unauthorized id" do
      it "returns http status 200" do
        sign_in user
        get :edit, params: { id: post1.id }
        expect(response).to have_http_status(:found)
      end

      it "assigns the requested post to an instance variable" do
        sign_in user
        get :edit, params: { id: post1.id }
        expect(assigns(:post)).to eq(post1)
      end

      it "redirect to root_path" do
        sign_in user
        get :edit, params: { id: post1.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST #create" do
    it "requires login" do
      sign_out user
      post :create, params: { post: { title: "Hello World", body: "How are you?", user_id: user.id } }
      expect(response).to redirect_to(new_user_session_path)
    end

    context "with valid attributes" do
      it "saves the new post in the database" do
        sign_in user
        expect {
          post :create, params: { post: { title: "Hello World", body: "How are you?", user_id: user.id } }
        }.to change(Post, :count).by(1)
      end

      it "returns http status 302" do
        sign_in user
        post :create, params: { post: { title: "Hello World", body: "How are you?", user_id: user.id } }
        expect(response).to have_http_status(:found)
      end

      it "assigns a newly created but unsaved post to an instance variable" do
        sign_in user
        post :create, params: { post: { title: "Hello World", body: "How are you?", user_id: user.id } }
        expect(assigns(:post)).to be_a(Post)
        expect(assigns(:post)).to be_persisted
      end

      it "redirects to post show page" do
        sign_in user
        post :create, params: { post: { title: "Hello World", body: "How are you?", user_id: user.id } }
        expect(response).to redirect_to(post_path(assigns(:post)))
      end
    end

    context "with invalid attributes" do
      it "does not save the new post in the database" do
        sign_in user
        expect{
          post :create, params: { post: { title: "", body: "How are you?", user_id: user.id } }
        }.not_to change(Post, :count)
      end

      it "assigns a newly created but unsaved post an instance variable" do
        sign_in user
        post :create, params: { post: { title: "", body: "How are you?", user_id: user.id } }
        expect(assigns(:post)).to be_a_new(Post)
      end

      it "returns http status 200" do
        sign_in user
        post :create, params: { post: { title: "", body: "How are you?", user_id: user.id } }
        expect(response).to have_http_status(:ok)
      end

      it "re-renders the :new template" do
        sign_in user
        post :create, params: { post: { title: "", body: "How are you?", user_id: user.id } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    it "requires login" do
      sign_out user
      patch :update, params: { id: new_post.id, post: { title: "Hello World", body: "How are you?" } }
      expect(response).to redirect_to(new_user_session_path)
    end

    context "with valid attributes" do
      it "updates the requested post" do
        sign_in user
        patch :update, params: { id: new_post.id, post: { title: "Hello World", body: "How are you?" } }
        new_post.reload
        expect(new_post.title).to eq("Hello World")
        expect(new_post.body).to eq("How are you?")
      end

      it "returns http status 302" do
        sign_in user
        patch :update, params: { id: new_post.id, post: { title: "Hello World", body: "How are you?" } }
        expect(response).to have_http_status(:found)
      end

      it "assigns the requested post to an instance variable" do
        sign_in user
        patch :update, params: { id: new_post.id, post: { title: "Hello World", body: "How are you?" } }
        expect(assigns(:post)).to eq(new_post)
      end

      it "redirects to post show page" do
        sign_in user
        patch :update, params: { id: new_post.id, post: { title: "Hello World", body: "How are you?" } }
        expect(response).to redirect_to(post_path(new_post))
      end
    end

    context "with invalid attributes" do
      it "does not update the requested post" do
        sign_in user
        expect {
          patch :update, params: { id: new_post.id, post: { title: "", body: "How are you?" } }
        }.not_to change { new_post.reload.attributes }
      end

      it "assigns the post to an instance variable" do
        sign_in user
        patch :update, params: { id: new_post.id, post: { title: "", body: "How are you?" } }
        expect(assigns(:post)).to eq(new_post)
      end

      it "returns http status 200" do
        sign_in user
        patch :update, params: { id: new_post.id, post: { title: "", body: "How are you?" } }
        expect(response).to have_http_status(:ok)
      end

      it "re-renders the :edit template" do
        sign_in user
        patch :update, params: { id: new_post.id, post: { title: "", body: "How are you?" } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "requires login" do
      sign_out user
      delete :destroy, params: { id: new_post.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "returns http status 302" do
      sign_in user
      delete :destroy, params: { id: new_post.id }
      expect(response).to have_http_status(:found)
    end

    it "deletes the post" do
      sign_in user
      expect{
        delete :destroy, params: { id: new_post.id }
      }.to change(Post, :count).by(-1)
    end

    it "redirects to post show page" do
      sign_in user
      delete :destroy, params: { id: new_post.id }
      expect(response).to redirect_to(posts_path)
    end
  end
end
