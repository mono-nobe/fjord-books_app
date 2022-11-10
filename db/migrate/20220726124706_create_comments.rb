class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, null: false
      t.string     :body,        null: false
      t.integer    :user_id,     null: false

      t.timestamps
    end

    add_foreign_key :comments, :users
  end
end
