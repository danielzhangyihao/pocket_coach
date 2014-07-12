class AddAdminToInstructors < ActiveRecord::Migration
  def change
  	add_column :instructors, :admin, :boolean, default:false
  end
end
