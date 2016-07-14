class PostsController < ApplicationController
  before_action :check_login,only: %i[new edit update destroy create]
  before_action :find_post, only: %i[show edit update destroy]

  def index
    if current_user
      @post = Post.includes(:user).where(user_id: current_user.following).order("created_at DESC")
    else
      @post = Post.includes(:user).all.order("created_at DESC")
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post= Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "發表成功"
      redirect_to user_path(current_user)
    else
      flash[:danger] = "發表失敗"
      render 'new'
    end
  end

  def show
    if current_user
      @userlike = @post.likes.find_by_user_id(current_user.id)
    end
    @comments = @post.comments

    respond_to do |format|
      format.html  { render layout: false }
      format.js
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "刪除成功"
    respond_to do |format|
      format.html { redirect_to user_path(current_user) }
      format.js
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "更新成功"
      redirect_to user_path(current_user)
    else
      flash[:danger] = "更新失敗"
      render 'edit'
    end
  end

  private
    def find_post
      @post=Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title,:content,:image,:tag_list,:folder_id)
    end
end
