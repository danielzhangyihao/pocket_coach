class Identity < ActiveRecord::Base
	 belongs_to :user
	 validates :school_facility, presence: true
	 validates :user_id, presence: true
	 validates :position, presence: true
	
end
