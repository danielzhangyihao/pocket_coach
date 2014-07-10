class AddFacilityToInstructors < ActiveRecord::Migration
  def change
    add_column :instructors, :facility, :string
    add_index :instructors, :facility
  end
end
