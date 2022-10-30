class Micropost < ApplicationRecord
  acts_as_votable
  belongs_to :user
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :image,presence:false
  def display_image
    image.variant(resize_to_limit: [500, 500])
    end
end
