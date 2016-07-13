class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy
	has_many :taggings
	has_many :tags,through: :taggings

	mount_uploader :image, ImageUploader

	validates_presence_of :title , :message => "請填寫標題"
	validates_presence_of :image , :message => "請上傳圖片"
	validates_presence_of :content,:message => "請填寫內容"

	def likeamt
		Like.where(post_id: id).count
	end

	def self.tagged_with(name)
		Tag.find_by_name!(name).posts
	end

	def self.tag_counts
		Tag.select("tags.*, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id")
	end

	def tag_list
		tags.map(&:name).join("  #")
	end

	def tag_list=(names)
		self.tags = names.split("#").map do |n|
			Tag.where(name: n.strip).first_or_create!
		end
	end
end
