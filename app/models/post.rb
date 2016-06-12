class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy

	mount_uploader :image, ImageUploader

	acts_as_taggable

	validates_presence_of :title , :message => "請填寫標題"
	validates_presence_of :image , :message => "請上傳圖片"
	validates_presence_of :content,:message => "請填寫內容"

	def likeamt
		Like.where(post_id: id).count
	end
end
