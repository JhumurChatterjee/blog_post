class HomeController < ApplicationController
  def index
    @pagy, @posts = pagy_countless(Post.non_archived.includes(:tags).order_by_date, link_extra: 'data-remote="true"')
  end
end
