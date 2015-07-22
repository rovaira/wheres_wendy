class RemovePhoneIndex < ActiveRecord::Migration
  def change
    remove_index :users, :phone
  end
end
