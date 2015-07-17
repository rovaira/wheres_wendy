class AddExtraUserColumns < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :class_year, :integer, null: false
    add_column :users, :blurb, :string
    add_column :users, :phone, :string
    add_column :users, :share_phone, :boolean, null: false
    add_column :users, :location, :string
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
    add_index :users, :phone, unique: true
  end
end
