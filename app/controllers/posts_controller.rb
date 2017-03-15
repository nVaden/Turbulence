class PostsController < ApplicationController
  before_action :authenticate_user!, :set_post, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js

  def index
    @posts = Post.all
  end

  def show
    respond_with(@post)
  end

  def new
    @post = current_user.posts.build
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.save
    respond_with(@post)
  end

  def update
    @post.update(post_params)
    respond_with(@post)
  end

  def destroy
    
    @post.destroy
    redirect_to posts_path
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:subject, :channel, :user_id)
    end
    
end
