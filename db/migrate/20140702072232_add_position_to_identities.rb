class AddPositionToIdentities < ActiveRecord::Migration
  def change
    add_column :identities, :position, :string
    add_index :identities, :position
  end
end
