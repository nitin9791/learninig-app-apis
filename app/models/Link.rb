class Link < ApplicationRecord
  belongs_to :category
  enum status: [:active, :inactive]
  enum link_type: [:video, :blog, :book]
  validates :name, uniqueness: true, presence: true
  validates :status, presence: true
end
