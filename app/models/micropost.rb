class Micropost < ApplicationRecord
  has_many :comments,dependent: :destroy
  acts_as_votable
  belongs_to :user
  has_one_attached :post_file
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :post_file,presence:false
  def display_image
    post_file.variant(resize_to_limit: [500, 500])
    end
end
