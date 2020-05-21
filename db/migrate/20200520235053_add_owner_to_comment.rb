class AddOwnerToComment < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :owner_id, :bigint, null: false
  end
end
