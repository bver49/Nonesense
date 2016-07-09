class Folder < ActiveRecord::Base
	belongs_to :user
	def mypost
		@post=Post.where(folder_id: id).order("created_at desc").limit(4)
	end
end
