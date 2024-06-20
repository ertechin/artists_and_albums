class Album < ApplicationRecord
  belongs_to :user
  has_many :album_details, dependent: :destroy

  def random_detail
    album_details.sample
  end
end
