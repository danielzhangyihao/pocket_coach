class CompanyInfo < ActiveRecord::Base
	validates :company_id, presence: true
	belongs_to :company
end
