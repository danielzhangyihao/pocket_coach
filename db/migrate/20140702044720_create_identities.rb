class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :school_facility
      t.integer :user_id

      t.timestamps
    end
    add_index :identities, [:user_id, :school_facility]
  end
end
