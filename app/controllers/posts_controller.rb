class PostsController < ApplicationController
  before_action :check_login,only: %i[new edit update destroy create]
  before_action :find_post, only: %i[show edit update destroy]

  def index
    if current_user
      @post = Post.where(user_id: current_user.following).order("created_at desc")
    else
      @post = Post.all
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post= Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to root_path
    else
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
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user) }
      format.js
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
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
