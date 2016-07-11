class FoldersController < ApplicationController
  before_action :check_login,except: %i[myfolder show]
  before_action :find_folder, only: %i[show edit update destroy]

  def myfolder
    @folder= Folder.where("user_id = ?",params[:id])
    @folderownerid = params[:id].to_i
  end

  def show
    @post = Post.where("folder_id = ?",@folder.id)
  end

  def create
    @folder= Folder.new(folder_params)
    @folder.user_id = current_user.id
    if @folder.save
      redirect_to folders_path
    else
      redirect_to folders_path
    end
  end

  def choose_addpost
    @folder=Folder.find(params[:folder_id])
    @post = Post.where("folder_id = ?",0)
  end

  def choose_removepost
    @folder=Folder.find(params[:folder_id])
    @post = Post.where("folder_id = ?",@folder.id)
  end


  def addpost
    @post = Post.find(params[:id])
    @post.folder_id = params[:folder_id]
    @post.save
    respond_to do |format|
      format.html { redirect_to folders_path }
      format.js
    end
  end

  def removepost
    @post = Post.find(params[:id])
    @post.folder_id = 0
    @post.save
    respond_to do |format|
      format.html { redirect_to folder_path }
      format.js
    end
  end

  def destroy
    @post = Post.where(folder_id: @folder.id)
    @post.each do |post|
      post.folder_id = 0
      post.save
    end
    @folder.destroy
    respond_to do |format|
      format.html { redirect_to folder_path }
      format.js
    end
  end
  private
  def find_folder
    @folder=Folder.find(params[:id])
  end

  def folder_params
    params.require(:folder).permit(:title,:about)
  end
end
