class AddPeopleIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :people_id, :integer
    add_column :videos, :people_type, :string
  end
end
