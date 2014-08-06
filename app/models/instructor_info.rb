class InstructorInfo < ActiveRecord::Base
	validates :instructor_id, presence: true
	belongs_to :instructor
end
