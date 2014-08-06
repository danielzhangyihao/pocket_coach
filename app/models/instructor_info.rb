class InstructorInfo < ActiveRecord::Base
	validates :instructor_id, presence: true
	belongs_to :instructor
	validates :description, presence: true
	validates :price, presence: true, :numericality => true
end
