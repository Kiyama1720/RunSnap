class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :post_id
      t.integer :comment_number
      t.boolean :delete_flag, default: false, null: false

      t.timestamps
    end
  end
end
