class Post < ApplicationRecord
  default_scope { where(deleted_at: nil) }

  validates :title, presence: true
  validates :content, presence: true
  validates :address, presence: true
  validates_length_of :categories, maximum: 3

  has_many :comments
  has_many :post_category_ships
  has_many :categories, through: :post_category_ships
  has_one :photo
  belongs_to :user
  
  mount_uploader :image, ImageUploader
  def destroy
    update(deleted_at: Time.now)
  end
end