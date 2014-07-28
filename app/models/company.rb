class Company < ActiveRecord::Base
	has_many :instructors , dependent: :destroy
	validates :name,  presence: true, uniqueness: true
end
