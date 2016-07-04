class Portfolio < ActiveRecord::Base
	belongs_to :user
	def mypost
		@post=Post.where(portfolio_id: id).order("created_at desc").limit(4)
	end
end
