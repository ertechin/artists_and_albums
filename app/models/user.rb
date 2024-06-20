class User < ApplicationRecord

  has_many :albums, dependent: :destroy
  scope :search_user_name, ->(query) {where('user_name::TEXT ILIKE :query', query: "%#{query}%") }
end
