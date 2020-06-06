class HomeController < ApplicationController
  def index
    @pagy, @posts = pagy_countless(Post.non_archived.order_by_date, link_extra: 'data-remote="true"')
  end
end
