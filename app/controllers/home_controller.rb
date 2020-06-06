class HomeController < ApplicationController
  def index
    @posts = Post.non_archived
  end
end
