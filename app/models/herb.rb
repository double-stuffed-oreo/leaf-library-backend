class Herb < ApplicationRecord
  belongs_to :user
  validates :name, :summary, :benefit, :warning, :image, :user_id, presence: true
end
