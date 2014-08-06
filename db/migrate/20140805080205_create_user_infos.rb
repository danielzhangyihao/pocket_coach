class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.text :description
      t.integer :feet, limit: 1
      t.integer :inches, limit: 2
      t.decimal :weight, precision: 5, scale: 2
      t.string :school
      t.integer :year, limit:4
      t.string :position
      t.string :team
      t.integer :user_id

      t.timestamps
    end
    add_index :user_infos, :user_id
    add_index :user_infos, :school
    add_index :user_infos, :year
    add_index :user_infos, :position
    add_index :user_infos, :team
  end
end
