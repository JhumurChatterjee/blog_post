class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment_hash = params[:comment]
    obj = comment_hash[:commentable_type].constantize.find(comment_hash[:commentable_id])
    @comment = Comment.build_from(obj, current_user.id, comment_hash[:body])

    if @comment.save
      render "create"
    else
      render js: "alert('Something happened wrong..!!');"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.destroy
      render "delete"
    else
      render js: "alert('Something happened wrong..!!');"
    end
  end
end
