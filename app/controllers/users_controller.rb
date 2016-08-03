class UsersController < ApplicationController
    def index
      @category=1
      if current_user
        if(params[:order]=='hot')
          if(params.has_key?(:c))
            @user = User.where('id != ? AND role > ? AND category LIKE ?', current_user.id,0,"%#{params[:c]}%").order("view DESC")
          else
            @user = User.where('id != ? AND role > ?', current_user.id,0).order("view DESC")
          end
        else
          if(params.has_key?(:c))
            @user = User.where('id != ? AND role > ? AND category LIKE ?', current_user.id,0,"%#{params[:c]}%").order("created_at DESC")
          else
            @user = User.where('id != ? AND role > ?', current_user.id,0).order("created_at DESC")
          end
        end
      else
        if(params[:order]=='hot')
          if(params.has_key?(:c))
            @user = User.where('role > ? AND category LIKE ?',0,"%#{params[:c]}%").order("view DESC")
          else
            @user = User.where('role > ?',0).order("view DESC")
          end
        else
          if(params.has_key?(:c))
            @user = User.where('role > ? AND category LIKE ?',0,"%#{params[:c]}%").order("created_at DESC")
          else
            @user = User.where('role > ?',0).order("created_at DESC")
          end
        end
      end
    end

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
          flash[:success] = "註冊成功"
          render :crop
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
        user.logincount+=1
        user.save
        redirect_to posts_path
      else
        flash[:success] = "登入失敗"
        redirect_to :login
      end
    end

    def show
      @controlpanel=0
      @show = 1
      @user = User.find(params[:id])
      @user.view+=1
      @user.save
      @post = Post.includes(:user).where(user_id: @user.id).order("created_at DESC")
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
          redirect_to :back
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
      @show = 1;
      @user=User.find(params[:id]) #follower
      @users = User.where(id:@user.following).order("created_at desc")
    end

    def draw
      @c = params[:c]
      @sql="id != ? AND ("
      @c.each_char do |c|
        @sql=@sql+' category LIKE '+"'%"+c+"%' "
        if(c != @c[-1, 1])
          @sql+="OR"
        end
      end
      @sql+=" )"
      @user=User.where(@sql,current_user.id)

      @sql2=""
      @user.each do |u|
        @sql2=@sql2+"user_id = " + u.id.to_s
        if(u.id != @user.last.id)
          @sql2+=" OR "
        end
      end
      @post=Post.where(@sql2).order("RAND()").limit(3)
      respond_to do |format|
        format.html  { render layout: false }
      end
    end

    #for admin
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
        format.js
      end
    end

    def upgradeuser
      @user = User.find(params[:id])
      @user.role = 1
      @user.save
      respond_to do |format|
        format.js
      end
    end

  private
    def user_params
      params.require(:user).permit!
    end
end
