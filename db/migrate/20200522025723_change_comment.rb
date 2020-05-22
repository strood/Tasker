class ChangeComment < ActiveRecord::Migration[5.2]
  def change

    remove_column :comments, :owner_id
    add_column :comments, :user_id, :bigint, null: false, default: 1
  end
end
