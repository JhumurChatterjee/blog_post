class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = current_user.posts
  end

  def new
    @post = Post.new
  end

  def show
    post
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to post, flash: { success: "Your Post has been successfully created." }
    else
      render "new"
    end
  end

  def edit
    post
  end

  def update
    if post.update(post_params)
      redirect_to post, flash: { success: "Your Post has been successfully updated." }
    else
      render "edit"
    end
  end

  def destroy
    post.destroy
    redirect_to post, flash: { success: "Your Post has been successfully deleted." }
  end

  private

  def post
    @post ||= Post.find(params[:id])
    return @post if @post.user_id == current_user.id

    redirect_to root_path, flash: { danger: "You tried to access unauthorized note." }
  end

  def post_params
    params.require(:post).permit(:title, :body, :archive)
  end
end
