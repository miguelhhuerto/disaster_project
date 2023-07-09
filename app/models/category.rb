class Category < ApplicationRecord
    validates :name, presence: true
    validates_associated :category

    has_many :post_category_ships
    has_many :posts, through: :post_category_ships
end
