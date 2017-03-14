class SubCategory < ApplicationRecord
	belongs_to :category
	enum status: [:active, :inactive]
	scope :active, -> {where(status: 0)}
	validates :name, uniqueness: true, presence: true
	validates :status, presence: true
	validates :category_id, presence: true
end
