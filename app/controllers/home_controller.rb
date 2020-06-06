class HomeController < ApplicationController
  def index
    if params[:tag].present?
      posts = Post.tagged_with(params[:tag])
    else
      posts = Post.non_archived
    end

    @pagy, @posts = pagy_countless(posts.includes(:tags).order_by_date, link_extra: 'data-remote="true"')
  end
end
