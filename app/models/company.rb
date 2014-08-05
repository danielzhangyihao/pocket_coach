class Company < ActiveRecord::Base
	has_many :instructors , dependent: :destroy,  :autosave => true
	validates :name,  presence: true, uniqueness: true
end
