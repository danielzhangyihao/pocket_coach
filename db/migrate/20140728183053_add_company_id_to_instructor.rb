class AddCompanyIdToInstructor < ActiveRecord::Migration
  def change
    add_column :instructors, :company_id, :integer
  end

end
