class AddCompanyadminToInstructors < ActiveRecord::Migration
  def change
    add_column :instructors, :companyadmin, :boolean, default:false
  end
end
