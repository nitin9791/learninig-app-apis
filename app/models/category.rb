class Category < ApplicationRecord
	enum status: [:active, :inactive]
	scope :active, -> {where(status: 0)}
	validates :name, uniqueness: true, presence: true
	validates :status, presence: true
end
