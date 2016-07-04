class PortfoliosController < ApplicationController
  before_action :check_login
  before_action :find_portfolio, only: %i[show edit update destroy]
  def index
    @portfolio= Portfolio.where("user_id = ?",current_user.id)
  end

  def show
    @post = Post.where("portfolio_id = ?",@portfolio.id)
  end

  def create
    @portfolio= Portfolio.new(portfolio_params)
    @portfolio.user_id = current_user.id
    if @portfolio.save
      redirect_to portfolios_path
    else
      redirect_to portfolios_path
    end
  end

  def choose_addpost
    @portfolio=Portfolio.find(params[:portfolio_id])
    @post = Post.where("portfolio_id = ?",0)
  end

  def choose_removepost
    @portfolio=Portfolio.find(params[:portfolio_id])
    @post = Post.where("portfolio_id = ?",@portfolio.id)
  end


  def addpost
    @post = Post.find(params[:id])
    @post.portfolio_id = params[:portfolio_id]
    @post.save
    respond_to do |format|
      format.html { redirect_to portfolios_path }
      format.js
    end
  end

  def removepost
    @post = Post.find(params[:id])
    @post.portfolio_id = 0
    @post.save
    respond_to do |format|
      format.html { redirect_to portfolios_path }
      format.js
    end
  end

  def destroy
    @post = Post.where(portfolio_id: @portfolio.id)
    @post.each do |post|
      post.portfolio_id = 0
      post.save
    end
    @portfolio.destroy
    respond_to do |format|
      format.html { redirect_to portfolios_path }
      format.js
    end
  end
  private
  def find_portfolio
    @portfolio=Portfolio.find(params[:id])
  end

  def portfolio_params
    params.require(:portfolio).permit(:title,:about)
  end
end
