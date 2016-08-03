class Folder < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :title
	validates_presence_of :about
	def mypost
		@post=Post.where(folder_id: id).order("created_at desc").limit(4)
	end
end
