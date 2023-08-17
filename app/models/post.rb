class Post < ApplicationRecord
    belongs_to :user
    has_many :post_categories
    has_many :categories, through: :post_categories
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy
    validates :title, presence:true, length: {minimum:5, maximum:100}
    validates :topic, presence:true, length: {minimum:5, maximum:100}
    validates :text,  presence:true, length: {minimum:5, maximum:1000}
end