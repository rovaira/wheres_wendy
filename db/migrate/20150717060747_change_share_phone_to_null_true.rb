class ChangeSharePhoneToNullTrue < ActiveRecord::Migration
  def change
    change_column_null :users, :share_phone, true
  end
end
