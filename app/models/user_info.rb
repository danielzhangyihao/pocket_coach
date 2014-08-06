class UserInfo < ActiveRecord::Base
	validates :user_id, presence: true
	belongs_to :user
	validates :school, presence: true
	validates :year, presence: true, :numericality => true
	validates :position, presence: true
	validates :team, presence: true
	validates :weight, presence: true, :numericality => true
	validates :feet, presence: true, :numericality => true
	validates :inches, presence: true, :numericality => true
	validates :description, presence: true
	
end
