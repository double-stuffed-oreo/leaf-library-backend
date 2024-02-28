class Herb < ApplicationRecord
  belongs_to :user
  validates :name, :summary, :benefit, :warning, :image, presence: true
end
