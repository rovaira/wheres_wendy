class ChangeSharePhoneToDefaultFalse < ActiveRecord::Migration
  def change
    change_column :users, :share_phone, :boolean, default: 'false'
  end
end
