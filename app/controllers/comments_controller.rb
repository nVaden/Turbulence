class CommentsController < ApplicationController
  before_action :authenticate_user!, :set_comment, only: [:show, :edit, :update, :destroy, :create]

  respond_to :html, :js

  def index
    @comments = Comment.all
    respond_with(@comment)
  end

  def show
    respond_with(@comment)
  end

  def new
  end

  def edit
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      flash[:success] = "GG EZ"
      redirect_to :back
    else
      flash[:alert] = "wtf man?"
      render root_path
    end
  end

  def update
    @comment.update(comment_params)
   
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    flash[:success] = "Git out of here comment!"
    redirect_to root_path
  end

  private
    def set_comment
      @post = Post.find(params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:content, :image, :post_id, :user_id)
    end
end
