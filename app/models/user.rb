class User < ApplicationRecord

  scope :search_user_name, ->(query) {where('user_name::TEXT ILIKE :query', query: "%#{query}%") }
end
