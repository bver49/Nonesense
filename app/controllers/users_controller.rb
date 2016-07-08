class UsersController < ApplicationController
    def signup
     if current_user
      redirect_to posts_path
     else
       @user = User.new
     end
    end

    def create
    	@user=User.new(user_params)

    	if @user.save
          render :crop
          flash[:success] = "註冊成功"
      else
        flash[:danger] = "註冊失敗"
        render 'signup'
      end
  	end

    def login

    end

    def logout
      session[:user_id]=nil
      flash[:success] = "登出成功"
      redirect_to root_path
    end

    def create_login_session
      user =User.find_by_email(params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id]=user.id
        flash[:success] = "登入成功"
        redirect_to root_path
      else
        flash[:success] = "登入失敗"
        redirect_to :login
      end
    end

    def show
      @user = User.find(params[:id])
    end

    def edit
      @user = current_user
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        if params[:user][:avatar].present?
          render :crop
        else
          flash[:success] = "更新成功"
          redirect_to user_path(@user)
        end
      else
        flash[:danger] = "更新失敗"
        render 'edit'
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      session[:user_id]=nil
      flash[:success] = "刪除帳號成功"
      redirect_to root_path
    end

    def following
      @user = User.where(id:current_user.following).order("created_at desc")
    end

    def explore
      if current_user
        @user = User.where('id != ? AND role > ?', current_user.id,0)
      else
        @user = User.where('role > ?',0)
      end
    end

    def index
      @user = User.where('id != ?', current_user.id)
    end

    def auth
      if !params[:email] || !params[:token]
        redirect_to root_path
      else
        @user = User.find_by_email(params[:email])
        if @user.created_at.to_i.to_s == params[:token]
          @user.role = 1
          @user.save
        else
          redirect_to root_path
        end
      end
    end

    def adminuser
      if current_user.role != 2
        redirect_to root_path
      end
      @user=User.where('id != ?',current_user.id)
    end

    def adminpost
      if current_user.role != 2
        redirect_to root_path
      end
      @post=Post.all
    end

    def admindestroy
      @user = User.find(params[:id])
      @user.destroy
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end

    def upgradeuser
      @user = User.find(params[:id])
      @user.role = 1
      @user.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end

  private
    def user_params
      params.require(:user).permit!
    end
end
