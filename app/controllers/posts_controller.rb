class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :validate_post_owner, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.includes(:categories, :user).page(params[:page]).per(5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = 'Post created successfully'
      redirect_to posts_path
    else
      flash.now[:alert] = 'Post create failed'
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Post updated successfully'
      redirect_to params[:previous_request]
    else
      flash.now[:alert] = 'Post update failed'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = 'Post destroyed successfully'
    redirect_to posts_path
  end
end

private

def set_post
  @post = Post.find(params[:id])
end

def post_params
  params.require(:post).permit(:title, :content, :address, :image, category_ids: [])
end

def validate_post_owner
  unless @post.user == current_user
    flash[:notice] = 'The Post Does Not Belong To You'
    redirect_to posts_path
  end
end