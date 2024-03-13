class Studio < ApplicationRecord
  has_many :stays

  validates :name, presence: true, uniqueness: true
end
