class AddIndexToInstructorsEmail < ActiveRecord::Migration
  def change
  	add_index :instructors, :email, unique: true
  end
end
