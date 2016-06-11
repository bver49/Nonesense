class User < ActiveRecord::Base
    has_secure_password

    mount_uploader :avatar, AvatarUploader
    attr_accessor :crop_x, :crop_y,:crop_w,:crop_h
    after_update :crop_avatar
    def crop_avatar
      avatar.recreate_versions! if crop_x.present?
    end

    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :follower_relationships, foreign_key: :following_id, class_name: 'Relationship'
    has_many :followers, through: :follower_relationships, source: :follower
    has_many :following_relationships, foreign_key: :follower_id, class_name: 'Relationship'
    has_many :following, through: :following_relationships, source: :following

    validates_length_of :password, :minimum => 8 , :message => "密碼長度須大於8", on: :create
    validates_uniqueness_of :email, :message => "信箱已被使用", on: :create
    validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, :message => "請輸入信箱"
    validates_presence_of :avatar , :message => "請上傳大頭照"
    validates_presence_of :name , :message => "請填寫名稱"
    validates_presence_of :about,:message => "請填寫自我介紹"

    def follow(user_id)
      following_relationships.create(following_id: user_id)
    end
    def unfollow(user_id)
      following_relationships.find_by(following_id: user_id).destroy
    end

    def mypost
      @post=Post.where(user_id: id).order("created_at desc")
    end
end
