class Post < ApplicationRecord
    belongs_to :user
    has_many :post_categories
    has_many :categories, through: :post_categories
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy
    
    has_many :saved_posts
    scope :draft, -> { where(published_at: nil) } # Corrected scope definition
    has_many :post_revisions, dependent: :destroy
    has_and_belongs_to_many :playlists
    
    validates :title, presence: true, length: { minimum: 5, maximum: 100 }
    validates :topic, presence: true, length: { minimum: 5, maximum: 100 }
    validates :text, presence: true, length: { minimum: 5, maximum: 1000 }
end
