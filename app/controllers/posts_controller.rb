class PostsController < ApplicationController
  before_action :authenticate_user!, except: :show

  def index
    if params[:tag].present?
      posts = current_user.posts.tagged_with(params[:tag])
    else
      posts = current_user.posts.non_archived
    end

    @pagy, @posts = pagy_countless(posts.includes(:tags).order_by_date, link_extra: 'data-remote="true"')
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])

    redirect_to root_path, flash: { danger: "You tried to access unauthorized post." } if @post.archive? && @post.user_id != current_user&.id
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

    redirect_to root_path, flash: { danger: "You tried to access unauthorized post." }
  end

  def post_params
    params.require(:post).permit(:title, :body, :archive, :tag_list)
  end
end
