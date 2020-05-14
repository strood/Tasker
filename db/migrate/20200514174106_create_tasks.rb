class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.bigint :user_id, null: false
      t.string :title, null: false
      t.text :description, null: false
      t.boolean :private, default: false
      t.boolean :completed, default: false

      t.timestamps
    end

    add_index :tasks, :user_id
  end
end
