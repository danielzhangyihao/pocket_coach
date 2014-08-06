class CreateInstructorInfos < ActiveRecord::Migration
  def change
    create_table :instructor_infos do |t|
      t.text :description
      t.decimal :price, precision: 6, scale: 2
      t.integer :instructor_id

      t.timestamps
    end
    add_index :instructor_infos, [:instructor_id, :price]
  end
end
