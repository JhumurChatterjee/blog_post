class CommentsController < ApplicationController

  before_action :find_post
  before_action :find_comment, only: [:destroy, :edit, :update, :comment_owner]
  before_action :comment_owner, only: [:destroy, :edit, :update, :create]

  def new
    @comment = @post.comments.build
  end

  def create
    @comments = @post.comments.non_archived
    @comment = @post.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.js
      else
        format.js
      end
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    @comments = @post.comments.non_archived

    respond_to do |format|
      if @comment.update(comment_params)
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    @comments = @post.comments.non_archived

    @comment.destroy
    respond_to do |format|
      format.js
    end
  end


  private
  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_owner
    unless current_user.id == @comment.user.id
      flash[:notice] = "You cannot modify a different users udpates."
      redirect_to @post
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
