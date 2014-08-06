class CreateCompanyInfos < ActiveRecord::Migration
  def change
    create_table :company_infos do |t|
      t.text :description
      t.string :address
      t.integer :company_id
      t.integer :telephone
      t.string :email
      t.decimal :price , precision: 6, scale: 2

      t.timestamps
    end
    add_index :company_infos, :company_id
    add_index :company_infos, :email
  end
end
