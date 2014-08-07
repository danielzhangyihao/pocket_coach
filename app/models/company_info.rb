class CompanyInfo < ActiveRecord::Base
	validates :company_id, presence: true
	belongs_to :company
	validates :email, presence: true
    validates :address, presence: true
    validates :telephone, presence: true, :numericality => true
    validates :price, presence: true, :numericality => true
end
