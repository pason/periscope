class CreateMarkers < ActiveRecord::Migration
  def change
    create_table :markers do |t|
    	t.references :user
    	t.text :description
    	t.integer :pin_type, :null => false, :default => 1
    	t.integer :privacy, :null => false, :default => 1
    end

    add_index :markers, :user_id
  end
end
