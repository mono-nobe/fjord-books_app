class ChangeDataPostCodeToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :post_code, :string
  end
end
