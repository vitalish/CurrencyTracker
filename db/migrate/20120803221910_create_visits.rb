class CreateVisits < ActiveRecord::Migration
  def self.up
    create_table :visits do |t|
      t.string :country_id
      t.integer :user_id

      t.timestamps
    end
    remove_column :countries, :visited
  end

  def self.down
    add_column :countries, :visited, :boolean, :default => false
    drop_table :visits
  end
end
