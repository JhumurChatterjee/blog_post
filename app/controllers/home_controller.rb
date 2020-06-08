class HomeController < ApplicationController
  def index
    if params[:tag].present?
      posts = Post.non_archived.tagged_with(params[:tag])
    elsif params[:search].present?
      posts = Post.non_archived.find_posts(params[:search])
    else
      posts = Post.non_archived
    end

    @pagy, @posts = pagy_countless(posts.includes(:tags).order_by_date, link_extra: 'data-remote="true"')
  end
end
