class User < ApplicationRecord
    before_save  {self.email = email.downcase}
    has_many :posts, dependent: :destroy
    has_many :likes, dependent: :destroy

    has_one :profile
    has_many :playlists

    has_many :saved_posts

    has_many :follower_relationships, class_name: 'Follower', foreign_key: 'follower_id'
    has_many :following_relationships, class_name: 'Follower', foreign_key: 'following_id'

    has_many :followers, through: :following_relationships, source: :follower_user
    has_many :following, through: :follower_relationships, source: :following_user
    validates :username, presence:true, 
                           uniqueness: { case_sensitive: false }, 
                           length: { minimum: 3, maximum: 25 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, 
                         uniqueness: { case_sensitive: false }, 
                         length: { maximum: 105 }, 
                         format: { with: VALID_EMAIL_REGEX }

    has_secure_password

    def follow(other_user)
        following << other_user
    end
    
    def unfollow(other_user)
        following.delete(other_user)
    end
    
    def following?(other_user)
        following.include?(other_user)
    end
end


