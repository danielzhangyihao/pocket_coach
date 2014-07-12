class AddRememberTokenToInstructors < ActiveRecord::Migration
  def change
  	add_column :instructors, :remember_token, :string
    add_index  :instructors, :remember_token
  end
end
